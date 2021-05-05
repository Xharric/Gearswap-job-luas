-- Setup vars that are user-dependent.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc','HighAcc','MaxAcc')
    state.HybridMode:options('Normal', 'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Acc', 'HighAcc', 'MaxAcc')
    --state.PhysicalDefenseMode:options('PDT', 'Reraise')
	
	gear.TakahaMeditate = {name="Takaha mantle", augments={'STR+5','"Store TP"+3','"Zanshin"+3','Meditate eff. dur. +6'}}
	gear.TakahaSTP = {name="Takaha mantle", augments={'STR+5','"Store TP"+3','"Zanshin"+3','Meditate eff. dur. +6'}}
	gear.SmertriosTP = {name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}}
	gear.SmertriosWS = {name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	
    update_combat_form()
    
    -- Additional local binds
	
    select_default_macro_book(04,04)
	
	gear.AcroTPHead = {name ="Acro Helm", augments={'STR+5 DEX+5','Accuracy+14 Attack+14','Haste+3'}}
	gear.AcroTPBody = {name ="Acro Surcoat", augments={'STR+10','Accuracy+17 Attack+17','"Store TP"+6'}}
	gear.AcroWSBody = {name ="Acro Surcoat", augments={'STR+10','Attack+21','Weapon Skill Acc.+20'}}
	gear.AcroTPHands = {name ="Acro Gauntlets", augments={'DEX+10','Accuracy+18 Attack+18','"Store TP"+6'}}
	gear.AcroTPLegs = {name ="Acro Breeches", augments={'STR+4 Dex+4','Accuracy+23','"Store TP"+6'}}
	gear.AcroWSLegs = {name ="Acro Breeches", augments={'Accuracy+20 Attack+20','Weapon Skill Acc.+19','Weapon skill damage +3%'}}
	gear.AcroTPFeet = {name ="Acro Leggings", augments={'STR+9','Accuracy+17 Attack+17','"Store TP"+6'}}
	gear.AcroWSFeet = {name ="Acro Leggings", augments={'Attack+22','Weapon Skill Acc.+18','Weapon skill damage +3%'}}
	gear.ValorHead = {name="Valorous Mask", augments={'Accuracy+17 Attack+17','Crit.hit rate+2','DEX+10','Accuracy+14','Attack+10'}}
	gear.ValorWSHands = {name="Valorous Mitts", augments={'Accuracy+15 Attack+15','STR+15','Accuracy+6','Attack+5',}}
	gear.ValorLegs = {name="Valor. Hose", augments={'Accuracy+25 Attack+25','Weapon skill damage +3%','VIT+5','Attack+4',}}
	gear.ValorWSFeet = {name="Valorous Greaves", augments={'Accuracy+21 Attack+21','Weapon skill damage +2%','STR+10','Accuracy+13'}}
	
end
 
-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Meditate = {head="Wakido Kabuto +3",hands="Sakonji Kote +3",back="Smertrios's mantle"}
    sets.precast.JA['Warding Circle'] = {head="Wakido Kabuto +3"}
    sets.precast.JA['Blade Bash'] = {hands="Sakonji Kote +3"}
    sets.precast.JA['Sekkanoki'] = {hands="Kasuga Kote +1"}
    sets.precast.JA['Sengikori'] = {hands="Unkai Sune-Ate +2"}
	
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Sonia's Plectrum",
        head="Yaoyotl Helm",
        body="Otronif Harness +1",hands="Buremte Gloves",ring1="Spiral Ring",
        back="Iximulew Cape",waist="Caudata Belt",legs="Karieyh Brayettes +1",feet="Amm Greaves"}
        
    -- Dont need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isnt any more specifically defined
    sets.precast.WS = {
        ammo="Knobkierrie", head="Mpaca's Cap",neck="Sam. Nodowa +2",ear1="Thrud Earring",ear2="Moonshade Earring",
        body="Sakonji Domaru +3",hands="Valorous Mitts",ring1="Epaminondas's Ring",ring2="Niqmaddu Ring",
        back=gear.SmertriosWS,waist="Fotia Belt",legs="Wakido Haidate +3",feet=gear.ValorWSFeet}
    
	sets.precast.WS.Acc = {
        ammo="Knobkierrie",head="Rao Kabuto +1",neck="Sam. Nodowa +2",ear1="Brutal Earring",ear2="Moonshade Earring",
        body="Sakonji Domaru +3",hands=gear.ValorWSHands,ring1="Regal Ring",ring2="Niqmaddu Ring",
        back=gear.SmertriosWS,waist="Fotia Belt",legs="Wakido Haidate +3",feet=gear.ValorWSFeet}
	
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isnt found.
    sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {waist="Windbuffet Belt +1"})
    sets.precast.WS['Tachi: Shoha'].Acc = set_combine(sets.precast.WS.Acc, {body="Ryuo Domaru",legs="Zoar Subligar +1"})
    sets.precast.WS['Tachi: Shoha'].HighAcc = set_combine(sets.precast.WS['Tachi: Shoha'].Acc, {waist="Fotia Belt",feet=gear.ValorWSFeet})
    sets.precast.WS['Tachi: Shoha'].MaxAcc = set_combine(sets.precast.WS['Tachi: Shoha'].HighAcc, {feet=gear.ValorWSFeet})
 
    sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS, {body="Sakonji Domaru +3"})
	sets.precast.WS['Tachi: Fudo'].Acc = set_combine(sets.precast.WS.Acc, {body="Sakonji Domaru +3", hands="Ken. Tekko"})
	sets.precast.WS['Tachi: Fudo'].HighAcc = set_combine(sets.precast.WS['Tachi: Fudo'].Acc, {back=gear.SmertriosTP, waist="Fotia Belt",feet=gear.ValorWSFeet})
    sets.precast.WS['Tachi: Fudo'].MaxAcc = set_combine(sets.precast.WS['Tachi: Fudo'].HighAcc, {back=gear.SmertriosTP,waist="Olseni Belt",ear2="Zennaroi Earring",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",feet=gear.ValorWSFeet})
	
    sets.precast.WS['Tachi: Rana'] = set_combine(sets.precast.WS, {body="Ken. Samue +1", hands="Ken. Tekko", legs="Ken. Hakama +1", feet=gear.ValorWSFeet})
    sets.precast.WS['Tachi: Rana'].Acc = set_combine(sets.precast.WS['Tachi: Rana'], {ear1="Digni. Earring",ear2="Telos Earring",back=gear.SmertriosTP})
    sets.precast.WS['Tachi: Rana'].HighAcc = set_combine(sets.precast.WS['Tachi: Rana'].Acc, {legs="Wakido Haidate +3", feet="Wakido Sune. +3"})
    --sets.precast.WS['Tachi: Rana'].Mod = set_combine(sets.precast.WS['Tachi: Rana'].HighAcc, {ear1="Zennaroi Earring",ear2="Moonshade Earring",waist="Fotia Belt",legs="Xaddi Cuisses"})
 
    sets.precast.WS['Tachi: Kasha'] = set_combine(sets.precast.WS, {neck="Sam. Nodowa +2",waist="Fotia Belt"})
    sets.precast.WS['Tachi: Gekko'] = set_combine(sets.precast.WS, {neck="Sam. Nodowa +2",waist="Fotia Belt"})
    sets.precast.WS['Tachi: Yukikaze'] = set_combine(sets.precast.WS, {neck="Sam. Nodowa +2",waist="Fotia Belt"})
    sets.precast.WS['Tachi: Ageha'] = set_combine(sets.precast.WS, {neck="Sam. Nodowa +2",waist="Fotia Belt"})
    sets.precast.WS['Tachi: Jinpu'] = set_combine(sets.precast.WS, {neck="Sam. Nodowa +2",waist="Fotia Belt"})
 
    -- Midcast Sets
    sets.midcast.FastRecast = {ammo="Impatiens",head="Wakido Kabuto +3",neck="Baetyl Pendant",
        body="Tartarus Platemail",hands="Sakonji Kote +3",back="Solemnity Cape",
        legs="Ryuo Hakama +1",feet="Amm Greaves"}
 
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {neck="Bathy Choker +1",ring1="Sheltered Ring",ring2="Paguroidea Ring"}
    
    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle.Town = {ammo="Staunch tathlum +1",head="Wakido Kabuto +3",neck="Bathy Choker +1",ear1="Infused Earring",ear2="Odnowa Earring +1",
        body="Hiza. Haramaki +2",hands="Sakonji Kote +3",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Shadow Mantle",waist="Flume Belt",legs="Ryuo Hakama +1",feet="Danzo Sune-ate"}
    
    sets.idle.Field = {ammo="Staunch tathlum +1",head="Wakido Kabuto +3",neck="Bathy Choker +1",ear1="Infused Earring",ear2="Odnowa Earring +1",
        body="Hiza. Haramaki +2",hands="Sakonji Kote +3",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Ryuo Hakama +1",feet="Danzo Sune-ate"}
 
    sets.idle.Weak = {ammo="Staunch tathlum +1",head="Twilight Helm",neck="Bathy Choker +1",ear1="Infused Earring",ear2="Odnowa Earring +1",
        body="Twilight Mail",hands="Sakonji Kote +3",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Shadow Mantle",waist="Flume Belt",legs="Ryuo Hakama +1",feet="Danzo Sune-ate"}
    	
	sets.idle.Fishing = {range="Ebisu Fishing Rod",
		body="Fisherman's tunica",neck="Fisher's Torque",
		hands="Fisherman's Gloves",ring1="Pelican Ring",ring2="Puffin Ring",
		legs="Fisherman's Hose",feet="Fisherman's boots"}
		
	sets.idle.Crafting = {
		body="Boneworker's Smock",head="Protective Spectacles",ring1="Craftmaster's Ring"
	}
	
    -- Defense sets
    sets.defense.PDT = {ammo="Staunch tathlum +1",
        head="Mpaca's Cap",neck="Loricate Torque +1",ear1="Odnowa Earring",ear2="Odnowa Earring +1",
        body="Wakido Domaru +3",hands="Sakonji Kote +3",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Moonbeam Cape",waist="Flume Belt",legs="Ken. Hakama +1",feet="Ken. Sune-Ate +1"}
 
    sets.defense.Reraise = {ammo="Staunch tathlum +1",
        head="Twilight Helm",neck="Loricate Torque +1",ear1="Telos Earring",ear2="Odnowa Earring +1",
        body="Twilight Mail",hands="Sakonji Kote +3",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Osmium Cuisses",feet="Danzo Sune-ate"}
 
    sets.defense.MDT = {ammo="Ginsen",
        head="Ken. Jinpachi +1",neck="Moonlight Nodowa",ear1="Telos Earring",ear2="Dedition Earring",
        body="Ken. Samue +1",hands="Wakido Kote +3",ring1="Chirich Ring +1",ring2="Niqmaddu Ring",
        back=gear.SmertriosTP,waist="Windbuffet Belt +1",legs="Ken. Hakama +1",feet="Kendatsuba Sune-Ate +1"}
 
    sets.Kiting = {feet="Danzo Sune-ate"}
 
    sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}
 
    -- Engaged sets
 
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions arent defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group 4 hit
	--Accuracy 1168
    sets.engaged = {ammo="Ginsen",
		head="Flamma Zucchetto +2",neck="Sam. Nodowa +2",ear1="Telos Earring",ear2="Dedition Earring",
		body="Tatena. Harama. +1",hands="Wakido Kote +3",ring1="Chirich Ring +1",ring2="Niqmaddu Ring",
		back=gear.SmertriosTP,waist="Sailfi Belt +1",legs="Tatena. Haidate +1",feet="Ryuo Sune-Ate +1"}
		--Accuracy 1207
    sets.engaged.Acc = set_combine(sets.engaged, {waist="Ioskeha Belt +1"})
		--Accuracy 1236
	sets.engaged.HighAcc = set_combine(sets.engaged, {head="Flam. Zucchetto +2",ear2="Cessance Earring",
		waist="Ioskeha Belt +1",feet="Tatena. Sune-Ate +1"})
		--Accuracy 1281
	sets.engaged.MaxAcc = set_combine(sets.engaged.HighAcc, {head="Ken. Jinpachi +1",ear2="Digni. Earring",ring2="Regal Ring",
		feet="Tatena. Sune-Ate +1"})
    sets.engaged.PDT = {ammo="Staunch tathlum +1",
        head="Mpaca Cap",neck="Loricate Torque +1",ear1="Odnowa Earring",ear2="Odnowa Earring +1",
        body="Wakido Domaru +3",hands="Sakonji Kote +3",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Moonbeam Cape",waist="Flume Belt",legs="Ken. Hakama +1",feet="Ken. Sune-Ate +1"}
    sets.engaged.Acc.PDT = {ammo="Staunch tathlum +1",head="Lithelimb Cap",neck="Loricate Torque +1",ear1="Tripudio Earring",
		ear2="Brutal Earring",body="Tartarus Platemail",hands="Sakonji Kote +3",ring1="Defending Ring",ring2="Patricius Ring",
        back="Shadow Mantle",waist="Flume Belt",legs="Ryuo Hakama +1",feet="Amm Greaves"}
    sets.engaged.Reraise = set_combine(sets.engaged, {head="Twilight helm",body="Twilight Mail"})
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.MaxAcc, {head="Twilight helm",body="Twilight Mail"})
        
    -- Melee sets for in Adoulin, which has an extra 10 Save TP for weaponskills, 4 hit, legs either 2DA or 2 Crit
    sets.engaged.Adoulin = {ammo="Ginsen",
		head="Flamma Zucchetto +2",neck="Sam. Nodowa +2",ear1="Cessance Earring",ear2="Telos Earring",
		body="Ken. Samue +1",hands="Wakido Kote +3",ring1="Flamma Ring",ring2="Niqmaddu Ring",
		back=gear.SmertriosTP,waist="Ioskeha Belt +1",legs="Ken. Hakama +1",feet="Ryuo Sune-Ate +1"}
    sets.engaged.Adoulin.Acc = set_combine(sets.engaged, {head="Ken. Jinpachi +1",body="Ken. Samue +1",ring1="Hetairoi Ring",
		waist="Windbuffet Belt +1",legs="Ken. Hakama +1",feet="Kendatsuba Sune-Ate +1"})
	sets.engaged.Adoulin.HighAcc = set_combine(sets.engaged, {head="Flam. Zucchetto +2",ear1="Digni. Earring",body="Ken. Samue +1",
		ring1="Flamma Ring",waist="Ioskeha Belt +1",legs="Ken. Hakama +1",feet="Flam. Gambieras +2"})
	sets.engaged.Adoulin.MaxAcc = set_combine(sets.engaged.HighAcc, {head="Wakido Kabuto +3",ring2="Regal Ring",waist="Kentarch Belt +1",
		feet="Wakido Sune. +3"})
    sets.engaged.Adoulin.PDT = {ammo="Staunch tathlum +1",head="Lithelimb Cap",neck="Loricate Torque +1",ear1="Tripudio Earring",
		ear2="Brutal Earring",body="Tartarus Platemail",hands="Sakonji Kote +3",ring1="Defending Ring",ring2="Patricius Ring",
        back="Shadow Mantle",waist="Flume Belt",legs="Ryuo Hakama +1",feet="Amm Greaves"}
    sets.engaged.Adoulin.Acc.PDT = {ammo="Staunch tathlum +1",head="Lithelimb Cap",neck="Loricate Torque +1",ear1="Tripudio Earring",
		ear2="Brutal Earring",body="Tartarus Platemail",hands="Sakonji Kote +3",ring1="Defending Ring",ring2="Patricius Ring",
        back="Shadow Mantle",waist="Flume Belt",legs="Ryuo Hakama +1",feet="Amm Greaves"}
    sets.engaged.Adoulin.Reraise = set_combine(sets.engaged.Adoulin, {head="Twilight helm",body="Twilight Mail"})
    sets.engaged.Adoulin.Acc.Reraise = set_combine(sets.engaged.Adoulin.MaxAcc, {head="Twilight helm",body="Twilight Mail"})
 
    sets.buff.Sekkanoki = {hands="Kasuga Kote +1"}
    sets.buff.Sengikori = {feet="Kasuga Sune-ate"}
    sets.buff['Meikyo Shisui'] = {feet="Sakonji Sune-ate +1"}
end
 
-- Called when this job file is unloaded (eg: job change)
function user_unload()

	
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book(SAM)
    set_macro_page(4,4)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset 40')
end 
 
-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type:lower() == 'weaponskill' then
        if state.Buff.Sekkanoki then
            equip(sets.buff.Sekkanoki)
        end
        if state.Buff.Sengikori then
            equip(sets.buff.Sengikori)
        end
        if state.Buff['Meikyo Shisui'] then
            equip(sets.buff['Meikyo Shisui'])
        end
    end
	
	custom_aftermath_timers_precast(spell)
end
 
 
-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Effectively lock these items in place.
    if state.HybridMode.value == 'Reraise' or
        (state.DefenseMode.value == 'Physical' and state.PhysicalDefenseMode.value == 'Reraise') then
        equip(sets.Reraise)
    end
	
	custom_aftermath_timers_aftercast(spell)
end