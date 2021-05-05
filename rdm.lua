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
    
    enfeebling_magic_acc = S{'Bind', 'Break', 'Dispel', 'Distract', 'Distract II', 'Frazzle',
        'Frazzle II',  'Gravity', 'Gravity II', 'Silence', 'Sleep', 'Sleep II', 'Sleepga'}
    enfeebling_magic_skill = S{'Distract III', 'Frazzle III', 'Poison II'}
    enfeebling_magic_effect = S{'Dia', 'Dia II', 'Dia III', 'Diaga'}

	noskill_spells_list = S{'Haste II','Flurry II', 'Refresh', 'Regen', 'Protect', 'Protectra', 'Shell', 'Shellra',
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

	gear.default.obi_waist = "Yamabuki-no-obi"
	
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

    include('Xharric_augmented-items.lua')
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {body="Vitiation Tabard +3"}
    
    -- Fast cast sets for spells
    
    -- Fast cast sets for spells
    sets.precast.FC = {
    --    Traits --30
        head=gear.MerlinHeadFC,
		neck="Orunmila's torque",
		ear1="Enchanter earring +1",
		ear2="Loquacious Earring",
		body="Vitiation Tabard +3",
		hands="Leyline gloves",
		ring1="Kishar ring",
		ring2="Lebeche ring",
		back="Perimede cape",
		waist="Witful Belt",
		legs="Psycloth Lappas",									
		feet=gear.MerlinFeetFC
        }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        ear1="Mendi. Earring", --5
        back="Pahtli Cape", --(4)
		legs="Doyen pants"
        })

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC['Healing Magic'] = sets.precast.FC.Cure
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {})
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Twilight Cloak"})
    sets.precast.Storm = set_combine(sets.precast.FC, {ring2="Levia. Ring +1", waist="Channeler's Stone"}) -- stop quick cast

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        neck="Magoraga Beads"
        })


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {ammo="Floestone",
        head="Jhakri Coronal +2",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Sherida Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Karieyh Ring",ring2="Ilabrat Ring",
		back=gear.SucellosWS,waist="Fotia Belt",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"
        }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        ear1="Cessance Earring",
        ring1="Cacoethic Ring +1",
        })

    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
        ammo="Jukukik feather",
        head="Jhakri Coronal +2",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Sherida Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Begrudging Ring",ring2="Ilabrat Ring",
		back=gear.SucellosCDC,waist="Fotia Belt",legs="Jhakri Slops +2",feet="Ayanmo Gambieras +2"
        })

    sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS['Chant du Cygne'], {
        ear1="Telos Earring",
        ring1="Cacoethic Ring +1",
        })

    sets.precast.WS['Vorpal Blade'] = sets.precast.WS['Chant du Cygne']
    sets.precast.WS['Vorpal Blade'].Acc = sets.precast.WS['Chant du Cygne'].Acc

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
        neck="Caro Necklace",
        ear1="Ishvara Earring",
		ear2="Moonshade Earring",
        waist="Prosilio Belt +1",
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

    sets.precast.WS['Sanguine Blade'] = {
        head="Jhakri Coronal +2",neck="Eddy Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Strendu Ring",ring2="Acumen Ring",
		back=gear.SucellosMB,waist="Yamabuki-no-obi",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"
        }

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
    
    sets.midcast.FastRecast = {main="Rubicundity",sub="Ammurapi shield",ammo="Pemphredo tathlum",
        head=gear.MerlinHeadFC,neck="Orunmila's torque",ear1="Enchanter earring +1",ear2="Loquacious Earring",
        body="Vitiation Tabard +3",hands="Leyline gloves",ring1="Defending ring",ring2="Lebeche ring",
        back="Fi Follet Cape +1",waist="Witful belt",legs="Lengo pants",feet="Carmine greaves +1"}

    sets.midcast.SpellInterrupt = {
        legs="Carmine Cuisses +1", --20
        ring1="Evanescence Ring", --5
        waist="Rumination Sash", --10
        }

    sets.midcast.Cure = {
        main="Serenity",sub="Enki Strap",ammo="Regal Gem",
		head="Vanya Hood",neck="Incanter's Torque",ear1="Novia earring",ear2="Mendicant's earring",
		body="Vitiation Tabard +3",hands="Vanya Cuffs",ring1="Sirona's ring",ring2="Lebeche ring",
		back=gear.SucellosMACC,waist="Bishop's Sash",legs="Vanya Slops",feet="Vanya Clogs"
        }

    sets.midcast.CureWeather = set_combine(sets.midcast.Cure, {
        waist="Hachirin-no-Obi"
        })

    sets.midcast.CureSelf = set_combine(sets.midcast.Cure, {
        waist="Gishdubar Sash",
		ring1="Kunaji Ring"
        })

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
        ammo="Regal Gem",
        waist="Luminary Sash"
        })

    sets.midcast.StatusRemoval = {
        head="Vanya Hood",
        neck="Incanter's Torque",
		ear1="Beatific Earring",
		ear2="Regal Earring",
		body="Vitiation Tabard +3",
        ring1="Sirona's Ring",
        waist="Bishop's Sash",
		legs="Atrophy Tights +1",
        feet="Vanya Clogs"
        }
        
    sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {
		feet="Vanya Clogs",
        })

    sets.midcast['Enhancing Magic'] = {
		main="Malevolence",
		sub="Ammurapi Shield",
		ammo="Regal Gem",
		head="Befouled Crown",
		neck="Incanter's Torque",
		ear2="Andoaa Earring",
		body="Vitiation Tabard +3",
		hands="Atrophy Gloves +1",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
		back="Ghostfyre cape",
		waist="Olympus sash",
		legs="Atrophy Tights +1",
		feet="Leth. Houseaux +1"
        }
    
    sets.midcast.EnhancingDuration = {
		sub="Ammurapi Shield",
		head=gear.TelchineHeadDURATION,
		body="Vitiation Tabard +3",
		hands="Atrophy Gloves +1",
		back="Ghostfyre Cape",
		legs=gear.TelchineLegsDURATION,
		feet="Lethargy Houseaux +1"
        }

    sets.midcast.EnhancingSkill = {
        hands="Viti. Gloves +1",
        }

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
        main="Bolelabunga",
        sub="Ammurapi Shield",
        })

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
		body="Atrophy tabard +2",
		waist="Gishdubar Sash",
		legs="Leth. Fuseau +1"
        })
    
    sets.midcast.RefreshSelf = {
        waist="Gishdubar Sash",
        }
	
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		neck="Stone gorget",
		legs="Shedir seraweels",
		waist="Siegel Sash"
        })

    sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {})

    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
        head="Chironic Hat",
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
        main=gear.GrioENF,
		sub="Enki Strap",
		ammo="Regal Gem",
		head="Atrophy Chapeau +2",
		neck="Erra Pendant",
		ear1="Regal Earring",
		ear2="Dignitary's earring",
		body="Lethargy Sayon +1",
		hands="Jhakri Cuffs +2",
		ring1="Stikini ring",
		ring2="Kishar Ring",
		back=gear.SucellosMACC,
		waist="Luminary Sash",
		legs=gear.ChironicLegsMACC,
		feet="Medium's sabots"
        }

    sets.midcast.MndEnfeeblesAcc = set_combine(sets.midcast.MndEnfeebles, {
		body="Atrophy Tabard +2",
		ring2="Stikini Ring"
        })
    
    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
		back=gear.SucellosMB
        })

    sets.midcast.IntEnfeeblesAcc = set_combine(sets.midcast.IntEnfeebles, {
		body="Atrophy Tabard +2",
        ring2="Stikini Ring"
        })

    sets.midcast.SkillEnfeebles = {
        main=gear.GrioENF,
		sub="Enki Strap",
		ammo="Regal Gem",
		head="Viti. Chapeau +1",
		neck="Incanter's Torque",
		ear1="Regal Earring",
		ear2="Dignitary's earring",
		body="Atrophy Tabard +2",
		hands="Leth. Gantherots +1",
		ring1="Stikini Ring",
		ring2="Kishar Ring",
		back=gear.SucellosMACC,
		waist="Luminary Sash",
		legs=gear.ChironicLegsMACC,
		feet="Medium's sabots"
        }

    sets.midcast.EffectEnfeebles = {
        main=gear.GrioENF,
		sub="Enki Strap",
		ammo="Regal Gem",
		head="Atrophy Chapeau +2",
		neck="Erra Pendant",
		ear1="Regal Earring",
		ear2="Dignitary's earring",
		body="Lethargy Sayon +1",
		hands="Jhakri Cuffs +2",
		ring1="Stikini Ring",
		ring2="Kishar Ring",
		back=gear.SucellosMACC,
		waist="Luminary Sash",
		legs=gear.ChironicLegsMACC,
		feet="Medium's sabots"
        }

    sets.midcast.ElementalEnfeeble = sets.midcast.IntEnfeebles

    sets.midcast['Dia III'] = set_combine(sets.midcast.MndEnfeebles, sets.midcast.EffectEnfeebles, {head="Viti. Chapeau +1"})
    sets.midcast['Paralyze II'] = set_combine(sets.midcast.MndEnfeebles, {head="Vitiation Boots +1"})
    sets.midcast['Slow II'] = set_combine(sets.midcast.MndEnfeebles, {head="Viti. Chapeau +1"})

    sets.midcast['Dark Magic'] = {
		main="Rubicundity",
		sub="Ammurapi Shield",
		ammo="Pemphredo tathlum",
        head=gear.MerlinHeadMB,
		neck="Incanter's torque",
		ear1="Regal Earring",
		ear2="Dignitary's earring",
        body=gear.MerlinBodyMB,
		hands="Jhakri Cuffs +2",
		ring1="Stikini ring",
		ring2="Stikini ring",
        back=gear.SucellosMB,
		waist="Luminary sash",
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
		sub="Niobid strap",
		ammo="Pemphredo tathlum",
        head=gear.MerlinHeadMB,
		neck="Sanctity necklace",
		ear1="Regal earring",
		ear2="Friomisi earring",
        body=gear.MerlinBodyMB,
		hands="Jhakri cuffs +2",
		ring1="Shiva ring +1",
		ring2="Shiva ring +1",
        back=gear.SucellosMB,
		waist=gear.ElementalObi,
		legs=gear.MerlinLegsMB,
		feet=gear.MerlinFeetMB
		}	

    sets.midcast['Elemental Magic'].Seidr = set_combine(sets.midcast['Elemental Magic'], {
        sub="Enki Strap",
        body="Seidr Cotehardie",
        neck="Erra Pendant",
        })

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
		sub="Enki Strap",
		neck="Erra Pendant",
        ear2="Dignitary's Earring",
        })	
     
	sets.magic_burst = set_combine(sets.midcast['Elemental Magic'], { 
		neck="Mizukage-no-Kubikazari",
		hands="Amalric Cuffs",
		ring1="Locus Ring",
		ring2="Mujin Band"
		})
	 
    sets.midcast.Impact = {
		main=gear.GrioMB,
		sub="Enki strap",
		ammo="Pemphredo tathlum",
        head=empty,
		neck="Erra pendant",ear1="Regal Earring",
		ear2="Dignitary's Earring",
        body="Twilight cloak",
		hands="Jhakri Cuffs +2",
		ring1="Stikini ring",
		ring2="Stikini ring",
        back=gear.SucellosMB,
		waist="Luminary sash",
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
		hands="Atrophy Gloves +1",
		back="Ghostfyre Cape",
		legs="Lethargy Fuseau +1",
		feet="Lethargy Houseaux +1"
		}

    sets.buff.Saboteur = {hands="Leth. Gantherots +1"}

    
    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------
    
    sets.idle = {
        main="Bolelabunga",
		sub="Genmei Shield",
		ammo="Homiliary",
		head="Vitiation Chapeau +1",
		neck="Bathy Choker +1",
		ear1="Infused Earring",
		ear2="Ethereal Earring",
		body="Jhakri robe +2",
		hands="Ayanmo Manopolas +2",
		ring1="Sheltered Ring",
		ring2="Paguroidea Ring",
		back="Moonbeam Cape",
		waist="Flume Belt +1",
		legs="Carmine Cuisses +1",
		feet="Volte Boots"
        }

    sets.idle.DT = set_combine(sets.idle, {
        main="Bolelabunga",
		sub="Genmei's Shield",
		ammo="Staunch Tathlum",
		head="Ayanmo Zucchetto +2",
		neck="Loricate Torque +1",
		ear1="Odnowa Earring +1",
		ear2="Odnowa Earring",
		body="Ayanmo Corazza +2",
		hands="Ayanmo Manopolas +2",
		ring1="Defending Ring",
		ring2="Dark Ring",
		back="Moonbeam Cape",
		waist="Flume Belt",
		legs="Carmine Cuisses +1",
		feet="Ayanmo Gambieras +2"
        })

    sets.idle.Town = set_combine(sets.idle, {})

    sets.idle.Weak = sets.idle.DT

    sets.resting = set_combine(sets.idle, {
        main="Chatoyant Staff",
        })
    
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
    
    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT    

    sets.magic_burst = set_combine(sets.midcast['Elemental Magic'], { 
		neck="Mizu. Kubikazari", --10
        ring1="Mujin Band", --(5)
		ring2="Locus Ring"
        })

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
		main="Almace",sub="Genmei Shield",ammo="Ginsen",
		head="Ayanmo Zucchetto +2",neck="Ainia Collar",ear1="Telos Earring",ear2="Sherida Earring",
		body="Ayanmo Corazza +2",hands="Chironic Gloves",ring1="Petrov Ring",ring2="Ilabrat Ring",
		back=gear.SucellosCDC,waist="Kentarch Belt +1",legs="Ayanmo Cosciales +2",feet="Volte spats"
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

    -- No Magic Haste (74% DW to cap)
    sets.engaged.DW = {
        ammo="Ginsen",
		head="Ayanmo Zucchetto +2",neck="Ainia Collar",ear1="Telos Earring",ear2="Sherida Earring",
		body="Ayanmo Corazza +2",hands="Chironic Gloves",ring1="Petrov Ring",ring2="Ilabrat Ring",
		back=gear.SucellosCDC,waist="Kentarch Belt +1",legs="Carmine Cuisses +1",feet="Volte spats"
        } --41

    sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW, {
        neck="Combatant's Torque",
        ring2="Ilabrat Ring",
        })

    sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW.MidAcc, {
        ring1="Cacoethic Ring +1",
        })

    -- 15% Magic Haste (67% DW to cap)
    sets.engaged.DW.LowHaste = set_combine(sets.engaged.DW, {
        
        }) --41

    sets.engaged.DW.MidAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
        neck="Combatant's Torque",
        ring2="Ilabrat Ring",
        })

    sets.engaged.DW.HighAcc.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, {
        head="Carmine Mask +1",
        ring1="Ramuh Ring +1",
        })

    -- 30% Magic Haste (56% DW to cap)
    sets.engaged.DW.MidHaste = set_combine(sets.engaged.DW, {
        
        }) --41

    sets.engaged.DW.MidAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
        legs="Carmine Cuisses +1", --6
        neck="Combatant's Torque",
        ear2="Telos Earring",
        ring2="Ilabrat Ring",
        })

    sets.engaged.DW.HighAcc.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, {
        head="Carmine Mask +1",
        ear1="Cessance Earring",
        ring1="Ramuh Ring +1",
        waist="Olseni Belt",
        })

    -- 35% Magic Haste (51% DW to cap)
    sets.engaged.DW.HighHaste = set_combine(sets.engaged.DW, {
        
        }) --26

    sets.engaged.DW.MidAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
        legs="Carmine Cuisses +1", --6
        neck="Combatant's Torque",
        ring2="Ilabrat Ring",
        waist="Kentarch Belt +1",
        })

    sets.engaged.DW.HighAcc.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, {
        head="Carmine Mask +1",
        ear1="Cessance Earring",
        ring1="Ramuh Ring +1",
        waist="Olseni Belt",
        })

    -- 47% Magic Haste (36% DW to cap)
    sets.engaged.DW.MaxHaste = set_combine(sets.engaged.DW, {
        
        }) --10
    
    sets.engaged.DW.MidAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
        neck="Combatant's Torque",
        ring2="Ilabrat Ring",
        waist="Kentarch Belt +1",
        })

    sets.engaged.DW.HighAcc.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {
        head="Carmine Mask +1",
        legs="Carmine Cuisses +1", --6
        ear1="Cessance Earring",
        ring1="Ramuh Ring +1",
        waist="Olseni Belt",
        })


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------
--[[
    sets.engaged.Hybrid = {
        ammo="Staunch Tathlum", --2/2
        neck="Loricate Torque +1", --6/6
        ring2="Defending Ring", --10/10
        }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)

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
]]--

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
            equip(sets.midcast.EffectEnfeebles)
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
