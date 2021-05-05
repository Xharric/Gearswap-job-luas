-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-----------------------------------------------------------------------------------------------------------------
include('organizer-lib')
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'BuffNormal', 'BuffMidAcc', 'FullAcc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')
 
        gear.default.obi_waist = "Yamabuki-no-obi"
   
         gear.TaeonTAHead = {name ="Taeon Chapeau", augments={'STR+7 DEX+7','Accuracy+16 Attack+16','"Triple Atk."+2'}}
		 gear.TaeonWSHead = {name ="Taeon Chapeau", augments={'STR+6 VIT+6','"Mag. Atk. Bns."+18'}}
		 gear.TaeonTPBody = {name ="Taeon Tabard", augments={'DEX+7','Accuracy+17 Attack+17','"Triple Atk."+2'}}
		 gear.TaeonTAHands = {name ="Taeon Gloves", augments={'DEX+9','Accuracy+18 Attack+18','"Triple Atk."+2'}}
		 gear.TaeonWSHands = {name ="Taeon Gloves", augments={'"Mag. Atk. Bns."+19','"Recycle"+2','Weapon skill damage +2%'}}
		 gear.TaeonTALegs = {name ="Taeon Tights", augments={'STR+5 DEX+5','Accuracy+20 Attack+20','"Triple Atk."+2'}}
		 gear.TaeonDWFeet = {name ="Taeon Boots", augments={'STR+5 DEX+5','Accuracy+23','"Dual Wield"+5'}}
		 gear.TaeonTAFeet = {name = "Taeon Boots", augments={'STR+9','Accuracy+20 Attack+20','"Triple Atk."+2'}}
		 gear.HercTPHead = {name ="Herculean Helm", augments={'Attack+26','"Triple Atk."+4','AGI+7','Accuracy+11',}}
		 gear.HercWSHead = {name ="Herculean Helm", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Weapon skill damage +2%','"Mag.Atk.Bns."+9',}}
		 gear.HercTPLegs = {name="Herculean Trousers", augments={'Accuracy+25 Attack+25','"Triple Atk."+2','Accuracy+10','Attack+5',}}
		 gear.HercWSLegs = {name="Herculean Trousers", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Crit.hit rate+2','STR+8','Mag. Acc.+3','"Mag.Atk.Bns."+12',}}
		 gear.HercTPFeet = {name="Herculean Boots", augments={'Accuracy+23 Attack+23','"Triple Atk."+2','Accuracy+12',}}
		 gear.HercWSFeet = {name="Herculean Boots", augments={'"Waltz" potency +4%','"Mag.Atk.Bns."+23','Mag. Acc.+16 "Mag.Atk.Bns."+16',}}
		 gear.TPRosmerta = {name = "Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}}
         
    -- Additional local binds
    send_command('bind ^` input /ja "Chain Affinity" <me>')
    send_command('bind !` input /ja "Efflux" <me>')
    send_command('bind @` input /ja "Burst Affinity" <me>')
 
    update_combat_form()
    select_default_macro_book(1, 16)
end
 
 
-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind @`')
end
 
 
-- Set up gear sets.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
 
    sets.buff['Burst Affinity'] = {feet="Hashishin Basmak +1"}
    sets.buff['Chain Affinity'] = {}
    sets.buff.Convergence = {}
    sets.buff.Diffusion = {feet="Luhlaza Charuqs +1"}
    sets.buff.Enchainment = {}
    sets.buff.Efflux = {}
 
   
    -- Precast Sets
   
    -- Precast sets to enhance JAs
    sets.precast.JA['Azure Lore'] = {}
 
 
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {feet="Rawhide boots"}
       
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
 
    -- Fast cast sets for spells
   
    sets.precast.FC = {ammo="Impatiens",
        head="Herculean Helm",neck="Baetyl Pendant",ear1="Etiolation Earring",ear2="Loquacious Earring",
        body="Samnuha Coat",hands="Leyline gloves",ring1="Kishar Ring",ring2="Lebeche ring",
        back="Swith Cape",waist="Witful Belt",legs="Psycloth Lappas",feet="Telchine Pigaches"}
       
    sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body="Hashishin Mintan +1"})
 
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Ginsen",
        head="Adhemar Bonnet +1",neck="Fotia gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
        body="Abnoba Kaftan",hands="Rawhide Gloves",ring1="Rufescent ring",ring2="Ifrit Ring +1",
        back="Buquwik Cape",waist="Fotia belt",legs="Samnuha tights",feet=gear.HercTPFeet}
   
    sets.precast.WS.acc = set_combine(sets.precast.WS, {ammo="Mantoptera Eye",
        head="Adhemar Bonnet +1",
        body="Adhemar Jacket +1",hands="Rawhide gloves",
        back="Rosmerta's Cape"})
 
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Chant du Cygne'] = {ammo="Mantoptera Eye",
        head="Adhemar Bonnet +1",neck="Fotia gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
        body="Abnoba Kaftan",hands="Rawhide Gloves",ring1="Rajas Ring",ring2="Apate Ring",
        back="Rosmerta's Cape",waist="Grunfeld Rope",legs="Samnuha tights",feet=gear.HercTPFeet}
   
    --sets.precast.WS['Chant du Cygne'].Acc = {ammo="Jukukik feather",
      --  head=gear.TaeonHeadTA,neck="Fotia gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
       -- body="Adhemar Jacket +1",hands="Rawhide gloves",ring1="Ramuh Ring +1",ring2="Epona's Ring",
        --back="Rancorous Mantle",waist="Fotia belt",legs="Samnuha tights",feet=gear.TaeonFeetTA}
   
    --sets.precast.WS['Requiescat'] = {neck="Mantoptera Eye",
        --head="Hashishin kavuk +1",neck="Fotia gorget",ear1="Steelflash earring",ear2="Bladeborn earring",
        --body="Adhemar Jacket +1",hands=gear.TaeonHandsTA,ring1="Rajas ring",ring2="Epona's ring",
        --back="Rosmerta's Cape",waist="Fotia belt",legs="Quiahuiz trousers",feet="Rawhide boots"}
   
    --sets.precast.WS['Requiescat'].Acc = {neck="Mantoptera Eye",
        --head="Hashishin kavuk +1",neck="Fotia gorget",ear1="Steelflash earring",ear2="Bladeborn earring",
        --body="Adhemar Jacket +1",hands=gear.TaeonHandsTA,ring1="Ramuh ring +1",ring2="Epona's ring",
        --back="Letalis mantle",waist="Fotia belt",legs="Quiahuiz trousers",feet="Rawhide boots"}
       
    sets.precast.WS['Savage Blade'] = {ammo="Ginsen",
        head="Adhemar Bonnet +1",neck="Fotia gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
        body="Abnoba Kaftan",hands="Rawhide Gloves",ring1="Rufescent ring",ring2="Ifrit Ring +1",
        back="Cornflower cape",waist="Fotia belt",legs="Samnuha tights",feet=gear.HercTPFeet}
       
    --sets.precast.WS['Expiacion'].Acc = {ammo="Jukukik feather",
     --   head="Hashishin kavuk +1",neck="Fotia gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
       -- body="Adhemar Jacket +1",hands="Rawhide gloves",ring1="Rajas ring",ring2="Epona's Ring",
        --back="Cornflower cape",waist="Fotia belt",legs="Samnuha tights",feet="Rawhide boots"}
 
    sets.precast.WS['Sanguine Blade'] = {ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Crematio Earring",
        body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Archon Ring",ring2="Acumen Ring",
        back="Cornflower cape",waist="Eschan stone",legs="Jhakri Slops +2",feet="Hashishin Basmak +1"}
   
    sets.precast.WS['Seraph Blade'] = {ammo="Pemphredo Tathlum",
        head="Jhakri Coronal +2",neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Crematio Earring",
        body="Jhakri Robe +2",hands="Amalric Gages",ring1="Arvina Ringlet +1",ring2="Acumen Ring",
        back="Cornflower cape",waist="Eschan stone",legs="Jhakri Slops +2",feet="Hashishin Basmak +1"}
   
    sets.precast.WS['Flash Nova'] = {ammo="Pemphredo Tathlum",
        head="Jhakri Coronal +2",neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Crematio Earring",
        body="Jhakri Robe +2",hands="Amalric Gages",ring1="Arvina Ringlet +1",ring2="Acumen Ring",
        back="Cornflower cape",waist="Eschan stone",legs="Jhakri Slops +2",feet="Hashishin Basmak +1"}
       
    --To ensure Organizer grabs some otherwise undefined gear.--
    sets.precast.WS['Drakesbane'] = {ring1="Warp Ring",ring2="Capacity Ring"}  
   
    -- Midcast Sets
    sets.midcast.FastRecast = {ammo="Impatiens",
        head="Herculean Helm",neck="Baetyl Pendant",ear1="Etiolation Earring",ear2="Loquacious Earring",
        body="Samnuha Coat",hands="Leyline gloves",ring1="Kishar Ring",ring2="Lebeche ring",
        back="Swith Cape",waist="Witful Belt",legs="Psycloth Lappas",feet="Telchine Pigaches"}
       
    sets.midcast['Blue Magic'] = set_combine(sets.midcast.FastRecast,{body="Hashishin Mintan +1"})
   
    sets.midcast.Aquaveil = set_combine(sets.midcast.FastRecast, {
        })
   
    -- Physical Spells --
   
    sets.midcast['Blue Magic'].Physical = {ammo="Mantoptera Eye",
        head="Dampening tam",neck="Subtlety Spectacles",ear1="Zennaroi earring",ear2="Heartseeker earring",
        body="Samnuha Coat",hands="Leyline gloves",ring1="Rajas Ring",ring2="Apate ring",
        back="Cornflower Cape",waist="Kentarch belt +1",legs="Samnuha Tights",feet=gear.HercTPFeet}
 
    sets.midcast['Blue Magic'].PhysicalAcc = set_combine(sets.midcast['Blue Magic'].Physical,{})
 
    sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical,{})
 
    sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical,{})
 
    sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical,{})
 
    sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical,{})
 
    sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical,{})
 
    sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical,{})
 
    sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical,{})
 
    sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical,{})
 
 
    -- Magical Spells --
   
    sets.midcast['Blue Magic'].Magical = {ammo="Pemphredo Tathlum",
        head="Jhakri Coronal +2",neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Regal earring",
        body="Jhakri Robe +2",hands="Amalric Gages",ring1="Arvina Ringlet +1",ring2="Acumen Ring",
        back="Cornflower cape",waist="Eschan Stone",legs="Jhakri Slops +2",feet="Hashishin Basmak +1"}
 
    sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical,
        {ear1="Lifestorm Earring", ear2= "Psystorm Earring", ring1="Metamorph Ring +1",ring2="Sangoma ring",
        })
       
    sets.midcast['Tenebral Crush'] = set_combine(sets.midcast['Blue Magic'].Magical,{ring2="Archon ring"})
   
    sets.midcast['Blank Gaze'] = {ammo="Mavi Tathlum",
        head="Jhakri Coronal +2",neck="Baetyl Pendant",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body="Jhakri Robe +2",hands="Rawhide Gloves",ring1="Metamorph Ring +1",ring2="Sangoma Ring",
        back="Cornflower Cape",waist="Eschan Stone",legs="Psycloth Lappas",feet="Hashishin Basmak +1"}
   
    sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical,{})
 
    sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical)
 
    sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical,{})
 
    sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical)
 
    sets.midcast['Blue Magic'].MagicAccuracy = {ammo="Mavi Tathlum",
        head="Dampening tam",neck="Sanctity Necklace",ear1="Lifestorm earring",ear2="Psystorm earring",
        body="Jhakri Robe +2",hands="Amalric Gages",ring1="Metamorph Ring +1",ring2="Sangoma Ring",
        back="Cornflower Cape",waist="Eschan stone",legs="Psycloth lappas",feet="Hashishin Basmak +1"}
 
    -- Breath Spells --
   
    sets.midcast['Blue Magic'].Breath = {ammo="Mavi Tathlum",
        head="Jhakri Coronal +2",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Crematio earring",
        body="Jhakri Robe +2",hands="Amalric Gages",ring1="Shiva ring +1",ring2="Fenrir ring +1",
        back="Cornflower cape",waist="Eschan Stone",legs="Jhakri Slops +2",feet="Hashishin Basmak +1"}
 
    -- Other Types --
   
    sets.midcast['Blue Magic'].Stun = set_combine(sets.midcast['Blue Magic'].MagicAccuracy,
        {neck="Mantoptera Eye",
        ear1="Zennaroi earring",ear2="Heartseeker earring",
        body="Jhakri Robe +2",hands="Rawhide gloves",ring1="Metamorph Ring +1",ring2="Sangoma ring",
        back="Cornflower cape",waist="Eschan stone",legs="Psycloth lappas"})
 
    sets.midcast['Blue Magic'].SkillBasedBuff = {ammo="Mavi Tathlum",
        hands="Rawhide gloves",
        back="Cornflower Cape",feet="Luhlaza Charuqs +1"}
 
    sets.midcast['Blue Magic'].Buff = {}
       
    sets.midcast['Blue Magic']['White Wind'] = {}
 
    sets.midcast['Blue Magic'].Healing = {
        neck="Phalaina locket", ear1= "Mendicant's Earring",
        body="Telchine Chasuble",hands="Telchine Gloves",ring2="Lebeche ring",
        back="Solemnity Cape",legs="Telchine Braconi",feet="Medium's Sabots"}
   
    sets.midcast.Protect = {ring1="Sheltered Ring"}
    sets.midcast.Protectra = {ring1="Sheltered Ring"}
    sets.midcast.Shell = {ring1="Sheltered Ring"}
    sets.midcast.Shellra = {ring1="Sheltered Ring"}
   
 
   
   
    -- Sets to return to when not performing an action.
 
    -- Gear for learning spells: +skill and AF hands.
    sets.PDT = {neck="Mantoptera Eye",
        head="Lithelimb cap",neck="Loricate Torque +1",ear1="Zennaroi earring",ear2="Suppanomimi",
        body="Emet Harness +1",hands="Umuthi gloves",ring1="Defending Ring",ring2="Dark Ring",
        back="Solemnity Cape",waist="Flume Belt",legs="Iuitl tights +1",feet=gear.HercTPFeet}
 
    sets.latent_refresh = {waist="Fucho-no-obi"}
 
    -- Resting sets
    sets.resting = {ammo="Impatiens",
        ear1="Sanare earring",ear2="Ethereal Earring",
        hands="Herculean Gloves",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        waist="Fucho-no-obi",legs="Carmine Cuisses +1",feet=gear.HercTPFeet}
   
    -- Idle sets
    sets.idle = {ammo="Impatiens",
        head="Rawhide Mask",neck="Loricate Torque +1",ear1="Etiolation earring",ear2="Ethereal Earring",
        body="Jhakri Robe +2",hands="Herculean Gloves",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Solemnity Cape",waist="Fucho-no-obi",legs="Carmine Cuisses +1",feet=gear.HercTPFeet}
 
    sets.idle.PDT = {ammo="Impatiens",
        neck="Loricate Torque +1",ear1="Sanare earring",ear2="Ethereal Earring",
        body="Jhakri Robe +2",hands="Umuthi gloves",ring1="Defending Ring",ring2="Dark Ring",
        back="Solemnity Cape",waist="Flume Belt",legs="Carmine Cuisses +1",feet=gear.HercTPFeet}
 
    sets.idle.Town = {ammo="Impatiens",
        head="Rawhide Mask",neck="Loricate Torque +1",ear1="Etiolation earring",ear2="Ethereal Earring",
        body="Councilor's Garb",hands="Herculean Gloves",ring1="Sheltered Ring",ring2="Trizek Ring",
        back="Solemnity Cape",waist="Fucho-no-obi",legs="Carmine Cuisses +1",feet=gear.HercTPFeet}
 
    sets.idle.Learning = set_combine(sets.idle, sets.Learning)
 
   
    -- Defense sets
    sets.defense.PDT = {neck="Mantoptera Eye",
        head="Lithelimb cap",neck="Loricate Torque +1",ear1="Genmei earring", ear2="Suppanomimi",
        body="Emet harness +1",hands="Umuthi gloves",ring1="Defending Ring",ring2="Dark ring",
        back="Solemnity Cape",waist="Flume Belt",legs=gear.HercTPLegs,feet=gear.HercTPFeet}
 
    sets.defense.MDT = {neck="Mantoptera Eye",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation earring", ear2="Sanare Earring",
        body="Emet harness +1",hands="Umuthi Gloves",ring1="Defending Ring",ring2="Shadow ring",
        back="Solemnity Cape",waist="Flume belt",legs=gear.HercTPLegs,feet=gear.HercTPFeet}
 
    sets.Kiting = {legs="Carmine Cuisses +1"}
 
    -- Engaged sets
 
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
   
    -- Normal melee group
    sets.engaged = {ammo="Ginsen",
        head="Adhemar Bonnet +1",neck="Defiant Collar",ear1="Brutal Earring",ear2="Suppanomimi",
        body="Adhemar Jacket +1",hands="Adhemar Wrist. +1",ring1="Petrov Ring",ring2="Epona's Ring",
        back="Rosmerta's Cape",waist="Windbuffet belt +1",legs="Samnuha tights",feet=gear.HercTPFeet}
 
    sets.engaged.BuffNormal = {ammo="Ginsen",
        head="Adhemar Bonnet +1",neck="Defiant Collar",ear1="Brutal Earring",ear2="Suppanomimi",
        body="Adhemar Jacket +1",hands="Adhemar Wrist. +1",ring1="Petrov Ring",ring2="Epona's Ring",
        back="Rosmerta's Cape",waist="Windbuffet belt +1",legs="Samnuha tights",feet=gear.HercTPFeet}
       
    sets.engaged.BuffMidAcc = {ammo="Ginsen",
        head="Dampening Tam",neck="Defiant Collar",ear1="Brutal Earring",ear2="Suppanomimi",
        body="Herculean Vest",hands="Adhemar Wrist. +1",ring1="Petrov Ring",ring2="Epona's Ring",
        back="Rosmerta's Cape",waist="Windbuffet belt +1",legs="Samnuha tights",feet=gear.HercTPFeet}
       
    sets.engaged.FullAcc = {ammo="Ginsen",
        head="Dampening Tam",neck="Combatant's Torque",ear1="Digni. Earring",ear2="Zennaroi Earring",
        body="Herculean Vest",hands="Herculean Gloves",ring1="Cacoethic Ring +1",ring2="Ramuh Ring +1",
        back="Rosmerta's Cape",waist="Kentarch Belt +1",legs="Carmine Cuisses +1",feet=gear.HercTPFeet}
 
       
       
    sets.engaged.DW = {ammo="Ginsen",
        head="Dampening Tam",neck="Defiant Collar",ear1="Brutal Earring",ear2="Suppanomimi",
        body="Adhemar Jacket +1",hands="Herculean Gloves",ring1="Haverton Ring",ring2="Epona's Ring",
        back="Rosmerta's Cape",waist="Windbuffet belt +1",legs="Samnuha tights",feet=gear.HercTPFeet}
 
    sets.engaged.DW.BuffNormal = {ammo="Ginsen",
        head="Dampening Tam",neck="Combatant's Torque",ear1="Brutal Earring",ear2="Suppanomimi",
        body="Adhemar Jacket +1",hands="Herculean Gloves",ring1="Petrov Ring",ring2="Epona's Ring",
        back="Rosmerta's Cape",waist="Windbuffet belt +1",legs="Samnuha Tights",feet=gear.HercTPFeet}
       
    sets.engaged.DW.BuffMidAcc = {ammo="Ginsen",
        head="Dampening Tam",neck="Combatant's Torque",ear1="Digni. Earring",ear2="Suppanomimi",
        body="Adhemar Jacket +1",hands="Herculean Gloves",ring1="Petrov Ring",ring2="Epona's Ring",
        back="Rosmerta's Cape",waist="Kentarch belt +1",legs="Samnuha Tights",feet=gear.HercTPFeet}
       
    sets.engaged.DW.FullAcc = {ammo="Ginsen",
        head="Dampening Tam",neck="Combatant's Torque",ear1="Digni. Earring",ear2="Zennaroi Earring",
        body="Adhemar Jacket +1",hands="Herculean Gloves",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back="Rosmerta's Cape",waist="Kentarch Belt +1",legs="Carmine Cuisses +1",feet=gear.HercTPFeet}
 
    sets.self_healing = {}
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if unbridled_spells:contains(spell.english) and not state.Buff['Unbridled Learning'] then
        eventArgs.cancel = true
        windower.send_command('@input /ja "Unbridled Learning" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
    end
custom_aftermath_timers_precast(spell)
end
 
-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Add enhancement gear for Chain Affinity, etc.
    if spell.skill == 'Blue Magic' then
        for buff,active in pairs(state.Buff) do
            if active and sets.buff[buff] then
                equip(sets.buff[buff])
            end
        end
        if spellMap == 'Healing' and spell.target.type == 'SELF' and sets.self_healing then
            equip(sets.self_healing)
        end
    end
 
    -- If in learning mode, keep on gear intended to help with that, regardless of action.
    if state.OffenseMode.value == 'Learning' then
        equip(sets.Learning)
    end
end
 
function job_aftercast(spell, action, spellMap, eventArgs)
custom_aftermath_timers_aftercast(spell)
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
    end
end
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
 
-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end
 
-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end
 
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
function update_combat_form()
    -- Check for H2H or single-wielding
    if player.equipment.sub == "Culminus" or player.equipment.sub == 'empty' then
        state.CombatForm:reset()
    else
        state.CombatForm:set('DW')
    end
end
 
 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 9)
    else
        set_macro_page(1, 9)
    end
end