-- Setup vars that are user-dependent. Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal','MidAcc','FullAcc','Hybrid')
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('PDT', 'MDT')
    state.IdleMode:options('Normal')
     
	gear.default.obi_waist = "Eschan stone"
	 
    -- Additional local binds
    
    select_default_macro_book(1, 3)
end
     
function init_gear_sets()

    --------------------------------------
    -- Start defining the sets
    --------------------------------------
	
	include('Gipi_augmented-items.lua')
	
    sets.TreasureHunter = {hands="Plunderer's Armlets +1", waist="Chaac belt", feet="Skulker's poulaines +1"}
	
	sets.enmity = {ammo="Sapience Orb",
		head=gear.HercHeadDT,neck="Unmoving collar +1",ear1="Cryptic earring",ear2="Trux earring",
		body="Emet Harness +1",hands="Kurys gloves",ring1="Supershear ring",ring2="Eihwaz ring",
		back="Agema cape",waist="Kasiri belt",legs="Ayanmo cosciales +1",feet="Ahosi leggings"}
	
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA['Collaborator'] = {head="Skulker's bonnet"}
    sets.precast.JA['Accomplice'] = {head="Skulker's bonnet"}
    sets.precast.JA['Flee'] = {feet="Pillager's Poulaines +1"}
    sets.precast.JA['Hide'] = {body="Pillager's Vest +2"}
    sets.precast.JA['Conspirator'] = {body="Skulker's vest"}
    sets.precast.JA['Steal'] = {head="Assassin's Bonnet +2",hands="Pillager's armlets +1",feet="Pillager's Poulaines +1"}
    sets.precast.JA['Despoil'] = {legs="Raider's Culottes +2",feet="Raider's Poulaines +2"}
    sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +1"}
    sets.precast.JA['Feint'] = {legs="Plunderer's culottes"}
    sets.precast.JA["Assassin's Charge"] = {feet="Plun. Poulaines +1"}
    sets.precast.JA['Sneak Attack'] = {}
    sets.precast.JA['Trick Attack'] = {}
	sets.precast.JA['Provoke'] = sets.enmity
     
     
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {		
		head="Anwig Salade",
        body="Passion Jacket",
        neck="Phalaina Locket",
        ring1="Asklepian Ring",
        waist="Gishdubar Sash",
		legs="Dashing Subligar"
		}
	
    -- Dont need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {head="Anwig salade"}
	
    -- Fast cast sets for spells
    sets.precast.FC = {ammo="Impatiens",
		head=gear.HercHeadFC,neck="Orunmila's torque",ear1="Enchanter earring +1",ear2="Loquacious Earring",
		body="Adhemar Jacket",hands="Leyline gloves",ring1="Defending ring",ring2="Lebeche ring",
		back="Swith cape",waist="Kasiri belt",legs="Enif cosciales",feet=gear.HercFeetFC}
     
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {body="Passion jacket",neck="Magoraga Beads"})
     
    -- Ranged snapshot gear
    sets.precast.RangedAttack = {
		head="Aurore beret +1",
		ring1="Haverton ring",
		legs="Nahtirah trousers",feet="Meghanada jambeaux +2"}
	
    -- Weaponskill sets
	
    -- Default set for any weaponskill that isnt any more specifically defined	
    sets.precast.WS = {ammo="Falcon eye",
		head="Pillager's bonnet +3",neck="Caro necklace",ear1="Moonshade earring",ear2="Sherida earring",
        body="Adhemar Jacket +1",hands="Meghanada gloves +2",ring1="Regal ring",ring2="Ilabrat ring",
        back=gear.ToutCapeWS,waist="Grunfeld rope",legs="Lustratio subligar +1",feet="Lustratio leggings +1"}
		
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
     
    -- Specific weaponskill sets. Uses the base set if an appropriate WSMod version isnt found.
    sets.precast.WS['Evisceration'] = {ammo="Yetshila",
		head="Adhemar Bonnet +1",neck="Caro necklace",ear1="Moonshade earring",ear2="Sherida earring",
        body="Meghanada cuirie +2",hands="Adhemar Wristbands +1",ring1="Begrudging ring",ring2="Ilabrat ring",
        back=gear.ToutCapeCRIT,waist="Grunfeld rope",legs="Lustratio subligar +1",feet="Lustratio leggings +1"}
		
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {ammo="Falcon eye"})
    sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'].Mod, {ammo="Yetshila"})
    sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'].Mod, {ammo="Yetshila"})
    sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'].Mod, {ammo="Yetshila"})
     
	 
	sets.precast.WS['Exenterator'] = {ammo="Yamarang",
		head="Adhemar Bonnet +1",neck="Fotia gorget",ear1="Telos earring",ear2="Sherida earring",
        body="Adhemar Jacket +1",hands="Adhemar Wristbands +1",ring1="Regal ring",ring2="Ilabrat ring",
        back=gear.ToutCapeWS,waist="Fotia belt",legs="Meghanada chausses +2",feet="Meghanada jambeaux +2"}
		
    sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {ammo="Falcon eye"})
    sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'].Mod, {ammo="Falcon eye"})
    sets.precast.WS['Exenterator'].TA = set_combine(sets.precast.WS['Exenterator'].Mod, {ammo="Falcon eye"})
    sets.precast.WS['Exenterator'].SATA = set_combine(sets.precast.WS['Exenterator'].Mod, {ammo="Falcon eye"})
	
	 
    sets.precast.WS["Rudra's Storm"] = {ammo="Falcon eye",
		head="Pillager's bonnet +3",neck="Caro necklace",ear1="Moonshade earring",ear2="Sherida earring",
        body="Meghanada cuirie +2",hands="Meghanada gloves +2",ring1="Regal ring",ring2="Ilabrat Ring",
        back=gear.ToutCapeWS,waist="Grunfeld rope",legs="Lustratio subligar +1",feet="Lustratio leggings +1"}
		
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {})
    sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"], {ammo="Yetshila"})
    sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"], {ammo="Yetshila"})
    sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"], {ammo="Yetshila"})
	
	
	sets.precast.WS["Mandalic Stab"] = sets.precast.WS["Rudra's Storm"]
		
    sets.precast.WS["Mandalic Stab"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {})
    sets.precast.WS["Mandalic Stab"].SA = set_combine(sets.precast.WS["Rudra's Storm"], {ammo="Yetshila"})
    sets.precast.WS["Mandalic Stab"].TA = set_combine(sets.precast.WS["Rudra's Storm"], {ammo="Yetshila"})
    sets.precast.WS["Mandalic Stab"].SATA = set_combine(sets.precast.WS["Rudra's Storm"], {ammo="Yetshila"})
	
	
    sets.precast.WS['Mercy Stroke'] = {
		head="Pillager's bonnet +3",neck="Caro necklace",ear1="Moonshade earring",ear2="Sherida earring",
        body="Meghanada cuirie +2",hands="Meghanada gloves +2",ring1="Regal ring",ring2="Ilabrat Ring",
        back=gear.ToutCapeWS,waist="Grunfeld rope",legs="Lustratio subligar +1",feet="Lustratio leggings +1"}
		
    sets.precast.WS['Mercy Stroke'].Acc = set_combine(sets.precast.WS['Mercy Stroke'], {})
    sets.precast.WS['Mercy Stroke'].SA = set_combine(sets.precast.WS['Mercy Stroke'].Mod, {ammo="Yetshila"})
    sets.precast.WS['Mercy Stroke'].TA = set_combine(sets.precast.WS['Mercy Stroke'].Mod, {ammo="Yetshila"})
    sets.precast.WS['Mercy Stroke'].SATA = set_combine(sets.precast.WS['Mercy Stroke'].Mod, {ammo="Yetshila"})
    
	
	sets.precast.WS['Aeolian Edge'] = {ammo="Pemphredo tathlum",
		head=gear.HercHeadMagic,neck="Baetyl pendant",ear1="Moonshade earring",ear2="Friomisi earring",
		body="Samnuha coat",hands="Leyline gloves",ring1="Shiva ring +1",ring2="Dingir ring",
		back=gear.ToutCapeWS,waist=gear.ElementalObi,legs=gear.HercLegsMagic,feet=gear.HercFeetMagic}
		
    -- Midcast Sets
    sets.midcast.FastRecast = {ammo="Staunch tathlum",
		head=gear.HercHeadDT,neck="Orunmila's torque",ear1="Enchanter earring +1",ear2="Loquacious Earring",
        body="Adhemar Jacket",hands=gear.HercHandsDT,ring1="Defending ring",ring2="Dark ring",
        back="Moonbeam cape",waist="Flume Belt +1",legs="Mummu kecks +2",feet=gear.HercFeetDT}
		
    -- Specific spells
    sets.midcast.Utsusemi = {ammo="Staunch tathlum",
		head=gear.HercHeadDT,neck="Orunmila's torque",ear1="Enchanter earring +1",ear2="Loquacious Earring",
        body="Adhemar Jacket",hands=gear.HercHandsDT,ring1="Defending ring",ring2="Dark ring",
        back="Moonbeam cape",waist="Flume Belt +1",legs="Mummu kecks +2",feet=gear.HercFeetDT}
     
    -- Ranged gear -- acc + TH
    sets.midcast.RangedAttack = {
		head="Meghanada visor +2",neck="Iskur gorget",ear1="Telos Earring",ear2="Enervating earring",
        body="Meghanada cuirie +2",hands="Meghanada gloves +2",ring1="Haverton ring",ring2="Cacoethic ring +1",
        waist="Eschan stone",legs="Meghanada chausses +2",feet="Meghanada jambeaux +2"}
     
    sets.midcast.RangedAttack.Acc = {
		head="Meghanada visor +2",neck="Iskur gorget",ear1="Telos Earring",ear2="Enervating earring",
        body="Meghanada cuirie +2",hands="Meghanada gloves +2",ring1="Haverton ring",ring2="Cacoethic ring +1",
        waist="Eschan stone",legs="Meghanada chausses +2",feet="Meghanada jambeaux +2"}
		
    sets.midcast.RangedAttack.TH = {
		head="Meghanada visor +2",neck="Iskur gorget",ear1="Telos Earring",ear2="Enervating earring",
        body="Meghanada cuirie +2",hands="Plunderer armlets +1",ring1="Haverton ring",ring2="Cacoethic ring +1",
		waist="Eschan stone",legs="Meghanada chausses +2",feet="Shulker's poulaines +1"}
		
    -- Sets to return to when not performing an action.
	
    -- Resting sets
    sets.resting = {}
     
    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
     
    sets.idle = {ammo="Staunch tathlum",
		head="Meghanada visor +2",neck="Bathy choker +1",ear1="Infused earring",ear2="Ethereal earring",
        body="Meghanada cuirie +2",hands="Meghanada gloves +2",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Moonbeam cape",waist="Flume Belt +1",legs="Meghanada chausses +2",feet="Jute boots +1"}
		
    sets.idle.Town = {ammo="Staunch tathlum",
		head="Meghanada visor +2",neck="Bathy choker +1",ear1="Infused earring",ear2="Ethereal earring",
        body="Meghanada cuirie +2",hands="Meghanada gloves +2",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Moonbeam cape",waist="Flume Belt +1",legs="Meghanada chausses +2",feet="Jute boots +1"}
	
    -- Defense sets
    sets.defense.PDT = {ammo="Staunch tathlum",
        head="Meghanada visor +2",neck="Loricate torque +1",ear1="Odnowa earring +1",ear2="Eabani earring",
        body="Ashera harness",hands=gear.HercHandsDT,ring1="Defending ring",ring2="Moonbeam ring",
        back="Moonbeam cape",waist="Flume Belt +1",legs="Mummu kecks +2",feet="Ahosi leggings"}

    sets.defense.MDT = {ammo="Staunch tathlum",
        head="Pillager's bonnet +3",neck="Loricate torque +1",ear1="Odnowa earring +1",ear2="Eabani earring",
        body="Ashera harness",hands=gear.HercHandsDT,ring1="Defending ring",ring2="Moonbeam ring",
        back="Moonbeam cape",waist="Engraved belt",legs="Mummu kecks +2",feet="Ahosi leggings"}
		
    sets.Kiting = {feet="Jute boots +1"}
     
    -- Engaged sets
     
    -- Variations for TP weapon and (optional) offense/defense modes. Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    -- Normal melee group
	
    sets.engaged = {ammo="Yamarang",
        head="Adhemar Bonnet +1",neck="Anu torque",ear1="Telos Earring",ear2="Sherida earring",
        body="Adhemar Jacket +1",hands="Adhemar Wristbands +1",ring1="Petrov Ring",ring2="Epona's Ring",
        back=gear.ToutCapeTP,waist="Windbuffet belt +1",legs="Samnuha tights",feet=gear.HercFeetTP}
	
	sets.engaged.MidAcc = {ammo="Yamarang",
        head="Adhemar Bonnet +1",neck="Combatant's torque",ear1="Telos Earring",ear2="Sherida earring",
        body="Adhemar Jacket +1",hands="Adhemar Wristbands +1",ring1="Regal Ring",ring2="Epona's Ring",
        back=gear.ToutCapeTP,waist="Grunfeld rope",legs="Pillager's culottes +3",feet=gear.HercFeetTP}
	
    sets.engaged.FullAcc = {ammo="Yamarang",
        head="Pillager's bonnet +3",neck="Combatant's torque",ear1="Telos Earring",ear2="Dignitary's earring",
        body="Pillager's vest +3",hands="Adhemar Wristbands +1",ring1="Regal ring",ring2="Cacoethic ring +1",
        back=gear.ToutCapeTP,waist="Olseni belt",legs="Pillager's culottes +3",feet=gear.HercFeetTP}
		
	sets.engaged.Hybrid = {ammo="Staunch tathlum",
        head="Meghanada visor +2",neck="Loricate torque +1",ear1="Telos earring",ear2="Sherida earring",
        body="Ashera harness",hands=gear.HercHandsACC,ring1="Defending ring",ring2="Moonbeam ring",
        back="Moonbeam cape",waist="Sailfi belt +1",legs="Meghanada chausses +2",feet=gear.HercFeetTP}
    	 
    end
     
    -- Called when this job file is unloaded (eg: job change)
    function user_unload()
    
    end