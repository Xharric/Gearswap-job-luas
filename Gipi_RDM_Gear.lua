-------------------------------------------------------------------------------------------------------------------
-- (Original: Motenten / Modified: Arislan)
-------------------------------------------------------------------------------------------------------------------

--[[    Custom Features:
        
        Capacity Pts. Mode    Capacity Points Mode Toggle [WinKey-C]
        Auto. Lockstyle        Automatically locks desired equipset on file load
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

    state.CP = M(false, "Capacity Points Mode")
    state.Buff.Saboteur = buffactive.Saboteur or false
    
    enfeebling_magic_acc = S{'Bind', 'Break', 'Dispel', 'Dispelga', 'Distract', 'Distract II', 'Frazzle',
        'Frazzle II',  'Gravity', 'Gravity II', 'Silence', 'Sleep', 'Sleep II', 'Sleepga'}
    enfeebling_magic_skill = S{'Slow', 'Slow II','Paralyze' ,'Paralyze II' ,'Distract III', 'Frazzle III', 'Poison II'}
    enfeebling_magic_effect = S{'Dia', 'Dia II', 'Dia III', 'Diaga'}

	noskill_spells_list = S{'Haste II', 'Flurry II', 'Refresh', 'Regen', 'Protect', 'Protectra', 'Shell', 'Shellra',
		'Raise', 'Reraise', 'Cursna', 'Sneak', 'Invisible', 'Deodorize'}
	
    skill_spells = S{
        'Temper', 'Temper II', 'Enfire', 'Enfire II', 'Enblizzard', 'Enblizzard II', 'Enaero', 'Enaero II',
        'Enstone', 'Enstone II', 'Enthunder', 'Enthunder II', 'Enwater', 'Enwater II'}

    determine_haste_group()
end


-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'MidAcc', 'HighAcc')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT')

    state.WeaponLock = M(false, 'Weapon Lock')    
    state.MagicBurst = M(false, 'Magic Burst')
    state.CP = M(false, "Capacity Points Mode")

	gear.default.obi_waist = "Refoccilation Stone"
	
    -- Additional local binds

    update_offense_mode()    
    select_default_macro_book()
    set_lockstyle()
	
	send_command('bind @m gs c toggle MagicBurst')
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
	send_command('unbind @m')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    include('Gipi_augmented-items.lua')
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {body="Vitiation Tabard +3"}
    
    -- Fast cast sets for spells
    
    -- Fast cast sets for spells
    sets.precast.FC = {
    --    Traits --30
        ammo="Pemphredo tathlum",		--
		head=gear.MerlinHeadFC,			--15
		neck="Orunmila's torque",		--5
		ear1="Loquacious Earring",		--2
		ear2="Malignance Earring",		--4
		body="Vitiation Tabard +3",		--15
		hands="Leyline gloves",			--7
		ring1="Defending ring",			--
		ring2="Gelatinous Ring +1",		--
		back="Fi Follet Cape +1",		--
		waist="Luminary Sash",			--
		legs="Lengo Pants",				--5							
		feet="Carmine Greaves +1"		--8
        } --50

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {})
    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC['Healing Magic'] = sets.precast.FC.Cure
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	sets.precast.FC['Stoneskin'] = set_combine(sets.precast.FC['Enhancing Magic'], {head="Umuthi hat",legs="Doyen pants"})
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {})
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Twilight Cloak"})
    sets.precast.Storm = set_combine(sets.precast.FC, {})
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})
	sets.precast.FC['Dispelga'] = set_combine(sets.precast.FC, {main="Daybreak"})


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
		ammo="Floestone",
        head="Viti. Chapeau +3",
		neck="Caro Necklace",
		ear1="Brutal Earring",
		ear2="Sherida Earring",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		ring1="Shukuyu Ring",
		ring2="Ilabrat Ring",
		back=gear.SucellosWS,
		waist="Prosilio Belt +1",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2"
        }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        ear1="Cessance Earring",
        ring1="Cacoethic Ring +1",
        })

    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
        ammo="Yetshila +1",
        head="Jhakri Coronal +2",
		neck="Fotia Gorget",
		ear1="Moonshade Earring",
		ear2="Sherida Earring",
		body="Jhakri Robe +2",
		hands="Malignance Gloves",
		ring1="Begrudging Ring",
		ring2="Ilabrat Ring",
		back=gear.SucellosCDC,
		waist="Fotia Belt",
		legs="Jhakri Slops +2",
		feet="Thereoid Greaves"
        })

    sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS['Chant du Cygne'], {
        ear1="Telos Earring",
        })

    sets.precast.WS['Vorpal Blade'] = sets.precast.WS['Chant du Cygne']
    sets.precast.WS['Vorpal Blade'].Acc = sets.precast.WS['Chant du Cygne'].Acc

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		ammo="Regal Gem",
		head="Viti. Chapeau +3",
        neck="Caro Necklace",
        ear1="Regal Earring",
		ear2="Moonshade Earring",
		body="Vitiation Tabard +3",
        waist="Prosilio Belt +1",
		feet="Carmine Greaves +1",
        })

    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {
        waist="Grunfeld Rope",
        })

    sets.precast.WS['Death Blossom'] = sets.precast.WS['Savage Blade']
    sets.precast.WS['Death Blossom'].Acc = sets.precast.WS['Savage Blade'].Acc

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
        ammo="Regal Gem",
        ear2="Sherida Earring",
        })

    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS['Requiescat'], {
        ear2="Telos Earring",
        ring1="Cacoethic Ring +1",
        waist="Grunfeld Rope",
        })

    sets.precast.WS['Sanguine Blade'] = {ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Regal Earring",ear2="Malignance Earring",
		body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Archon Ring",ring2="Freke Ring",
		back=gear.SucellosMB,waist="Refoccilation Stone",legs="Amalric Slops +1",feet="Amalric Nails +1",
        }
		
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS['Sanguine Blade'], {head="Jhakri Coronal +2",ring1="Shiva Ring +1"})

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
    
    sets.midcast.FastRecast = set_combine(sets.precast.FC, {
		main="Rubicundity",
		sub="Ammurapi shield",
		head="Vanya Hood",
		})

    sets.midcast.SpellInterrupt = {
        hands="Chironic Gloves", --20
		legs="Carmine Cuisses +1", --20
        ring1="Evanescence Ring", --5
        waist="Rumination Sash", --10
		feet="Amalric Nails +1", --16
        }

    sets.midcast.Cure = {
        main="Daybreak",				--30
		sub="Ammurapi Shield",
		ammo="Regal Gem",
		head="Vanya Hood",				--10
		neck="Incanter's Torque",
		ear1="Mendicant's Earring",		--5
		ear2="Novia Earring",
		body="Vitiation Tabard +3",
		hands="Vanya Cuffs",
		ring1="Sirona's ring",
		ring2="Lebeche ring",			--2
		back=gear.SucellosMACC,			--10
		waist="Bishop's Sash",
		legs="Vanya Slops",
		feet="Vanya Clogs"				--5
        } --61 (overcap)

    sets.midcast.CureWeather = set_combine(sets.midcast.Cure, {
        waist="Hachirin-no-Obi"
        })

    sets.midcast.CureSelf = set_combine(sets.midcast.Cure, {
        waist="Gishdubar Sash",
        })

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
        waist="Luminary Sash"
        })

    sets.midcast.StatusRemoval = {
        head="Vanya Hood",
        neck="Incanter's Torque",
		ear2="Regal Earring",
		body="Vitiation Tabard +3",
		hands="Vanya Cuffs",
        ring1="Sirona's Ring",
        waist="Bishop's Sash",
		legs="Vanya Slops",
        feet="Vanya Clogs"
        }
        
    sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {})

    sets.midcast['Enhancing Magic'] = {
		main=gear.ColadaENH,
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head="Befouled Crown",
		neck="Incanter's Torque",
		ear2="Andoaa Earring",
		body="Vitiation Tabard +3",
		hands="Viti. Gloves +3",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Ghostfyre cape",
		waist="Olympus sash",
		legs="Atrophy Tights +1",
		feet="Leth. Houseaux +1"
        }
    
    sets.midcast.EnhancingDuration = {
		main=gear.ColadaENH,
		sub="Ammurapi Shield",
		head=gear.TelchineHeadDURATION,
		neck="Duelist's Torque",
		body="Vitiation Tabard +3",
		hands="Atrophy Gloves +3",
		back="Ghostfyre Cape",
		waist="Embla Sash",
		legs=gear.TelchineLegsDURATION,
		feet="Lethargy Houseaux +1"
        }

    sets.midcast.EnhancingSkill = {
        hands="Viti. Gloves +3",
        }

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
        main="Bolelabunga",
        })

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
		head="Amalric Coif +1",
		body="Atrophy Tabard +3",
		waist="Gishdubar Sash",
		legs="Leth. Fuseau +1"
        })
    
    sets.midcast.RefreshSelf = {
        --waist="Gishdubar Sash",
        }
	
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		neck="Stone gorget",
		legs="Shedir seraweels",
		waist="Siegel Sash"
        })

    sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {
		body=gear.TaeonBodyLANX,
		hands=gear.TaeonHandsLANX,
		legs=gear.TaeonLegsLANX,
		feet=gear.TaeonFeetLANX,
		})

    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
        head="Amalric Coif +1",
		hands="Regal Cuffs",
		legs="Shedir Seraweels"
        })

    sets.midcast.Storm = sets.midcast.EnhancingDuration

    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {
        ring2="Sheltered Ring",
        })

    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Shell

     -- Custom spell classes
    sets.midcast.MndEnfeebles = {
        main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Regal Gem",
		head="Viti. Chapeau +3",
		neck="Duelist's Torque",
		ear1="Regal Earring",
		ear2="Snotra Earring",
		body="Lethargy Sayon +1",
		hands="Regal Cuffs",
		ring1="Stikini Ring +1",
		ring2="Kishar Ring",
		back=gear.SucellosMACC,
		waist="Luminary Sash",
		legs=gear.ChironicLegsMACC,
		feet="Vitiation Boots +3"
        }

    sets.midcast.MndEnfeeblesAcc = set_combine(sets.midcast.MndEnfeebles, {
		body="Atrophy Tabard +3",
        })
    
    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
		main="Maxentius",
        })

    sets.midcast.IntEnfeeblesAcc = set_combine(sets.midcast.IntEnfeebles, {
		body="Atrophy Tabard +3",
        })

    sets.midcast.SkillEnfeebles = {
        main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Regal Gem", --
		head="Viti. Chapeau +3", --24
		neck="Incanter's Torque", --10
		ear1="Regal Earring",
		ear2="Snotra Earring",
		body="Atrophy Tabard +3", --21
		hands="Leth. Gantherots +1", --19
		ring1="Stikini Ring +1", --5
		ring2="Stikini Ring +1", --5
		back=gear.SucellosMACC, --10
		waist="Luminary Sash", --
		legs=gear.ChironicLegsMACC, --13
		feet="Vitiation Boots +3" --14
        }

    sets.midcast.EffectEnfeebles = sets.midcast.SkillEnfeebles

    sets.midcast.ElementalEnfeeble = sets.midcast.IntEnfeebles

	sets.midcast['Dispelga'] = set_combine(sets.midcast.SkillEnfeebles, {main="Daybreak",sub="Ammurapi Shield",})

    sets.midcast['Dark Magic'] = {
		main="Rubicundity",
		sub="Ammurapi Shield",
		ammo="Pemphredo tathlum",
        head="Amalric Coif +1",
		neck="Erra Pendant",
		ear1="Regal Earring",
		ear2="Malignance Earring",
        body=gear.MerlinBodyMB,
		hands="Regal Cuffs",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
        back=gear.SucellosMB,
		waist="Luminary Sash",
		legs=gear.MerlinLegsMB,
		feet=gear.MerlinFeetMB
		}

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        head="Pixie Hairpin +1",
        waist="Fucho-no-obi",
		ring1="Archon Ring",
		ring2="Evanescence Ring",
        })
    
    sets.midcast.Aspir = sets.midcast.Drain
    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {waist="Luminary Sash"})

    sets.midcast['Elemental Magic'] = {
		main=gear.GrioMB,
		sub="Enki Strap",
		ammo="Pemphredo tathlum",
        head=gear.MerlinHeadMB,
		neck="Sanctity necklace",
		ear1="Regal earring",
		ear2="Malignance Earring",
        body="Amalric Doublet +1",
		hands="Amalric Gages +1",
		ring1="Shiva ring +1",
		ring2="Freke Ring",
        back=gear.SucellosMB,
		waist=gear.ElementalObi,
		legs="Amalric Slops +1",
		feet="Amalric Nails +1",
		}	

    sets.midcast['Elemental Magic'].Seidr = set_combine(sets.midcast['Elemental Magic'], {
        body="Seidr Cotehardie",
        neck="Erra Pendant",
        })

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
		head="Amalric Coif +1",
		neck="Duelist's Torque",
		hands="Regal Cuffs",
        })	
     
	sets.magic_burst = set_combine(sets.midcast['Elemental Magic'], { 
		neck="Mizukage-no-Kubikazari",	--10
		hands="Amalric Gages +1",
		ring1="Locus Ring",				--5
		ring2="Mujin Band",				
		legs=gear.MerlinLegsMB,			--10
		feet=gear.MerlinFeetMB,  		--10
		})  -- 6 head (41 MB, 11 MBII)
	 
    sets.midcast.Impact = {
		main="Maxentius",
		sub="Ammurapi Shield",
		ammo="Pemphredo tathlum",
        head=empty,
		neck="Erra pendant",
		ear1="Dignitary's Earring",
		ear2="Malignance Earring",
        body="Twilight cloak",
		hands="Regal Cuffs",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
        back=gear.SucellosMB,
		waist="Luminary Sash",
		legs=gear.ChironicLegsMACC,
		feet=gear.MerlinFeetMB
		}
    
    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    -- Initializes trusts at iLvl 119
    sets.midcast.Trust = sets.precast.FC
        
    -- Job-specific buff sets
    sets.buff.ComposureOther = {
		main="Bolelabunga",
		sub="Ammurapi Shield",
		head="Leth. Chappel +1",
		body="Vitiation Tabard +3",
		hands="Atrophy Gloves +3",
		back="Ghostfyre Cape",
		legs="Lethargy Fuseau +1",
		feet="Lethargy Houseaux +1"
		}

    sets.buff.Saboteur = {hands="Leth. Gantherots +1"}

    
    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------
    
    sets.idle = {
        main="Daybreak",
		sub="Genmei Shield",
		ammo="Homiliary",
		head="Viti. Chapeau +3",
		neck="Bathy Choker +1",
		ear1="Infused Earring",
		ear2="Sanare Earring",
		body="Shamash Robe",
		hands=gear.ChironicHandsREFRESH,
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back=gear.SucellosTP,
		waist="Flume Belt +1",
		legs="Lengo Pants",
		feet="Amalric Nails +1"
        }

    sets.idle.DT = set_combine(sets.idle, {
        main="Daybreak",					--
		sub="Genmei's Shield",				--10
		ammo="Staunch Tathlum +1",			--3
		head="Viti. Chapeau +3",			--
		neck="Warder's Charm +1",			--
		ear1="Eabani Earring",				--
		ear2="Sanare Earring",				--
		body="Shamash Robe",				--10
		hands="Malignance Gloves",			--
		ring1="Defending Ring",				--10
		ring2="Stikini Ring +1",			--
		back=gear.SucellosTP,				--10
		waist="Flume Belt +1",				--4
		legs="Malignance Tights",			--7
		feet="Amalric Nails +1",			--
        }) --52

    sets.idle.Town = set_combine(sets.idle, {legs="Carmine Cuisses +1",})

    sets.idle.Weak = sets.idle.DT

    sets.resting = set_combine(sets.idle, {})
    
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
    
    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT    

    sets.Kiting = {legs="Carmine Cuisses +1"}
    sets.latent_refresh = {waist="Fucho-no-obi"}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    sets.engaged = {
		main="Almace",
		sub="Genmei Shield",
		ammo="Ginsen",
		head="Malignance Chapeau",
		neck="Anu Torque",
		ear1="Telos Earring",
		ear2="Sherida Earring",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Petrov Ring",
		ring2="Ilabrat Ring",
		back=gear.SucellosTP,
		waist="Kentarch Belt +1",
		legs="Malignance Tights",
		feet="Carmine Greaves +1",
        }
        
    sets.engaged.MidAcc = set_combine(sets.engaged, {
        neck="Combatant's Torque",
        waist="Kentarch Belt +1",
        ring2="Ilabrat Ring",
        })

    sets.engaged.HighAcc = set_combine(sets.engaged, {
        waist="Olseni Belt",
        })

    -- * DW3: +25% (NIN Subjob)

    -- No Magic Haste (74% DW to cap - 49)
    sets.engaged.DW = {
        ammo="Ginsen",
		head="Malignance Chapeau",
		neck="Anu Torque",
		ear1="Suppanomimi",
		ear2="Eabani Earring",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Haverton Ring",
		ring2="Ilabrat Ring",
		back=gear.SucellosDW,
		waist="Reiki Yotai",
		legs="Carmine Cuisses +1",
		feet="Carmine Greaves +1",
        } --63

    sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW, {
        neck="Combatant's Torque",
        ring1="Petrov Ring",
        })

    sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW.MidAcc, {
        head="Carmine Mask +1",
        ear1="Cessance Earring",
        ring1="Cacoethic Ring +1",
		ring2="Ramuh Ring +1",
        waist="Olseni Belt",
        })

    -- 15% Magic Haste (67% DW to cap - 42)
    sets.engaged.DW.LowHaste = set_combine(sets.engaged.DW, {
        
        }) --63

    sets.engaged.DW.MidAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
        neck="Combatant's Torque",
        })

    sets.engaged.DW.HighAcc.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, {
        ear1="Cessance Earring",
        ring1="Cacoethic Ring +1",
		ring2="Ramuh Ring +1",
        waist="Olseni Belt",
        })

    -- 30% Magic Haste (56% DW to cap - 31)
    sets.engaged.DW.MidHaste = set_combine(sets.engaged.DW, {
        ear2="Sherida Earring",
		ring1="Petrov Ring",
        }) --53

    sets.engaged.DW.MidAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
        neck="Combatant's Torque",
        ear1="Telos Earring",

        })

    sets.engaged.DW.HighAcc.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, {
        ear1="Cessance Earring",
        ring1="Cacoethic Ring +1",
		ring2="Ramuh Ring +1",
        waist="Olseni Belt",
        })

    -- 35% Magic Haste (51% DW to cap - 26)
    sets.engaged.DW.HighHaste = set_combine(sets.engaged.DW, {
        ear1="Telos Earring",
		ear2="Sherida Earring",
		ring1="Petrov Ring",
        }) --48

    sets.engaged.DW.MidAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
        neck="Combatant's Torque",
        })

    sets.engaged.DW.HighAcc.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, {
        ear1="Cessance Earring",
        ring1="Cacoethic Ring +1",
		ring2="Ramuh Ring +1",
        waist="Olseni Belt",
        })

    -- 47% Magic Haste (36% DW to cap - 11)
    sets.engaged.DW.MaxHaste = set_combine(sets.engaged.DW, {
        ear1="Suppanomimi",
		ear2="Sherida Earring",
		back=gear.SucellosTP,
		waist="Windbuffet Belt +1",
        }) --11
    
    sets.engaged.DW.MidAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
        neck="Combatant's Torque",
		ear1="Telos Earring",
        })

    sets.engaged.DW.HighAcc.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {
        ear1="Cessance Earring",
        ring1="Cacoethic Ring +1",
		ring2="Ramuh Ring +1",
        waist="Olseni Belt",
        })


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
        ring2="Defending Ring",
		legs="Malignance Tights",
        }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)

    sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT = set_combine(sets.engaged.DW.MidAcc, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT = set_combine(sets.engaged.DW.HighAcc, sets.engaged.Hybrid)

    sets.engaged.DW.DT.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.LowHaste = set_combine(sets.engaged.DW.HighAcc.LowHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.MidHaste = set_combine(sets.engaged.DW.HighAcc.MidHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.HighHaste = set_combine(sets.engaged.DW.HighAcc.HighHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, sets.engaged.Hybrid)


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff.Doom = {ring1="Eshmun's Ring", ring2="Eshmun's Ring", waist="Gishdubar Sash"}

    sets.Obi = {waist="Hachirin-no-Obi"}
    sets.CP = {back="Mecisto. Mantle"}

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

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
    if spell.english == "Phalanx II" and spell.target.type == 'SELF' then
        cancel_spell()
        send_command('@input /ma "Phalanx" <me>')
    end
end

function job_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enfeebling Magic' then
        if enfeebling_magic_skill:contains(spell.english) or enfeebling_magic_effect:contains(spell.english) then
            if spell.type == "WhiteMagic" then
                equip(sets.midcast.MndEnfeeblesAcc)
            else
                equip(sets.midcast.IntEnfeeblesAcc)
            end
        end
    end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enfeebling Magic' then
        if enfeebling_magic_skill:contains(spell.english) then
            equip(sets.midcast.SkillEnfeebles)
        elseif enfeebling_magic_effect:contains(spell.english) then
            equip(sets.midcast.MndEnfeebles)
        end
        if state.Buff.Saboteur then
            equip(sets.buff.Saboteur)
        end
    end

    if spell.skill == 'Enhancing Magic' then
        if noskill_spells_list:contains(spell.english) then
            equip(sets.midcast.EnhancingDuration)
            if spellMap == 'Refresh' then
                equip(sets.midcast.Refresh)
                if spell.target.type == 'SELF' then
                    equip (sets.midcast.RefreshSelf)
                end
            end
        elseif skill_spells:contains(spell.english) then
            equip(sets.midcast.EnhancingSkill)    
        end
        if (spell.target.type == 'PLAYER' or spell.target.type == 'NPC') and buffactive.Composure then
            equip(sets.buff.ComposureOther)
			if spellMap == 'Refresh' then
                equip(sets.midcast.Refresh)
			end
        end
    end
    if spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)
    end
    if spell.skill == 'Elemental Magic' then
        if state.MagicBurst.value and spell.english ~= 'Death' then
            equip(sets.magic_burst)
            if spell.english == "Impact" then
                equip(sets.midcast.Impact)
            end
        end
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english == "Sleep II" then
            send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
        elseif spell.english == "Break" then
            send_command('@timers c "Break ['..spell.target.name..']" 30 down spells/00255.png')
        end 
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff,gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste', 'march', 'mighty guard', 'embrava', 'haste samba', 'geo-haste', 'indi-haste'}:contains(buff:lower()) then
        determine_haste_group()
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end

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

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'nuke' then
        handle_nuking(cmdParams)
        eventArgs.handled = true
    end
end

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
            if (world.weather_element == 'Light' or world.day_element == 'Light') then
                return 'CureWeather'
            end
        end
        if spell.skill == 'Enfeebling Magic' then
            if spell.type == "WhiteMagic" then
                if  enfeebling_magic_effect:contains(spell.english) then
                    return "EffectEnfeebles"
                elseif not enfeebling_magic_skill:contains(spell.english) then
                    if enfeebling_magic_acc:contains(spell.english) and not buffactive.Stymie then
                        return "MndEnfeeblesAcc"
                    else
                        return "MndEnfeebles"
                    end
                end
            elseif spell.type == "BlackMagic" then
                if  enfeebling_magic_effect:contains(spell.english) then
                    return "EffectEnfeebles"
                elseif not enfeebling_magic_skill:contains(spell.english) then
                    if enfeebling_magic_acc:contains(spell.english) and not buffactive.Stymie then
                        return "IntEnfeeblesAcc"
                    else
                        return "IntEnfeebles"
                    end
                end
            else
                return "MndEnfeebles"
            end 
        end
    end
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_offense_mode()
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
     elseif state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end
    
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    determine_haste_group()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
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
    msg = msg .. ' ][ WS: ' .. state.WeaponskillMode.value .. ' ]'
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. '[ Defense: ' .. state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ' ]'
    end

    if state.IdleMode.value ~= 'None' then
        msg = msg .. '[ Idle: ' .. state.IdleMode.value .. ' ]'
    end
    
    if state.Kiting.value then
        msg = msg .. '[ Kiting Mode: ON ]'
    end

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
    -- Haste Samba - 5~10%
    -- Honor March - 12~16%
    -- Victory March - 15~28%
    -- Advancing March - 10~18%
    -- Embrava - 25%
    -- Mighty Guard (buffactive[604]) - 15%
    -- Geo-Haste (buffactive[580]) - 30~40%

    classes.CustomMeleeGroups:clear()

    if state.CombatForm.value == 'DW' then
        if(((buffactive[33] or buffactive[580] or buffactive.embrava) and (buffactive.march or buffactive[604])) or
            (buffactive[33] and (buffactive[580] or buffactive.embrava)) or
            (buffactive.march == 2 and buffactive[604]) or buffactive.march == 3) or buffactive[580] == 2 then
            add_to_chat(122, 'Magic Haste Level: 43%')
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif ((buffactive[33] or buffactive.march == 2 or buffactive[580]) and buffactive['haste samba']) then
            add_to_chat(122, 'Magic Haste Level: 35%')
            classes.CustomMeleeGroups:append('HighHaste')
        elseif ((buffactive[580] or buffactive[33] or buffactive.march == 2) or
            (buffactive.march == 1 and buffactive[604])) then
            add_to_chat(122, 'Magic Haste Level: 30%')
            classes.CustomMeleeGroups:append('MidHaste')
        elseif (buffactive.march == 1 or buffactive[604]) then
            add_to_chat(122, 'Magic Haste Level: 15%')
            classes.CustomMeleeGroups:append('LowHaste')
        end
    end
end

-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>
function handle_strategems(cmdParams)
    -- cmdParams[1] == 'scholar'
    -- cmdParams[2] == strategem to use

    if not cmdParams[2] then
        add_to_chat(123,'Error: No strategem command given.')
        return
    end
    local strategem = cmdParams[2]:lower()

    if strategem == 'light' then
        if buffactive['light arts'] then
            send_command('input /ja "Addendum: White" <me>')
        elseif buffactive['addendum: white'] then
            add_to_chat(122,'Error: Addendum: White is already active.')
        else
            send_command('input /ja "Light Arts" <me>')
        end
    elseif strategem == 'dark' then
        if buffactive['dark arts'] then
            send_command('input /ja "Addendum: Black" <me>')
        elseif buffactive['addendum: black'] then
            add_to_chat(122,'Error: Addendum: Black is already active.')
        else
            send_command('input /ja "Dark Arts" <me>')
        end
    elseif buffactive['light arts'] or buffactive['addendum: white'] then
        if strategem == 'cost' then
            send_command('input /ja Penury <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Celerity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Accession <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: White" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    elseif buffactive['dark arts']  or buffactive['addendum: black'] then
        if strategem == 'cost' then
            send_command('input /ja Parsimony <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Alacrity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Manifestation <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: Black" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    else
        add_to_chat(123,'No arts has been activated yet.')
    end
end

function update_offense_mode()  
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        state.CombatForm:set('DW')
    else
        state.CombatForm:reset()
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 2)
end

function set_lockstyle()
    send_command('wait 3; input /lockstyleset 2')
end
