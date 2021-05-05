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
    state.Buff.Sentinel = buffactive.sentinel or false
    state.Buff.Cover = buffactive.cover or false
    state.Buff.Doom = buffactive.Doom or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal','Acc','PDTAcc','Turtle','MDT')
    state.HybridMode:options('Normal', 'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT', 'HP', 'Reraise', 'Charm')
    state.MagicalDefenseMode:options('MDT', 'HP', 'Reraise', 'Charm')
    
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'MP', 'Knockback', 'MP_Knockback'}
    state.EquipShield = M(false, 'Equip Shield w/Defense')

    update_defense_mode()
    
    send_command('bind ^f11 gs c cycle MagicalDefenseMode')
    send_command('bind !f11 gs c cycle ExtraDefenseMode')
    send_command('bind @f10 gs c toggle EquipShield')
    send_command('bind @f11 gs c toggle EquipShield')

    select_default_macro_book(5)
	
	gear.AcroTPHead = {name ="Acro Helm", augments={'STR+5 DEX+5','Accuracy+14','Attack+14','Haste+3'}}
	gear.AcroTPBody = {name ="Acro Surcoat", augments={'STR+10','Accuracy+17 Attack+17','"Store TP"+6'}}
	gear.AcroTPLegs = {name ="Acro Breeches", augments={'STR+4 Dex+4','Accuracy+23','"Store TP"+6'}}
	gear.AcroTPFeet = {name ="Acro Leggings", augments={'STR+9','Accuracy+17 Attack+17','"Store TP"+6'}}
	gear.AcroWSBody = {name ="Acro Surcoat", augments={'STR+10','Attack+21','Weapon Skill Acc.+20'}}
	gear.AcroWSLegs = {name ="Acro Breeches", augments={'Accuracy+20 Attack+20','Weapon Skill Acc.+19','Weapon skill damage +3%'}}
	gear.AcroWSFeet = {name ="Acro Leggings", augments={'Attack+22','Weapon Skill Acc.+18','Weapon skill damage +3%'}}
	gear.RudianosFC = {name ="Rudianos's Mantle", augments={'"Fast Cast +10"'}}
	gear.RudianosEN = {name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+10','Enmity+10','Spell interruption rate down-10%',}}
	gear.RudianosWS = {name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
	
end

function user_unload()
    send_command('unbind ^f11')
    send_command('unbind !f11')
    send_command('unbind @f10')
    send_command('unbind @f11')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = {legs="Caballarius Breeches +1"}
    sets.precast.JA['Holy Circle'] = {feet="Rev. Leggings +3"}
    sets.precast.JA['Shield Bash'] = {hands="Cab. Gauntlets +1",ring1="Fenian Ring",ear1="Knightly Earring"}
    sets.precast.JA['Sentinel'] = {feet="Caballarius Leggings +1"}
    sets.precast.JA['Rampart'] = {head="Caballarius Coronet"}
    sets.precast.JA['Fealty'] = {body="Caballarius Surcoat +1"}
    sets.precast.JA['Divine Emblem'] = {feet="Chev. Sabatons +1"}
    sets.precast.JA['Cover'] = {head="Rev. Coronet +3"}

    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {
        head="Rev. Coronet +3",
        body="Rev. Surcoat +2",hands="Cab. Gauntlets +1",ring1="Aquasoul Ring",ring2="Aquasoul Ring",
        back=gear.RudianosFC,legs="Reverence Breeches +1",feet="Chev. Sabatons +1"}

	--Enmity set
	sets.precast.JA['Provoke'] = {ammo="Iron Gobbet",
        head="Loess Barbuta +1",neck="Unmoving collar +1",ear1="Trux earring",ear2="Cryptic earring",
        body="Souv. Cuirass +1",hands="Cab. Gauntlets +1",ring1="Apeile Ring +1",ring2="Apeile Ring",
        back=gear.RudianosEN,waist="Creed baudrier",legs="Cab. Breeches +1",feet="Chev. Sabatons +1"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Sonia's Plectrum",
        head="Rev. Coronet +3",
        body="Gorney Haubert +1",hands="Reverence Gauntlets +1",ring2="Asklepian Ring",
        back="Iximulew Cape",waist="Caudata Belt",legs="Reverence Breeches +1",feet="Whirlpool Greaves"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Step = {waist="Chaac Belt"}
    sets.precast.Flourish1 = {waist="Chaac Belt"}

    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Impatiens",head="Carmine Mask +1",neck="Baetyl Pendant",ear2="Loquacious Earring",body="Rev. Surcoat +2",
		hands="Leyline gloves",ring1="Lebeche Ring",ring2="Prolix Ring",back="Weard Mantle",legs="Eschite Cuisses",feet="Odyssean Greaves"}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Ginsen",
        head="Odyssean Helm",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
        body="Odyss. Chestplate",hands="Odyssean Gauntlets",ring1="Ifrit ring +1",ring2="Ifrit ring +1",
        back="Buquwik Cape",waist="Fotia Belt",legs="Valor. Hose",feet="Sulev. Leggings +2"}

    sets.precast.WS.Acc = {ammo="Ginsen",
        head="Yaoyotl Helm",neck="Fotia Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body=gear.AcroWSBody,hands="Buremte Gloves",ring1="Rajas Ring",ring2="Patricius Ring",
        back="Bleating Mantle",waist="Fotia Belt",legs="Valor. Hose",feet="Sulev. Leggings +2"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {ring1="Aquasoul Ring",ring2="Aquasoul Ring"})
    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {ring1="Leviathan Ring"})

    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {ammo="Jukukik Feather",hands="Miki. Gauntlets",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",back="Rudianos's Mantle"})
    sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc, {waist="Zoran's Belt"})

    sets.precast.WS['Sanguine Blade'] = {ammo="Ginsen",
        head="Pixie Hairpin +1",neck="Fotia Gorget",ear1="Crematio Earring",ear2="Friomisi Earring",
        body="Found. Breastplate",hands="Carmine Fin. Ga. +1",ring1="Archon Ring",ring2="Acumen Ring",
        back="Toro Cape",waist="Eschan Stone",legs="Eschite Cuisses",feet="Founder's Greaves"}	
    
    sets.precast.WS['Atonement'] = {ammo="Iron Gobbet",
        head="Champion's Galea",neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Cryptic Earring",
        body="Valorous Mail",hands="Cab. Gauntlets +1",ring1="Apeile Ring +1",ring2="Apeile Ring",
        back=gear.RudianosWS,waist="Fotia Belt",legs="Odyssean Cuisses",feet="Sulev. Leggings +2"}
		
	sets.precast.WS['Aeolian Edge'] = {ammo="Ginsen",
        head="Champion's Galea",neck="Fotia Gorget",ear1="Crematio Earring",ear2="Friomisi Earring",
        body="Phorcys Korazin",hands="Cab. Gauntlets +1",ring1="Arvina Ringlet +1",ring2="Acumen Ring",
        back="Toro Cape",waist="Eschan Stone",legs="Eschite Cuisses",feet="Founder's Greaves"}	
    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {ammo="Impatiens",head="Chev. Armet +1",ear1="Etiolation Earring",ear2="Loquacious Earring",body="Rev. Surcoat +2",hands="Yorium Gauntlets",ring2="Prolix Ring",
		back="Weard Mantle",legs="Eschite Cuisses",feet="Odyssean Greaves"}
   
    sets.midcast.Enmity = {ammo="Iron Gobbet",
        head="Loess Barbuta +1",neck="Unmoving Collar +1",ear1="Trux Earring",ear2="Cryptic earring",
        body="Souv. Cuirass +1",hands="Caballarius Gauntlets +1",ring1="Apeile Ring +1",ring2="Apeile Ring",
        back="Earthcry Mantle",waist="Creed baudrier",legs="Souv. Diechlings +1",feet="Chev. Sabatons +1"}

    sets.midcast.Flash = set_combine(sets.midcast.Enmity, {legs="Eschite Cuisses"})
    
    sets.midcast.Stun = sets.midcast.Flash
    
    sets.midcast.Cure = {ammo="Staunch tathlum +1",
        head="Souveran Schaller",neck="Willpower Torque",ear1="Nourish. Earring",ear2="Nourish. Earring +1",
        body="Jumalik Mail",hands="Macabre Gaunt. +1",ring1="Kunaji Ring",ring2="Asklepian Ring",
        back="Solemnity Cape",waist="Rumination Sash",legs="Founder's Hose",feet="Odyssean Greaves"}

    sets.midcast['Enhancing Magic'] = {ammo="Staunch tathlum +1",
        head="Souveran Schaller",neck="Incanter's Torque",ear1="Halasz Earring",ear2="Knightly Earring",
        body="Tartarus Platemail",hands="Eschite Gauntlets",ring1="Defending Ring",ring2="Moonlight Ring",
        back="Solemnity Cape",waist="Rumination Sash",legs="Carmine Cuisses +1",feet="Odyssean Greaves"}
		
	sets.midcast['Blue Magic'] = {ammo="Staunch tathlum +1",
        head="Souveran Schaller",neck="Unmoving Collar +1",ear1="Halasz Earring",ear2="Knightly Earring",
        body="Souv. Cuirass +1",hands="Eschite Gauntlets",ring1="Apeile Ring +1",ring2="Apeile Ring",
        back="Solemnity Cape",waist="Rumination Sash",legs="Founder's Hose",feet="Odyssean Greaves"}	
    
	sets.midcast['Divine Magic'] = {ammo="Staunch tathlum +1",
        head="Souveran Schaller",neck="Incanter's Torque",ear1="Halasz Earring",ear2="Knightly Earring",
        body="Tartarus Platemail",hands="Eschite Gauntlets",ring1="Defending Ring",ring2="Moonlight Ring",
        back="Solemnity Cape",waist="Rumination Sash",legs="Carmine Cuisses +1",feet="Odyssean Greaves"}
	
	sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'],{hands="Souv. Handsch +1",feet="Souveran Schuhs"})
    sets.midcast.Protect = {ring1="Sheltered Ring"}
    sets.midcast.Shell = {ring1="Sheltered Ring"}
    
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    sets.Reraise = {head="Twilight Helm", body="Twilight Mail"}
    
    sets.resting = {neck="Coatl gorget +1",
        ring1="Sheltered Ring",ring2="Paguroidea Ring",
        waist="Austerity Belt"}
    

    -- Idle sets
    --sets.idle = {ammo="Homiliary",
        --head="Jumalik Helm",neck="Coatl Gorget +1",ear1="Ethereal Earring",ear2="Infused Earring",
        --body="Chozoron coselete",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Sheltered ring",
        --back="Weard Mantle",waist="Flume belt",legs="Carmine Cuisses +1",feet="Volte Sollerets"}

	--sets.idle = {ammo="Staunch tathlum +1",
        --head="Jumalik Helm",neck="Loricate Torque +1",ear1="Ethereal Earring",ear2="Infused Earring",
        --body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Sheltered Ring",
        --back="Shadow Mantle",waist="Flume Belt",legs="Carmine Cuisses +1",feet="Rev. Leggings +3"}
	
	sets.idle = {ammo="Staunch tathlum +1",
        head="Rev. Coronet +3",neck="Loricate Torque +1",ear1="Ethereal Earring",ear2="Genmei Earring",
        body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonlight Ring",
        back="Weard Mantle",waist="Tempus Fugit",legs="Souv. Diechlings +1",feet="Rev. Leggings +3"}

    sets.idle.Town = {ammo="Staunch tathlum +1",
        head="Jumalik helm",neck="Coatl gorget +1",ear1="Ethereal Earring",ear2="Infused Earring",
        body="Tartarus Platemail",hands="Souv. Handsch. +1",ring1="Paguroidea Ring",ring2="Sheltered Ring",
        back="Weard Mantle",waist="Flume belt",legs="Carmine Cuisses +1",feet="Volte Sollerets"}
    
    sets.idle.Weak = {ammo="Homiliary",head="Twilight helm",neck="Coatl gorget +1",ear1="Ethereal Earring",ear2="Infused Earring",
        body="Twilight Mail",hands="Souv. Handsch. +1",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Weard Mantle",waist="Flume belt",legs="Souv. Diechlings +1",feet="Rev. Leggings +3"}
    
    sets.idle.Weak.Reraise = set_combine(sets.idle.Weak, sets.Reraise)
    
    sets.Kiting = {legs="Carmine Cuisses +1"}

    sets.latent_refresh = {waist="Fucho-no-obi"}


    --------------------------------------
    -- Defense sets
    --------------------------------------
    
    -- Extra defense sets.  Apply these on top of melee or defense sets.
    sets.Knockback = {back="Repulse Mantle"}
    sets.MP = {neck="Coatl gorget +1",waist="Flume Belt"}
    sets.MP_Knockback = {neck="Coatl gorget +1",waist="Flume Belt",back="Repulse Mantle"}
    
    -- If EquipShield toggle is on (Win+F10 or Win+F11), equip the weapon/shield combos here
    -- when activating or changing defense mode:
    sets.PhysicalShield = {main="Burtgang",sub="Ochain"} -- Ochain
    sets.MagicalShield = {main="Burtgang",sub="Aegis"} -- Aegis

    -- Basic defense sets.
        
    sets.defense.PDT = {ammo="Staunch tathlum +1",
        head="Volte Salade",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Sanare Earring",
        body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonlight Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Volte Brayettes",feet="Volte Sollerets"}
    sets.defense.PDTacc = {ammo="Staunch tathlum +1",
        head="Rev. Coronet +3",neck="Loricate Torque +1",ear1="Ethereal Earring",ear2="Zennaroi Earring",
        body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Patricius ring",
        back="Weard Mantle",waist="Flume Belt",legs="Odyssean Cuisses",feet="Volte Sollerets"}
    sets.defense.Reraise = {ammo="Staunch tathlum +1",
        head="Twilight Helm",neck="Loricate Torque +1",ear1="Ethereal Earring",ear2="Genmei Earring",
        body="Twilight Mail",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonlight Ring",
        back="Weard Mantle",waist="Nierenschutz",legs="Chev. Cuisses +1",feet="Rev. Leggings +3"}
    sets.defense.Charm = {ammo="Iron Gobbet",
        head="Rev. Coronet +3",neck="Lavalier +1",ear1="Creed Earring",ear2="Buckler Earring",
        body="Rev. Surcoat +2",hands="Reverence Gauntlets +1",ring1="Defending Ring",ring2="Moonlight Ring",
        back="Shadow Mantle",waist="Flume Belt",legs="Souv. Diechlings +1",feet="Rev. Leggings +3"}
    -- To cap MDT with Shell IV (52/256), need 76/256 in gear.
    -- Shellra V can provide 75/256, which would need another 53/256 in gear.
    sets.defense.MDT = {ammo="Staunch tathlum +1",
        head="Rev. Coronet +3",neck="Loricate Torque +1",ear1="Ethereal Earring",ear2="Genmei Earring",
        body="Tartarus Platemail",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape +1",waist="Nierenschutz",legs="Souv. Diechlings +1",feet="Volte Sollerets"}


    --------------------------------------
    -- Engaged sets
    --------------------------------------
    
    sets.engaged = {ammo="Ginsen",
        head="Hjarrandi Helm",neck="Defiant Collar",ear1="Digni. Earring",ear2="Brutal Earring",
        body="Hjarrandi Breast.",hands="Odyssean gauntlets",ring1="Petrov Ring",ring2="Moonlight Ring",
        back="Rudianos's Mantle",waist="Tempus Fugit",legs="Odyssean Cuisses",feet="Valorous Greaves"}

    sets.engaged.Acc = {ammo="Ginsen",
        head="Valorous Mask",neck="Subtlety Spec.",ear1="Cessance Earring",ear2="Zennaroi Earring",
        body="Odyss. Chestplate",hands="Odyssean gauntlets",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back="Weard Mantle",waist="Olseni Belt",legs="Odyssean Cuisses",feet="Chev. Sabatons +1"}

	sets.engaged.PDTAcc = {ammo="Staunch tathlum +1",
        head="Volte Salade",neck="Loricate Torque +1",ear1="Ethereal Earring",ear2="Genmei Earring",
        body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonlight Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Volte Brayettes",feet="Volte Sollerets"}
	
    sets.engaged.Turtle = {ammo="Staunch tathlum +1",
        head="Rev. Coronet +3",neck="Loricate Torque +1",ear1="Ethereal Earring",ear2="Genmei Earring",
        body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonlight Ring",
        back="Weard Mantle",waist="Tempus Fugit",legs="Souv. Diechlings +1",feet="Rev. Leggings +3"}
	
	sets.engaged.MDT = {ammo="Staunch tathlum +1",
        head="Rev. Coronet +3",neck="Loricate Torque +1",ear1="Ethereal Earring",ear2="Genmei Earring",
        body="Tartarus Platemail",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape +1",waist="Nierenschutz",legs="Souv. Diechlings +1",feet="Volte Sollerets"}
	
    sets.engaged.DW = {ammo="Ginsen",
        head="Hjarrandi Helm",neck="Defiant Collar",ear1="Digni. Earring",ear2="Brutal Earring",
        body="Hjarrandi Breast.",hands="Odyssean gauntlets",ring1="Petrov Ring",ring2="Moonlight Ring",
        back="Rudianos's Mantle",waist="Windbuffet Belt +1",legs="Odyssean Cuisses",feet="Valorous Greaves"}

    sets.engaged.DW.Acc = {ammo="Staunch tathlum +1",
        head="Rev. Coronet +3",neck="Loricate Torque +1",ear1="Creed Earring",ear2="Buckler Earring",
        body="Rev. Surcoat +2",hands="Reverence Gauntlets +1",ring1="Defending Ring",ring2="Moonlight Ring",
        back="Shadow Mantle",waist="Flume Belt",legs="Reverence Breeches +1",feet="Rev. Leggings +3"}

    sets.engaged.PDT = set_combine(sets.engaged, {body="Caballarius Surcoat +1",neck="Loricate Torque +1",ring1="Defending Ring"})
    sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, {head="Ighwa Cap",body="Caballarius Surcoat +1",neck="Agitator's Collar",ear1="Ethereal earring",ear2="Zennaroi earring",ring1="Defending Ring"})
    sets.engaged.Reraise = set_combine(sets.engaged, sets.Reraise)
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc, sets.Reraise)

    sets.engaged.DW.PDT = set_combine(sets.engaged.DW, {body="Rev. Surcoat +2",neck="Loricate Torque +1",ring1="Defending Ring"})
    sets.engaged.DW.Acc.PDT = set_combine(sets.engaged.DW.Acc, {body="Rev. Surcoat +2",neck="Loricate Torque +1",ring1="Defending Ring"})
    sets.engaged.DW.Reraise = set_combine(sets.engaged.DW, sets.Reraise)
    sets.engaged.DW.Acc.Reraise = set_combine(sets.engaged.DW.Acc, sets.Reraise)


    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Doom = {ring2="Saida Ring"}
    sets.buff.Cover = {head="Rev. Coronet +3", body="Caballarius Surcoat +1"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_midcast(spell, action, spellMap, eventArgs)
    -- If DefenseMode is active, apply that gear over midcast
    -- choices.  Precast is allowed through for fast cast on
    -- spells, but we want to return to def gear before there's
    -- time for anything to hit us.
    -- Exclude Job Abilities from this restriction, as we probably want
    -- the enhanced effect of whatever item of gear applies to them,
    -- and only one item should be swapped out.
    if state.DefenseMode.value ~= 'None' and spell.type ~= 'JobAbility' then
        handle_equipping_gear(player.status)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
    classes.CustomDefenseGroups:clear()
    classes.CustomDefenseGroups:append(state.ExtraDefenseMode.current)
    if state.EquipShield.value == true then
        classes.CustomDefenseGroups:append(state.DefenseMode.current .. 'Shield')
    end

    classes.CustomMeleeGroups:clear()
    classes.CustomMeleeGroups:append(state.ExtraDefenseMode.current)
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_defense_mode()
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    
    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    
    return meleeSet
end

function customize_defense_set(defenseSet)
    if state.ExtraDefenseMode.value ~= 'None' then
        defenseSet = set_combine(defenseSet, sets[state.ExtraDefenseMode.value])
    end
    
    if state.EquipShield.value == true then
        defenseSet = set_combine(defenseSet, sets[state.DefenseMode.current .. 'Shield'])
    end
    
    if state.Buff.Doom then
        defenseSet = set_combine(defenseSet, sets.buff.Doom)
    end
    
    return defenseSet
end


function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end

    if state.ExtraDefenseMode.value ~= 'None' then
        msg = msg .. ', Extra: ' .. state.ExtraDefenseMode.value
    end
    
    if state.EquipShield.value == true then
        msg = msg .. ', Force Equip Shield'
    end
    
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_defense_mode()
    if player.equipment.main == 'Kheshig Blade' and not classes.CustomDefenseGroups:contains('Kheshig Blade') then
        classes.CustomDefenseGroups:append('Kheshig Blade')
    end
    
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        if player.equipment.sub and not player.equipment.sub:contains('Shield') and
           player.equipment.sub ~= 'Aegis' and player.equipment.sub ~= 'Ochain' then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(5, 5)
    elseif player.sub_job == 'NIN' then
        set_macro_page(4, 5)
    elseif player.sub_job == 'RDM' then
        set_macro_page(3, 5)
    else
        set_macro_page(2, 5)
    end
end