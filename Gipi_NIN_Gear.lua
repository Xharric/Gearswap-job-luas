-------------------------------------------------------------------------------------------------------------------
-- (Original: Motenten / Modified: Arislan)
-------------------------------------------------------------------------------------------------------------------

--[[    Custom Features:

        Haste Detection        Detects current magic haste level and equips corresponding engaged set to
                            optimize delay reduction (automatic)
        Haste Mode            Toggles between Haste II and Haste I recieved, used by Haste Detection [WinKey-H]
        Capacity Pts. Mode    Capacity Points Mode Toggle [WinKey-C]
        Auto. Lockstyle        Automatically locks specified equipset on file load
--]]


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Migawari = buffactive.migawari or false
    state.Buff.Doom = buffactive.doom or false
    state.Buff.Yonin = buffactive.Yonin or false
    state.Buff.Innin = buffactive.Innin or false
    state.Buff.Futae = buffactive.Futae or false

    state.HasteMode = M{['description']='Haste Mode', 'Haste II', 'Haste I'}

    determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('STP', 'Normal', 'LowAcc', 'MidAcc', 'HighAcc', 'Fodder')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT')
    state.PhysicalDefenseMode:options('PDT', 'Evasion')
	
    state.CP = M(false, "Capacity Points Mode")
    state.TH = M(false, "Treasure Hunter Mode")

    -- Additional local binds

    send_command('bind @h gs c cycle HasteMode')
    send_command('bind @c gs c toggle CP')
    send_command('bind @t gs c toggle TH')

    select_movement_feet()
    select_default_macro_book()
    set_lockstyle()
end

function user_unload()
    send_command('unbind ^-')
    send_command('unbind ^=')
	send_command('unbind @/')
    send_command('unbind @h')
    send_command('unbind @c')
    send_command('unbind @t')
    send_command('unbind ^numlock')
    send_command('unbind !numlock')
    send_command('unbind ^numpad/')
    send_command('unbind !numpad/')
    send_command('unbind ^numpad*')
    send_command('unbind ^numpad-')
    send_command('unbind ^numpad+')
    send_command('unbind !numpad+')
    send_command('unbind ^numpad7')
    send_command('unbind ^numpad8')
    send_command('unbind ^numpad4')
    send_command('unbind ^numpad6')
    send_command('unbind ^numpad1')
    send_command('unbind ^numpad2')
    send_command('unbind ^numpad3')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------

	include('Gipi_augmented-items.lua')
	
    -- Enmity set
	sets.enmity = {
		ammo="Staunch tathlum",
		head=gear.HercHeadDT,
		neck="Unmoving collar +1",
		ear1="Cryptic earring",
		ear2="Trux earring",
		body="Emet Harness +1",
		hands="Kurys gloves",
		ring1="Supershear ring",
		ring2="Eihwaz ring",
		back="Agema cape",
		waist="Kasiri belt",
		legs="Ayanmo cosciales +1",
		feet="Ahosi leggings"
		}

    sets.precast.JA['Provoke'] = sets.enmity
	sets.precast.JA['Mijin Gakure'] = {legs="Mochizuki Hakama"}
    sets.precast.JA['Futae'] = {legs="Iga Tekko +2"}
    sets.precast.JA['Sange'] = {body="Mochi. Chainmail +1"}

    sets.precast.Waltz = {
        ammo="Yamarang",
		head="Anwig Salade",
        body="Passion Jacket",
        legs="Dashing Subligar",
        }
        
    sets.precast.Waltz['Healing Waltz'] = {}
	
    sets.precast.Step = {
        head="Whirlpool Mask",neck="Ej Necklace",
        body="Otronif Harness +1",hands="Buremte Gloves",ring1="Patricius Ring",
        back="Yokaze Mantle",waist="Chaac Belt",legs="Manibozho Brais",feet="Otronif Boots +1"}
		
	sets.precast.Flourish1 = sets.enmity

    -- Fast cast sets for spells
    
    sets.precast.FC = {
		ammo="Sapience orb",
		head=gear.HercHeadFC,
		neck="Orunmila's torque",
		ear1="Enchanter earring +1",
		ear2="Loquacious Earring",
		body="Adhemar Jacket",
		hands="Leyline gloves",
		ring1="Kishar ring",
		ring2="Lebeche ring",
		back="Swith cape",
		legs=gear.HercLegsFC,
		feet=gear.HercFeetFC
		}
    
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
		ammo="Impatiens",
		neck="Magoraga Beads",
		body="Passion Jacket",
		})

    sets.precast.RA = {
        legs="Adhemar Kecks", --9
        }
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo="Seeth. Bomblet +1",
        head="Adhemar Bonnet +1",
		neck="Fotia Gorget",
        ear1="Brutal Earring",
        ear2="Moonshade Earring",        
        body="Adhemar Jacket +1",
		hands="Adhemar Wristbands +1",
        ring1="Regal Ring",
        ring2="Shukuyu Ring",
        back=gear.AndartiaTP,
        waist="Fotia Belt",		
		legs="Samnuha Tights",
        feet=gear.HercFeetTP,
        }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
		ear1="Telos Earring",
		ring2="Ilabrat Ring",
        })

    sets.precast.WS['Blade: Hi'] = {
        ammo="Yetshila",
        head="Adhemar Bonnet +1",
		neck="Fotia Gorget",
        ear1="Brutal Earring",
        ear2="Ishvara Earring",        
        body="Kendatsuba Samue",
		hands="Mummu Wrists +2",
        ring1="Regal Ring",
        ring2="Mummu Ring",
        back=gear.AndartiaWS,
        waist="Windbuffet Belt +1",		
		legs="Mummu Kecks +2",
        feet="Mummu Gamashes +1",
        }

    sets.precast.WS['Blade: Ten'] = {
        ammo="Seeth. Bomblet +1",
        head="Adhemar Bonnet +1",
		neck="Caro Necklace",
        ear1="Lugra Earring +1",
        ear2="Moonshade Earring",        
        body="Adhemar Jacket +1",
		hands="Adhemar Wristbands +1",
        ring1="Regal Ring",
        ring2="Ilabrat Ring",
        back=gear.AndartiaWS,
        waist="Grunfeld Rope",		
		legs="Hizamaru Hizayoroi +2",
        feet=gear.HercFeetSTR,
        }

    sets.precast.WS['Blade: Shun'] = {
        ammo="Jukukik Feather",
        head="Adhemar Bonnet +1",
		neck="Fotia Gorget",
        ear1="Lugra Earring +1",
        ear2="Lugra Earring",        
        body="Adhemar Jacket +1",
		hands="Adhemar Wristbands +1",
        ring1="Regal Ring",
        ring2="Ilabrat Ring",
        back=gear.AndartiaTP,
        waist="Fotia Belt",		
		legs="Jokushu Haidate",
        feet=gear.HercFeetTP,
        }

    sets.precast.WS['Blade: Kamu'] = {
        ammo="Seeth. Bomblet +1",
        head="Adhemar Bonnet +1",
		neck="Fotia Gorget",
        ear1="Brutal Earring",
        ear2="Moonshade Earring",        
        body="Adhemar Jacket +1",
		hands="Adhemar Wristbands +1",
        ring1="Regal Ring",
        ring2="Shukuyu Ring",
        back=gear.AndartiaWS,
        waist="Fotia Belt",		
		legs="Samnuha Tights",
        feet=gear.HercFeetTP,
        }

    sets.precast.WS['Blade: Yu'] = {
        ammo="Seeth. Bomblet +1",
        head=gear.HercHeadMagic,
		neck="Baetyl pendant",
		ear1="Moonshade Earring",
		ear2="Friomisi Earring",
        body="Samnuha coat",
		hands="Leyline gloves",
		ring1="Shiva ring +1",
		ring2="Shiva ring +1",
        back=gear.AndartiaWS,
		waist=gear.ElementalObi,
		legs=gear.HercLegsMagic,
		feet=gear.HercFeetMagic
		}

    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS['Blade: Yu'], {ammo="Pemphredo tathlum",})

    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {
        ammo="Impatiens", --10
        ring1="Evanescence Ring", --5
        }
        
    -- Specific spells
    sets.midcast.Utsusemi = set_combine(sets.midcast.SpellInterrupt, {feet="Hattori Kyahan", back="Andartia's Mantle"})

    sets.midcast.ElementalNinjutsu = {
		ammo="Pemphredo Tathlum",
        head=gear.HercHeadMagic,
		neck="Sanctity necklace",
		ear1="Friomisi Earring",
		ear2="Crematio earring",
        body="Samnuha coat",
		hands="Leyline gloves",
		ring1="Shiva ring +1",
		ring2="Shiva ring +1",
        back="Toro Cape",
		waist=gear.ElementalObi,
		legs=gear.HercLegsMagic,
		feet=gear.HercFeetMagic
		}

	sets.midcast.ElementalNinjutsu.Resistant = set_combine(sets.midcast.Ninjutsu, {
		neck="Sanctity Necklace",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
		ear1="Hermetic Earring",
		})

    sets.midcast.NinjutsuDebuff = {
        ammo="Yamarang",
	    head="Mummu Bonnet +2",
        body="Mummu Jacket +2",
        hands="Mummu Wrists +2",
		legs="Mummu Kecks +2",
		feet="Mummu Gamash. +1",
		neck="Sanctity Necklace",
		ear1="Hermetic Earring",
		ear2="Digni. Earring",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
        waist="Eschan Stone",
        }

    sets.midcast.NinjutsuBuff = {
		head="Hachiya Hatsu. +2",
		neck="Incanter's Torque",
		ear1="Stealth Earring",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
		back="Astute Cape",
		}
		
	sets.midcast['Migawari: Ichi'] = set_combine(sets.midcast.NinjutsuBuff, {
		body="Hattori Ningi"
		})

    sets.midcast.RA = {
		head="Mummu Bonnet +2",
        body="Mummu Jacket +2",
        hands="Mummu Wrists +2",
		legs="Mummu Kecks +2",
		feet="Mummu Gamash. +1",
		neck="Iskur Gorget",
		ear1="Enervating Earring",
		ear2="Telos Earring",
		ring1="Regal Ring",
		ring2="Dingir Ring",
		waist="Yemaya Belt",
		}

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    
    -- Resting sets
--    sets.resting = {}
    
    -- Idle sets
    sets.idle = {
		ammo="Staunch tathlum",
		head=gear.HercHeadDT,
		neck="Bathy choker +1",
		ear1="Infused earring",
		ear2="Ethereal earring",
        body="Hizamaru Haramaki +2",
		hands=gear.HercHandsDT,
		ring1="Sheltered Ring",
		ring2="Paguroidea Ring",
        back="Moonbeam cape",
		waist="Flume Belt +1",
		legs="Mummu kecks +2",
		feet="Danzo sune-ate"
		}

    sets.idle.DT = {
		ammo="Staunch tathlum",
		head=gear.HercHeadDT,
		neck="Loricate Torque +1",
		ear1="Odnowa earring +1",
		ear2="Odnowa earring",
        body="Ashera harness",
		hands=gear.HercHandsDT,
		ring1="Defending Ring",
		ring2="Dark Ring",
        back="Moonbeam cape",
		waist="Flume Belt +1",
		legs="Mummu kecks +2",
		feet=gear.HercFeetDT
		}

    sets.idle.Town = sets.idle
    
    sets.idle.Weak = sets.idle.DT
    
    -- Defense sets
    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {feet="Danzo sune-ate"}
    
    sets.DayMovement = {feet="Danzo sune-ate"}
    sets.NightMovement = {feet="Hachi. Kyahan +1"}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- * NIN Native DW Trait: 35% DW
    
    -- No Magic Haste (74% DW to cap)    
    sets.engaged = {
		ammo="Happo Shuriken",			--
        head="Ryuo Somen",				-- 8
		neck="Moonbeam nodowa",			-- 
		ear1="Dedition Earring",		-- 
		ear2="Suppanomimi",				-- 5
        body="Adhemar Jacket +1",		-- 6
		hands="Adhemar Wristbands +1",	--
		ring1="Haverton Ring",			-- 5
		ring2="Epona's Ring",			--
        back=gear.AndartiaTP,			--
		waist="Reiki Yotai",			-- 7
		legs="Samnuha tights",			--
		feet="Hizamaru Sune-ate +2"		-- 8
		} --39

    sets.engaged.LowAcc = set_combine(sets.engaged, {
		ear1="Telos Earring"
        })

    sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
        ear2="Cessance Earring",
		ring1="Ilabrat Ring",
        })

    sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
        ear2="Dignitary's Earring",
		ring1="Regal Ring",
        ring2="Ramuh Ring +1",
        waist="Olseni Belt",
        })

    sets.engaged.STP = set_combine(sets.engaged, {
        
		})

    -- 15% Magic Haste (67% DW to cap)
    sets.engaged.LowHaste = {
		ammo="Happo Shuriken",			--
        head="Ryuo Somen",				-- 8
		neck="Moonbeam nodowa",			-- 
		ear1="Dedition Earring",		-- 
		ear2="Suppanomimi",				-- 5
        body="Adhemar Jacket +1",		-- 6
		hands="Adhemar Wristbands +1",	--
		ring1="Haverton Ring",			-- 5
		ring2="Epona's Ring",			--
        back=gear.AndartiaTP,			--
		waist="Reiki Yotai",			-- 7
		legs="Samnuha tights",			--
		feet=gear.HercFeetTP			-- 
		} --31

    sets.engaged.LowAcc.LowHaste = set_combine(sets.engaged.LowHaste, {
		ear1="Telos Earring"
        })

    sets.engaged.MidAcc.LowHaste = set_combine(sets.engaged.LowAcc.LowHaste, {
        ear2="Cessance Earring",
		ring1="Ilabrat Ring",
        })

    sets.engaged.HighAcc.LowHaste = set_combine(sets.engaged.LowAcc.LowHaste, {
        ear2="Dignitary's Earring",
		ring1="Regal Ring",
        ring2="Ramuh Ring +1",
        waist="Olseni Belt",
        })

    sets.engaged.STP.LowHaste = set_combine(sets.engaged.LowHaste, {
        
		})

    -- 30% Magic Haste (56% DW to cap)
    sets.engaged.MidHaste = {
		ammo="Happo Shuriken",			--
        head="Ryuo Somen",				-- 8
		neck="Moonbeam nodowa",			-- 
		ear1="Dedition Earring",		-- 
		ear2="Cessance Earring",		-- 
        body="Adhemar Jacket +1",		-- 6
		hands="Adhemar Wristbands +1",	--
		ring1="Petrov Ring",			-- 
		ring2="Epona's Ring",			--
        back=gear.AndartiaTP,			--
		waist="Reiki Yotai",			-- 7
		legs="Samnuha tights",			--
		feet=gear.HercFeetTP			-- 
		} --21

    sets.engaged.LowAcc.MidHaste = set_combine(sets.engaged.MidHaste, {
		ear1="Telos Earring"
        })

    sets.engaged.MidAcc.MidHaste = set_combine(sets.engaged.LowAcc.MidHaste, {
        ear2="Cessance Earring",
		ring1="Ilabrat Ring",
        })

    sets.engaged.HighAcc.MidHaste = set_combine(sets.engaged.MidHaste.MidAcc, {
        ear2="Dignitary's Earring",
		ring1="Regal Ring",
        ring2="Ramuh Ring +1",
        waist="Olseni Belt",
        })

    sets.engaged.STP.MidHaste = set_combine(sets.engaged.MidHaste, {

        })

    -- 35% Magic Haste (51% DW to cap)
    sets.engaged.HighHaste = {
		ammo="Happo Shuriken",			--
        head="Adhemar Bonnet +1",		-- 
		neck="Moonbeam nodowa",			-- 
		ear1="Dedition Earring",		-- 
		ear2="Suppanomimi",				-- 5
        body="Kendatsuba Samue",		-- 
		hands="Adhemar Wristbands +1",	--
		ring1="Petrov Ring",			-- 
		ring2="Epona's Ring",			--
        back=gear.AndartiaTP,			--
		waist="Reiki Yotai",			-- 7
		legs="Samnuha tights",			--
		feet=gear.HercFeetTP			-- 
		} --12

    sets.engaged.LowAcc.HighHaste = set_combine(sets.engaged.HighHaste, {
		ear1="Telos Earring"
        })

    sets.engaged.MidAcc.HighHaste = set_combine(sets.engaged.LowAcc.HighHaste, {
        ear2="Cessance Earring",
		ring1="Ilabrat Ring",
        })

    sets.engaged.HighAcc.HighHaste = set_combine(sets.engaged.MidAcc.HighHaste, {
        ear2="Dignitary's Earring",
		ring1="Regal Ring",
        ring2="Ramuh Ring +1",
        waist="Olseni Belt",
        })

    sets.engaged.STP.HighHaste = set_combine(sets.engaged.HighHaste, {

        })

    -- 47% Magic Haste (36% DW to cap)
    sets.engaged.MaxHaste = {
		ammo="Happo Shuriken",			--
        head="Adhemar Bonnet +1",		-- 
		neck="Moonbeam Nodowa",			-- 
		ear1="Dedition Earring",		-- 
		ear2="Cessance Earring",		-- 
        body="Kendatsuba Samue",		-- 
		hands="Adhemar Wristbands +1",	--
		ring1="Petrov Ring",			-- 
		ring2="Epona's Ring",			--
        back=gear.AndartiaTP,			--
		waist="Windbuffet Belt +1",		-- 
		legs="Samnuha Tights",			--
		feet=gear.HercFeetTP			-- 
		} --0

    sets.engaged.LowAcc.MaxHaste = set_combine(sets.engaged.MaxHaste, {
		ear1="Telos Earring"
        })

    sets.engaged.MidAcc.MaxHaste = set_combine(sets.engaged.LowAcc.MaxHaste, {
        ear2="Cessance Earring",
		ring1="Ilabrat Ring",
        })

    sets.engaged.HighAcc.MaxHaste = set_combine(sets.engaged.MidAcc.MaxHaste, {
        ear2="Dignitary's Earring",
		ring1="Regal Ring",
        ring2="Ramuh Ring +1",
        waist="Olseni Belt",
        })

    sets.engaged.STP.MaxHaste = set_combine(sets.engaged.MaxHaste, {

        })

    sets.engaged.Hybrid = {
        neck="Loricate Torque +1", --6/6
		body="Ashera Harness",
        ring1="Defending Ring", --10/10
		back="Moonbeam Cape",
		legs="Mummu Kecks +2",
        }
    
    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)
    sets.engaged.STP.DT = set_combine(sets.engaged.STP, sets.engaged.Hybrid)

    sets.engaged.DT.LowHaste = set_combine(sets.engaged.LowHaste, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT.LowHaste = set_combine(sets.engaged.LowAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT.LowHaste = set_combine(sets.engaged.MidAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT.LowHaste = set_combine(sets.engaged.HighAcc.LowHaste, sets.engaged.Hybrid)    
    sets.engaged.STP.DT.LowHaste = set_combine(sets.engaged.STP.LowHaste, sets.engaged.Hybrid)

    sets.engaged.DT.MidHaste = set_combine(sets.engaged.MidHaste, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT.MidHaste = set_combine(sets.engaged.LowAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT.MidHaste = set_combine(sets.engaged.MidAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT.MidHaste = set_combine(sets.engaged.HighAcc.MidHaste, sets.engaged.Hybrid)    
    sets.engaged.STP.DT.MidHaste = set_combine(sets.engaged.STP.MidHaste, sets.engaged.Hybrid)

    sets.engaged.DT.HighHaste = set_combine(sets.engaged.HighHaste, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT.HighHaste = set_combine(sets.engaged.LowAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT.HighHaste = set_combine(sets.engaged.MidAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT.HighHaste = set_combine(sets.engaged.HighAcc.HighHaste, sets.engaged.Hybrid)    
    sets.engaged.STP.DT.HighHaste = set_combine(sets.engaged.HighHaste.STP, sets.engaged.Hybrid)

    sets.engaged.DT.MaxHaste = set_combine(sets.engaged.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT.MaxHaste = set_combine(sets.engaged.LowAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT.MaxHaste = set_combine(sets.engaged.MidAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT.MaxHaste = set_combine(sets.engaged.HighAcc.MaxHaste, sets.engaged.Hybrid)    
    sets.engaged.STP.DT.MaxHaste = set_combine(sets.engaged.STP.MaxHaste, sets.engaged.Hybrid)

    --------------------------------------
    -- Custom buff sets
    --------------------------------------

--    sets.buff.Migawari = {body="Iga Ningi +2"}
    sets.buff.Doom = {ring1="Eshmun's Ring", ring2="Eshmun's Ring", waist="Gishdubar Sash"}
--    sets.buff.Yonin = {}
--    sets.buff.Innin = {}

    sets.CP = {back="Mecisto. Mantle"}
    sets.TH = {waist="Chaac Belt"}
    sets.Reive = {neck="Ygnas's Resolve +1"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    if spellMap == 'Utsusemi' then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
            cancel_spell()
            add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
            eventArgs.handled = true
            return
        elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
            send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
        end
    end
end

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.Buff.Doom then
        equip(sets.buff.Doom)
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted and spell.english == "Migawari: Ichi" then
        state.Buff.Migawari = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste', 'march', 'mighty guard', 'embrava', 'haste samba', 'geo-haste', 'indi-haste'}:contains(buff:lower()) then
        determine_haste_group()
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end

--    if buffactive['Reive Mark'] then
--        if gain then           
--            equip(sets.Reive)
--            disable('neck')
--        else
--            enable('neck')
--        end
--    end

    if buff == "doom" then
        if gain then           
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
            disable('ring1','ring2','waist')
        else
            enable('ring1','ring2','waist')
            handle_equipping_gear(player.status)
        end
    end

end

--function job_status_change(new_status, old_status)
    if new_status == 'Idle' then
        select_movement_feet()
    end
--end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Get custom spell maps
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == "Ninjutsu" then
        if not default_spell_map then
            if spell.target.type == 'SELF' then
                return 'NinjutsuBuff'
            else
                return 'NinjutsuDebuff'
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.Buff.Migawari then
       idleSet = set_combine(idleSet, sets.buff.Migawari)
    end
    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end
    if state.TH.current == 'on' then
        equip(sets.TH)
        disable('waist')
    else
        enable('waist')
    end

    idleSet = set_combine(idleSet, select_movement_feet())

    return idleSet
end


-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Migawari then
        meleeSet = set_combine(meleeSet, sets.buff.Migawari)
    end
    return meleeSet
end

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
    select_movement_feet()
    determine_haste_group()
end

-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)

    local msg = '[ Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ' ][ WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ' ][ Defense: ' .. state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end
    
    if state.Kiting.value then
        msg = msg .. ' ][ Kiting Mode: ON'
    end
    
    msg = msg .. ' ]'
    
    add_to_chat(060, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_haste_group()

    -- Gearswap can't detect the difference between Haste I and Haste II
    -- so use winkey-H to manually set Haste spell level.

    -- Haste (buffactive[33]) - 15%
    -- Haste II (buffactive[33]) - 30%
    -- Haste Samba - 5%/10%
    -- Victory March +0/+3/+4/+5    9.4%/14%/15.6%/17.1%
    -- Advancing March +0/+3/+4/+5  6.3%/10.9%/12.5%/14% 
    -- Embrava - 30%
    -- Mighty Guard (buffactive[604]) - 15%
    -- Geo-Haste (buffactive[580]) - 40%
    
    classes.CustomMeleeGroups:clear()
    
    if state.HasteMode.value == 'Haste II' then
        if(((buffactive[33] or buffactive[580] or buffactive.embrava) and (buffactive.march or buffactive[604])) or
            (buffactive[33] and (buffactive[580] or buffactive.embrava)) or
            (buffactive.march == 2 and buffactive[604]) or buffactive.march == 3) or buffactive[580] == 2 then
            --add_to_chat(122, 'Magic Haste Level: 43%')
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif ((buffactive[33] or buffactive.march == 2 or buffactive[580]) and buffactive['haste samba']) then
            --add_to_chat(122, 'Magic Haste Level: 35%')
            classes.CustomMeleeGroups:append('HighHaste')
        elseif ((buffactive[580] or buffactive[33] or buffactive.march == 2) or
            (buffactive.march == 1 and buffactive[604])) then
            --add_to_chat(122, 'Magic Haste Level: 30%')
            classes.CustomMeleeGroups:append('MidHaste')
        elseif (buffactive.march == 1 or buffactive[604]) then
            --add_to_chat(122, 'Magic Haste Level: 15%')
            classes.CustomMeleeGroups:append('LowHaste')
        end
    else
        if (buffactive[580] and ( buffactive.march or buffactive[33] or buffactive.embrava or buffactive[604]) ) or
            (buffactive.embrava and (buffactive.march or buffactive[33] or buffactive[604])) or
            (buffactive.march == 2 and (buffactive[33] or buffactive[604])) or
            (buffactive[33] and buffactive[604] and buffactive.march ) or buffactive.march == 3 or buffactive[580] == 2 then
            --add_to_chat(122, 'Magic Haste Level: 43%')
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif ((buffactive[604] or buffactive[33]) and buffactive['haste samba'] and buffactive.march == 1) or
            (buffactive.march == 2 and buffactive['haste samba']) or
            (buffactive[580] and buffactive['haste samba'] ) then
            --add_to_chat(122, 'Magic Haste Level: 35%')
            classes.CustomMeleeGroups:append('HighHaste')
        elseif (buffactive.march == 2 ) or
            ((buffactive[33] or buffactive[604]) and buffactive.march == 1 ) or  -- MG or haste + 1 march
            (buffactive[580] ) or  -- geo haste
            (buffactive[33] and buffactive[604]) then
            --add_to_chat(122, 'Magic Haste Level: 30%')
            classes.CustomMeleeGroups:append('MidHaste')
        elseif buffactive[33] or buffactive[604] or buffactive.march == 1 then
            --add_to_chat(122, 'Magic Haste Level: 15%')
            classes.CustomMeleeGroups:append('LowHaste')
        end
    end
end


function select_movement_feet()
    if world.time >= (17*60) or world.time <= (7*60) then
       return sets.NightMovement
    else
       return sets.DayMovement
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 18)
end

function set_lockstyle()
    send_command('wait 3; input /lockstyleset 14')
end