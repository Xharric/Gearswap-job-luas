-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
--[[ Updated 9/18/2014, functions with Mote's new includes.
-- Have not played WAR recently, please PM me with any errors 
			BG: Fival
			FFXIAH: Asura.Fiv
]]--
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

	-- Load and initialize the include file.
	include('Mote-Include.lua')
	include('organizer-lib')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
			state.Buff['Aftermath'] = buffactive['Aftermath: Lv.1'] or
            buffactive['Aftermath: Lv.2'] or
            buffactive['Aftermath: Lv.3'] or false
			state.Buff['Mighty Strikes'] = buffactive['Mighty Strikes'] or false
end


-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal', 'AccLow', 'AccHigh')
	state.RangedMode:options('Normal')
	state.HybridMode:options('Normal', 'PDT')
	state.WeaponskillMode:options('Normal', 'AccLow', 'AccHigh', 'Attack')
	state.CastingMode:options('Normal')
	state.IdleMode:options('Normal', 'HP')
	state.RestingMode:options('Normal')
	state.PhysicalDefenseMode:options('PDT', 'Reraise')
	state.MagicalDefenseMode:options('MDT')
	
	--Augmented Gear Definitions--
	gear.ValorHeadTP = { name="Valorous Mask", augments={'Accuracy+22 Attack+22','Crit. hit damage +5%'}}
	gear.ValorHeadAcc = { name="Valorous Mask", augments={'Accuracy+24 Attack+24','"Store TP"+3','Accuracy+8','Attack+13'}}
	
	gear.OdysseanHandsSTR = { name="Odyssean Gauntlets", augments={'Accuracy+16 Attack+16','STR+15','Attack+15'}}
	gear.OdysseanHandsVIT = { name="Odyssean Gauntlets", augments={'Accuracy+21 Attack+21','"Dbl.Atk."+2','VIT+13','Accuracy+15',}}
	gear.ValorHandsTP = { name="Valorous Mitts", augments={'Accuracy+12 Attack+12','"Store TP"+5','Accuracy+10'}}
	gear.ValorHandsAcc = { name="Valorous Mitts", augments={'Accuracy+25 Attack+25','Crit.hit rate+4','DEX+8','Accuracy+7','Attack+9'}}
	
	gear.OdysseanFeetSTR = { name="Odyssean Greaves", augments={'Accuracy+15 Attack+15','STR+14','Accuracy+15'}}
	gear.OdysseanFeetVIT = { name="Odyssean Greaves", augments={'Accuracy+18 Attack+18','VIT+11','Accuracy+15','Attack+6'}}
	gear.ValorFeetTP = { name="Valorous Greaves", augments={'Accuracy+13 Attack+13','"Store TP"+5','Accuracy+11','Attack+15'}}
	gear.ValorFeetAcc = { name="Valorous Greaves", augments={'Accuracy+25 Attack+25','Crit. hit damage +1%','VIT+7','Accuracy+14','Attack+2'}}
	
	gear.OdysseanLegsTP = { name="Odyssean Cuisses", augments={'Accuracy+25','"Store TP"+6','STR+8','Attack+11'}}
	gear.OdysseanLegsAcc = { name="Odyssean Cuisses", augments={'Accuracy+25 Attack+25','"Dbl.Atk."+2','STR+7','Accuracy+15','Attack+1'}}
	gear.OdysseanLegsVIT = { name="Odyssean Cuisses", augments={'Accuracy+30','Weapon skill damage +4%','VIT+10','Attack+8'}}
	
	gear.STRcape = { name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10'}}
	gear.DEXcape = { name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10'}}
	
	update_combat_weapon()
	update_melee_groups()
	select_default_macro_book(WAR)
	
	-- Additional Binds
	--send_command('alias g510_m1g13 input /ws "Ukko\'s Fury" <t>;')
	--send_command('alias g510_m1g14 input /ws "King\'s Justice" <t>;')
	--send_command('alias g510_m1g15 input /ws "Upheaval" <t>;')
end

function init_gear_sets()
	
	--------------------------------------
	-- Precast sets
	--------------------------------------
	
	-- Sets to apply to arbitrary JAs
	sets.precast.JA['Berserk'] = {feet="Agoge Calligae +1", body="Pumm. Lorica +3", back="Cichol's Mantle"}
    sets.precast.JA['Aggressor'] = {body="Agoge Lorica +1", head="Pummeler's Mask +2"}
    sets.precast.JA['Mighty Strikes'] = {hands="Agoge Mufflers"}
	sets.precast.JA['Tomahawk'] = {ammo="Thr. Tomahawk",feet="Agoge Calligae +1"}
	sets.precast.JA['Provoke'] = {ammo="Iron Gobbet",
	   head="Pummeler's Mask +2",neck="Unmoving Collar",ear1="Friomisi Earring",ear2="Trux Earring",
	   body="Arke Corazza",hands="Yorium Gauntlets",ring1="Petrov Ring",ring2="Supershear Ring",
	   waist="Goading Belt",feet="Hermes' Sandals"}
	sets.precast.JA['Blood Rage'] = set_combine(sets.precast.JA['Provoke'], {body="Boii Lorica +1"})
	sets.precast.JA['Warcry'] = set_combine(sets.precast.JA['Provoke'], {head="Agoge Mask +1"})   
	   
	-- Sets to apply to any actions of spell.type
	sets.precast.Waltz = {}
		
	-- Sets for specific actions within spell.type
	sets.precast.Waltz['Healing Waltz'] = {}

    -- Sets for fast cast gear for spells
	sets.precast.FC = {ammo="Impatiens",
	head="Quiahuiz Helm",neck="Voltsurge Torque",ear1="Etiolation Earring",ear2="Loquacious Earring",
	body="Odyssean Chestplate",hands="Leyline Gloves",ring1="Lebeche Ring",
	waist="Sanctuary Obi",legs="Eschite Cuisses",feet=gear.OdysseanFeetVIT}

    -- Fast cast gear for specific spells or spell maps
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

	
	-- Weaponskill sets
	sets.precast.WS = {ammo="Seeth. Bomblet +1",
	    head="Argosy Celata +1",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Argosy Hauberk",hands="Argosy Mufflers +1",ring1="Rufescent Ring",ring2="Ifrit Ring +1",
		back=gear.STRcape,waist="Fotia Belt",legs="Argosy Breeches +1",feet="Argosy Sollerets +1"}
	sets.precast.WS.AccLow = set_combine(sets.precast.WS, {ammo="Seeth. Bomblet +1"})
	sets.precast.WS.AccHigh = set_combine(sets.precast.WS.AccLow)
	sets.precast.WS.Attack = set_combine(sets.precast.WS)
	sets.precast.WS.MS = set_combine(sets.precast.WS, {ammo="Yetshila",feet="Boii Calligae +1"})
	
	-- Specific weaponskill sets.
	
	--GAXE
	sets.precast.WS['Upheaval'] = {ammo="Knobkierrie",
	    head="Odyssean Helm",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Pumm. Lorica +3",hands=gear.OdysseanHandsVIT,ring1="Supershear Ring",ring2="Titan Ring +1",
		back=gear.STRcape,waist="Fotia Belt",legs=gear.OdysseanLegsVIT,feet="Pumm. Calligae +3"}
	sets.precast.WS['Upheaval'].AccLow = set_combine(sets.precast.WS['Upheaval'])
	sets.precast.WS['Upheaval'].AccHigh = set_combine(sets.precast.WS['Upheaval'].AccLow)
	sets.precast.WS['Upheaval'].Attack = set_combine(sets.precast.WS['Upheaval'])
	sets.precast.WS['Upheaval'].MS = set_combine(sets.precast.WS['Upheaval'], {ammo="Yetshila",feet="Boii Calligae +1"})
	
	sets.precast.WS['Ukko\'s Fury'] = {ammo="Yetshila",
	    head="Argosy Celata +1",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Argosy Hauberk",hands="Argosy Mufflers +1",ring1="Begrudging Ring",ring2="Ifrit Ring +1",
		back=gear.STRcape,waist="Fotia Belt",legs="Argosy Breeches +1",feet="Argosy Sollerets +1"}
	sets.precast.WS['Ukko\'s Fury'].AccLow = set_combine(sets.precast.WS['Ukko\'s Fury'], {ammo="Seeth. Bomblet +1"})
	sets.precast.WS['Ukko\'s Fury'].AccHigh = set_combine(sets.precast.WS['Ukko\'s Fury'].AccLow, {})
	sets.precast.WS['Ukko\'s Fury'].Attack = set_combine(sets.precast.WS['Ukko\'s Fury'])
	sets.precast.WS['Ukko\'s Fury'].MS = set_combine(sets.precast.WS['Ukko\'s Fury'], {ammo="Yetshila",feet="Boii Calligae +1"})
	
	sets.precast.WS['Steel Cyclone'] = set_combine(sets.precast.WS, {ammo="Seeth. Bomblet +1",
	    head="Argosy Celata +1",neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",
		body="Pumm. Lorica +3",hands="Argosy Mufflers +1",ring1="Shukuyu Ring",ring2="Ifrit Ring +1",
		back=gear.STRcape,waist="Grunfeld Rope",legs="Argosy Breeches +1",feet="Sulevia's Leggings +1"})
	sets.precast.WS['Steel Cyclone'].AccLow = set_combine(sets.precast.WS['Steel Cyclone'], {
	    legs="Argosy Breeches +1"})
	sets.precast.WS['Steel Cyclone'].AccHigh = set_combine(sets.precast.WS['Steel Cyclone'].AccLow)
	sets.precast.WS['Steel Cyclone'].Attack = set_combine(sets.precast.WS['Steel Cyclone'])
	sets.precast.WS['Steel Cyclone'].MS = set_combine(sets.precast.WS['Steel Cyclone'], {ammo="Yetshila",feet="Boii Calligae +1"})
	
	--sets.precast.WS['King\'s Justice'] = set_combine(sets.precast.WS, {})
	--sets.precast.WS['King\'s Justice'].AccLow = set_combine(sets.precast.WS['King\'s Justice'], {})
	--sets.precast.WS['King\'s Justice'].AccHigh = set_combine(sets.precast.WS['King\'s Justice'].AccLow, {})
	--sets.precast.WS['King\'s Justice'].Attack = set_combine(sets.precast.WS['King\'s Justice'], {})
	--sets.precast.WS['King\'s Justice'].MS = set_combine(sets.precast.WS['King\'s Justice'], {ammo="Yetshila +1",back="Cavaros Mantle",feet="Huginn Gambieras"})
	
	--sets.precast.WS['Metatron Torment'] = set_combine(sets.precast.WS, {})
	--sets.precast.WS['Metatron Torment'].AccLow = set_combine(sets.precast.WS['Metatron Torment'], {})
	--sets.precast.WS['Metatron Torment'].AccHigh = set_combine(sets.precast.WS['Metatron Torment'].AccLow, {})
	--sets.precast.WS['Metatron Torment'].Attack = set_combine(sets.precast.WS['Metatron Torment'], {})
	--sets.precast.WS['Metatron Torment'].MS = set_combine(sets.precast.WS['Metatron Torment'], {ammo="Yetshila +1",back="Cavaros Mantle",feet="Huginn Gambieras"})
	
	
	--GSWD
	sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {ammo="Seeth. Bomblet +1",
	    head="Argosy Celata +1",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Cessance Earring",
		body="Argosy Hauberk",hands="Argosy Mufflers +1",ring1="Shukuyu Ring",ring2="Ifrit Ring +1",
		back=gear.STRcape,waist="Fotia Belt",legs="Argosy Breeches +1",feet="Argosy Sollerets +1"})
	sets.precast.WS['Resolution'].AccLow = set_combine(sets.precast.WS['Resolution'], {
	    legs="Argosy Breeches +1"})
	sets.precast.WS['Resolution'].AccHigh = set_combine(sets.precast.WS['Resolution'].AccLow)
	sets.precast.WS['Resolution'].Attack = set_combine(sets.precast.WS['Resolution'])
	sets.precast.WS['Resolution'].MS = set_combine(sets.precast.WS['Resolution'], {ammo="Yetshila",feet="Boii Calligae +1"})
	
	sets.precast.WS['Scourge'] = set_combine(sets.precast.WS, {ammo="Seeth. Bomblet +1",
	    head="Argosy Celata +1",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Ishvara Earring",
		body="Pumm. Lorica +3",hands="Argosy Mufflers +1",ring1="Shukuyu Ring",ring2="Ifrit Ring +1",
		back=gear.STRcape,waist="Fotia Belt",legs=gear.OdysseanLegsVIT,feet="Argosy Sollerets +1"})
	sets.precast.WS['Scourge'].AccLow = set_combine(sets.precast.WS['Scourge'], {
	    legs="Argosy Breeches +1"})
	sets.precast.WS['Scourge'].AccHigh = set_combine(sets.precast.WS['Scourge'].AccLow)
	sets.precast.WS['Scourge'].Attack = set_combine(sets.precast.WS['Scourge'])
	sets.precast.WS['Scourge'].MS = set_combine(sets.precast.WS['Scourge'], {ammo="Yetshila",feet="Boii Calligae +1"})
	
	
	--SWD
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {ammo="Seeth. Bomblet +1",
	    head="Argosy Celata +1",neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",
		body="Pumm. Lorica +3",hands="Argosy Mufflers +1",ring1="Rufescent Ring",ring2="Ifrit Ring +1",
		back="Cichol's Mantle",waist="Grunfeld Rope",legs="Boii Cuisses +1",feet="Sulevia's Leggings +1"})
	sets.precast.WS['Savage Blade'].AccLow = set_combine(sets.precast.WS['Savage Blade'])
	sets.precast.WS['Savage Blade'].AccHigh = set_combine(sets.precast.WS['Savage Blade'].AccLow)
	sets.precast.WS['Savage Blade'].Attack = set_combine(sets.precast.WS['Savage Blade'])
	sets.precast.WS['Savage Blade'].MS = set_combine(sets.precast.WS['Savage Blade'], {ammo="Yetshila",feet="Boii Calligae +1"})
	
	sets.precast.WS['Sanguine Blade'] = {ammo="Seeth. Bomblet +1",
	    head="Jumalik Helm",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Moonshade Earring",
	    body="Founder's Breastplate",hands="Founder's Gauntlets",ring1="Archon Ring",ring2="Shiva Ring +1", 
	    back="Argochampsa Mantle",waist="Eschan Stone",legs="Eschite Cuisses",feet="Founder's Greaves"}
	
	sets.precast.WS['Vorpal Blade'] ={ammo="Seeth. Bomblet +1",
	    head="Argosy Celata +1",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Argosy Hauberk",hands="Argosy Mufflers +1",ring1="Rufescent Ring",ring2="Ifrit Ring +1",
		back="Cichol's Mantle",waist="Fotia Belt",legs="Argosy Breeches +1",feet="Argosy Sollerets +1"}
		
		
	--AXE
	sets.precast.WS['Cloudsplitter'] = {ammo="Seeth. Bomblet +1",
	    head="Jumalik Helm",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Moonshade Earring",
	    body="Founder's Breastplate",hands="Founder's Gauntlets",ring1="Fenrir Ring +1",ring2="Shiva Ring +1", 
	    back="Argochampsa Mantle",waist="Eschan Stone",legs="Eschite Cuisses",feet="Founder's Greaves"}
	
	sets.precast.WS['Mistral Axe'] = set_combine(sets.precast.WS, {ammo="Seeth. Bomblet +1",
	    head="Argosy Celata +1",neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",
		body="Argosy Hauberk",hands="Argosy Mufflers +1",ring1="Rufescent Ring",ring2="Ifrit Ring +1",
		back="Cichol's Mantle",waist="Fotia Belt",legs="Boii Cuisses +1",feet="Sulevia's Leggings +1" })
	
	sets.precast.WS['Rampage'] = {ammo="Seeth. Bomblet +1",
	    head="Argosy Celata +1",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Argosy Hauberk",hands="Argosy Mufflers +1",ring1="Rufescent Ring",ring2="Ifrit Ring +1",
		back="Cichol's Mantle",waist="Fotia Belt",legs="Argosy Breeches +1",feet="Argosy Sollerets +1"}
		
		
	--CLUB
	sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {ammo="Seeth. Bomblet +1",
	    head="Argosy Celata +1",neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",
		body="Argosy Hauberk",hands="Argosy Mufflers +1",ring1="Rufescent Ring",ring2="Ifrit Ring +1",
		back="Cichol's Mantle",waist="Fotia Belt",legs="Boii Cuisses +1",feet="Sulevia's Leggings +1"})
	
	sets.precast.WS['Judgment'] = set_combine(sets.precast.WS, {ammo="Seeth. Bomblet +1",
	    head="Argosy Celata +1",neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",
		body="Argosy Hauberk",hands="Argosy Mufflers +1",ring1="Rufescent Ring",ring2="Ifrit Ring +1",
		back="Cichol's Mantle",waist="Grunfeld Rope",legs="Boii Cuisses +1",feet="Sulevia's Leggings +1"})
	
	sets.precast.WS['Flash Nova'] = {ammo="Seeth. Bomblet +1",
	    head="Jumalik Helm",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Moonshade Earring",
	    body="Founder's Breastplate",hands="Founder's Gauntlets",ring1="Fenrir Ring +1",ring2="Shiva Ring +1", 
	    back="Argochampsa Mantle",waist="Eschan Stone",legs="Eschite Cuisses",feet="Founder's Greaves"}
	
	--STAFF
    sets.precast.WS['Cataclysm'] = {ammo="Seeth. Bomblet +1",
	    head="Jumalik Helm",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Moonshade Earring",
	    body="Founder's Breastplate",hands="Founder's Gauntlets",ring1="Archon Ring",ring2="Shiva Ring +1", 
	    back="Argochampsa Mantle",waist="Eschan Stone",legs="Eschite Cuisses",feet="Founder's Greaves"}	
	
	--DAGGER
		sets.precast.WS['Evisceration'] = {ammo="Seeth. Bomblet +1",
	    head="Argosy Celata +1",neck="Fotia Gorget",ear1="Dignitary's Earring",ear2="Moonshade Earring",
		body="Argosy Hauberk",hands=gear.ValorHandsAcc,ring1="Apate Ring",ring2="Rajas Ring",
		back="Cichol's Mantle",waist="Fotia Belt",legs="Argosy Breeches +1",feet="Argosy Sollerets +1"}
		
		sets.precast.WS['Aeolian Edge'] = {ammo="Seeth. Bomblet +1",
	    head="Jumalik Helm",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Moonshade Earring",
	    body="Founder's Breastplate",hands="Founder's Gauntlets",ring1="Fenrir Ring +1",ring2="Shiva Ring +1", 
	    back="Argochampsa Mantle",waist="Eschan Stone",legs="Eschite Cuisses",feet="Founder's Greaves"}
		
	--To ensure Organizer grabs some otherwise undefined gear.--
	sets.precast.WS['Drakesbane'] = {main="Ragnarok",sub="Utu Grip",ear1="Lugra Earring +1",ring1="Warp Ring",ring2="Capacity Ring"}
	sets.precast.WS['Drakesbane'].Acc = {main="Tanmogayi +1",sub="Blurred Shield",ring1="Warp Ring",ring2="Capacity Ring"}
	
	
	--------------------------------------
	-- Midcast sets
	--------------------------------------

    -- Generic spell recast set
	sets.midcast.FastRecast = {}
		
	-- Specific spells
	sets.midcast.Utsusemi = {ammo="Impatiens",
	    head="Souveran Schaller",neck="Voltsurge Torque",ear1="Halasz Earring",ear2="Loquacious Earring",
	    body="Odyssean Chestplate", hands="Yorium Gauntlets", ring1="Evanescence Ring", ring2= "Haverton Ring",
	    back="Grounded Mantle +1",waist="Sanctuary Obi",legs="Founder's Hose",feet=gear.OdysseanFeetVIT}

	
	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------
	
	-- Resting sets
	sets.resting = {}
	

	-- Idle sets
	sets.idle = {ammo="staunch tathlum",
						head="Valorous Mask",neck="Bathy Choker +1",ear1="Etiolation Earring",ear2="Genmei Earring",
                        body="Obviation Cuirass +1",hands="Yorium Gauntlets",ring1="Sheltered Ring",ring2="Paguroidea Ring",
                        back="Moonbeam Cape",waist="Flume Belt",legs="Valorous Hose",feet="Hermes' Sandals"}
   
	sets.idle.Town = set_combine(sets.idle, {body="Councilor's Garb",back="Solemnity Cape",ring2="Trizek Ring"})
	
	sets.idle.HP = {
    ammo="Seeth. Bomblet +1",
    head="Souveran Schaller",
    body="Arke Corazza",
    hands="Souv. Handschuhs",
    legs="Flamma Dirs +1",
    feet={ name="Amm Greaves", augments={'HP+45','VIT+10','Accuracy+14','Damage taken-1%',}},
    neck="Bathy Choker +1",
    waist="Carrier's Sash",
    left_ear="Cryptic Earring",
    right_ear="Odnowa Earring",
    left_ring="Defending Ring",
    right_ring="Supershear Ring",
    back="Moonbeam Cape",
}
	
	sets.idle.Weak = set_combine(sets.idle, {head="Twilight Helm",body="Twilight Mail"})
	
	-- Defense sets
	sets.defense.PDT = {
    ammo="Seeth. Bomblet +1",
    head="Pummeler's Mask +2",
    body="Arke Corazza",
    hands="Pumm. Mufflers +2",
    legs="Pumm. Cuisses +3",
    feet="Pumm. Calligae +3",
    neck="Loricate Torque +1",
    waist="Ioskeha Belt",
    left_ear="Digni. Earring",
    right_ear="Telos Earring",
    left_ring="Defending Ring",
    right_ring="Patricius Ring",
    back="Moonbeam Cape",}
	
	sets.defense.Reraise = set_combine(sets.defense.PDT, {head="Twilight Helm",body="Twilight Mail"})
	
	sets.defense.MDT = {ammo="Staunch Tathlum",
						head="Skormoth Mask",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
                        body="Souveran Cuirass",hands="Leyline Gloves",ring1="Defending Ring",ring2="Shadow Ring",
                        back="Engulfer Cape +1",waist="Ioskeha Belt",legs="Pumm. Cuisses +3",feet="Pumm. Calligae +3"}

    -- Gear to wear for kiting
	sets.Kiting = {feet="Hermes' Sandals"}

	--------------------------------------
	-- Engaged sets
	--------------------------------------

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	-- If using a weapon that isn't specified later, the basic engaged sets should automatically be used.
	-- Equip the weapon you want to use and engage, disengage, or force update with f12, the correct gear will be used; default weapon is whats equip when file loads.
	sets.engaged = {ammo="Ginsen",
		head="Skormoth Mask",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
	    body="Boii Lorica +1",hands="Acro Gauntlets",ring1="Petrov Ring",ring2="Rajas Ring",
		back="Cichol's Mantle",waist="Windbuffet Belt +1",legs=gear.OdysseanLegsTP,feet="Pumm. Calligae +3"}
	sets.engaged.AccLow = set_combine(sets.engaged, { 
	    head="Valorous Mask", neck="Lissome Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
	    waist="Dynamic Belt +1"})
	sets.engaged.AccHigh = set_combine(sets.engaged.AccLow, {ammo="Seeth. Bomblet +1",
	    head="Valorous Mask", neck="Subtlety Spectacles", ear1="Dignitary's Earring", ear2="Cessance Earring",
		body="Emicho Haubert", hands="Valorous Mitts", ring1="Cacoethic Ring",
		back=gear.STRcape, waist="Ioskeha Belt"})
	sets.engaged.PDT = set_combine(sets.engaged, { ammo="Staunch Tathlum",
		head="Pummeler's Mask +2",neck="Agitator's Collar", ear1="Telos Earring",
	    body="Arke Corazza",hands="Pumm. Mufflers +2",ring1="Defending Ring",ring2="Patricius Ring",
	    back=gear.DEXcape,legs="Pumm. Cuisses +3",feet="Pumm. Calligae +3"})
	sets.engaged.AccLow.PDT = set_combine(sets.engaged.PDT, {})
	sets.engaged.AccHigh.PDT = set_combine(sets.engaged.AccLow.PDT, {})
	
--***Great Axes***--
	--504: base = 4-hit--
	sets.engaged.Chango = {ammo="Yetshila",
		head=gear.ValorHeadTP,neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
	    body="Boii Lorica +1",hands=gear.ValorHandsTP,ring1="Petrov Ring",ring2="Rajas Ring",
		back=gear.STRcape,waist="Ioskeha Belt",legs=gear.OdysseanLegsTP,feet="Pumm. Calligae +3"}
	sets.engaged.Chango.AccLow = set_combine(sets.engaged.Chango, {
	    head="Valorous Mask",ear1="Dignitary's Earring", ear2="Cessance Earring",
		hands="Valorous Mitts",
	    waist="Ioskeha Belt",feet=gear.ValorFeetAcc})
	sets.engaged.Chango.AccHigh = set_combine(sets.engaged.Chango.AccLow, {ammo="Seeth. Bomblet +1",
	    head="Valorous Mask", neck="Subtlety Spectacles",
		body="Emicho Haubert", hands=gear.ValorHandsAcc,ring1="Cacoethic Ring +1",ring2="Cacoethic Ring",
		back=gear.DEXcape, waist="Ioskeha Belt",legs="Pumm. Cuisses +3",feet="Pumm. Calligae +3"})
	sets.engaged.Chango.PDT = set_combine(sets.engaged.Chango.AccHigh, { ammo="Staunch Tathlum",
		head="Pummeler's Mask +2",neck="Agitator's Collar", ear1="Telos Earring",
	    body="Arke Corazza",hands="Pumm. Mufflers +2",ring1="Defending Ring",ring2="Patricius Ring",
	    back=gear.DEXcape,legs="Pumm. Cuisses +3",feet="Pumm. Calligae +3"})
	sets.engaged.Chango.AccLow.PDT = set_combine(sets.engaged.Chango.PDT, {})
	sets.engaged.Chango.AccHigh.PDT = set_combine(sets.engaged.Chango.AccLow.PDT, {})
	
	sets.engaged.Instigator = sets.engaged.Chango
	sets.engaged.Instigator.AccLow = sets.engaged.Chango.AccLow
	sets.engaged.Instigator.AccHigh = sets.engaged.Chango.AccHigh
	sets.engaged.Instigator.PDT = sets.engaged.Chango.PDT
	sets.engaged.Instigator.AccLow.PDT = set_combine(sets.engaged.Instigator.PDT, {})
	sets.engaged.Instigator.AccHigh.PDT = set_combine(sets.engaged.Instigator.AccLow.PDT, {})
	
	--sets.engaged.Conqueror = {}
	--sets.engaged.Conqueror.AccLow = set_combine(sets.engaged.Conqueror, {})
	--sets.engaged.Conqueror.AccHigh = set_combine(sets.engaged.Conqueror.AccLow, {})
	--sets.engaged.Conqueror.PDT = set_combine(sets.engaged.Conqueror, {})
	--sets.engaged.Conqueror.AccLow.PDT = set_combine(sets.engaged.Conqueror.PDT, {})
	--sets.engaged.Conqueror.AccHigh.PDT = set_combine(sets.engaged.Conqueror.AccLow.PDT, {})
	-- Conqueror Aftermath Lv.3 sets
	--sets.engaged.Conqueror.AM3 = {}
	--sets.engaged.Conqueror.AccLow.AM3 = set_combine(sets.engaged.Conqueror.AM3, {})
	--sets.engaged.Conqueror.AccHigh.AM3 = set_combine(sets.engaged.Conqueror.AccLow.AM3, {})
	--sets.engaged.Conqueror.PDT.AM3 = set_combine(sets.engaged.Conqueror.AM3, {})
	--sets.engaged.Conqueror.AccLow.PDT.AM3 = set_combine(sets.engaged.Conqueror.PDT.AM3, {})
	--sets.engaged.Conqueror.AccHigh.PDT.AM3 = set_combine(sets.engaged.Conqueror.AccLow.PDT.AM3, {})
	
	--sets.engaged.Bravura = {}
	--sets.engaged.Bravura.AccLow = set_combine(sets.engaged.Bravura, {})
	--sets.engaged.Bravura.AccHigh = set_combine(sets.engaged.Bravura.AccLow, {})
	--sets.engaged.Bravura.PDT = set_combine(sets.engaged.Bravura, {})
	--sets.engaged.Bravura.AccLow.PDT = set_combine(sets.engaged.Bravura.PDT, {})
	--sets.engaged.Bravura.AccHigh.PDT = set_combine(sets.engaged.Bravura.AccLow.PDT, {})
	-- Bravura Aftermath sets, will only apply if aftermath, bravura, and hybridmode are on
	--sets.engaged.Bravura.PDT.AM = set_combine(sets.engaged.Bravura, {})
	--sets.engaged.Bravura.AccLow.PDT.AM = set_combine(sets.engaged.Bravura.PDT.AM , {})
	--sets.engaged.Bravura.AccHigh.PDT.AM = set_combine(sets.engaged.Bravura.AccLow.PDT.AM , {})
	
--***Great Swords***--

	--Rag: base = 5-hit--
	sets.engaged.Ragnarok =  {ammo="Yetshila",
		head=gear.ValorHeadTP,neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
	    body="Boii Lorica +1",hands=gear.ValorHandsTP,ring1="Petrov Ring",ring2="Rajas Ring",
		back="Cichol's Mantle",waist="Ioskeha Belt",legs=gear.OdysseanLegsTP,feet="Boii Calligae +1"}
	sets.engaged.Ragnarok.AccLow = set_combine(sets.engaged.Ragnarok, { ammo="Seeth. Bomblet +1",
	    head=gear.ValorHeadAcc,neck="Lissome Necklace",ear1="Telos Earring",ear2="Cessance Earring",
		body="Emicho Haubert",
	    feet="Pumm. Calligae +3"})
	sets.engaged.Ragnarok.AccHigh = set_combine(sets.engaged.Ragnarok.AccLow, {ammo="Seeth. Bomblet +1",
	    neck="Combatant's Torque", ear1="Telos Earring", ear2="Dignitary's Earring", 
		hands=gear.ValorHandsAcc, ring1="Cacoethic Ring +1", ring2="Cacoethic Ring", 
		back=gear.DEXcape, legs=gear.OdysseanLegsAcc})
	sets.engaged.Ragnarok.PDT = set_combine(sets.engaged.Ragnarok, { ammo="Staunch Tathlum",
		head="Pummeler's Mask +2",neck="Agitator's Collar", ear1="Telos Earring",
	    body="Pumm. Lorica +3",hands="Pumm. Mufflers +2",ring1="Defending Ring",ring2="Patricius Ring",
	    back=gear.DEXcape,legs="Pumm. Cuisses +3",feet="Pumm. Calligae +3"})
	sets.engaged.Ragnarok.AccLow.PDT = set_combine(sets.engaged.Ragnarok.PDT, {})
	sets.engaged.Ragnarok.AccHigh.PDT = set_combine(sets.engaged.Ragnarok.AccLow.PDT, {})	
	
	--504: base = 4-hit--
    sets.engaged.Zulfiqar = {ammo="Ginsen",
		head="Yorium Barbuta",neck="Lissome Necklace",ear1="Brutal Earring",ear2="Tripudio Earring",
	    body="Boii Lorica +1",hands="Acro Gauntlets",ring1="Petrov Ring",ring2="Rajas Ring",
		back="Cichol's Mantle",waist="Windbuffet Belt +1",legs=gear.OdysseanLegsTP,feet="Boii Calligae +1"}
	sets.engaged.Zulfiqar.AccLow = set_combine(sets.engaged.Zulfiqar, {head="Valorous Mask",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Odyssean Chestplate",
	    waist="Dynamic Belt +1",feet=gear.ValorFeetAcc})
	sets.engaged.Zulfiqar.AccHigh = set_combine(sets.engaged.Zulfiqar.AccLow, {ammo="Seeth. Bomblet +1",
	    head="Valorous Mask", neck="Subtlety Spectacles", ear1="Dignitary's Earring", ear2="Cessance Earring", 
		body="Emicho Haubert", hands="Valorous Mitts", ring1="Cacoethic Ring",
		back="Grounded Mantle +1", waist="Kentarch Belt +1",legs=gear.OdysseanLegsAcc})
	sets.engaged.Zulfiqar.PDT = set_combine(sets.engaged.Zulfiqar, {head="Odyssean Helm",neck="Agitator's Collar",
	    body="Arke Corazza",hands="Yorium Gauntlets",ring1="Defending Ring",ring2="Patricius Ring",
	    legs="Eschite Cuisses",feet="Amm Greaves"})
	sets.engaged.Zulfiqar.AccLow.PDT = set_combine(sets.engaged.Zulfiqar.PDT, {})
	sets.engaged.Zulfiqar.AccHigh.PDT = set_combine(sets.engaged.Zulfiqar.AccLow.PDT, {})
	
--Dual Wield and other misc.--	

	sets.engaged.Odium =   {ammo="Seeth. Bomblet +1",
		head="Skormoth Mask",neck="Lissome Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
	    body="Boii Lorica +1",hands="Acro Gauntlets",ring1="Petrov Ring",ring2="Haverton Ring",
		back="Cichol's Mantle",waist="Shetal Stone",legs=gear.OdysseanLegsTP,feet="Boii Calligae +1"}
	sets.engaged.Odium.AccLow = set_combine(sets.engaged.Odium, { head="Valorous Mask", neck="Lissome Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
	    waist="Dynamic Belt +1",feet=gear.ValorFeetAcc})
	sets.engaged.Odium.AccHigh = set_combine(sets.engaged.Odium.AccLow, {ammo="Seeth. Bomblet +1",
	    head="Valorous Mask", neck="Subtlety Spectacles", ear1="Dignitary's Earring", ear2="Cessance Earring", 
		body="Emicho Haubert", hands="Valorous Mitts", ring1="Cacoethic Ring",
		back="Grounded Mantle +1", waist="Kentarch Belt +1",legs=gear.OdysseanLegsAcc})
	--sets.engaged.Purgation.PDT = set_combine(sets.engaged.Purgation, {head="Lithelimb Cap",neck="Agitator's Collar",
	--body="Emet Harness +1",hands="Umuthi Gloves"})
	--sets.engaged.Purgation.AccLow.PDT = set_combine(sets.engaged.Purgation, {})
	--sets.engaged.Purgation.AccHigh.PDT = set_combine(sets.engaged.Purgation.AccLow.PDT, {})
	
	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	-- Mighty Strikes TP Gear, combines with current melee set.
	sets.buff.MS = {ammo="Yetshila", feet="Boii Calligae +1", back="Mauler's Mantle"}
	-- Day/Element Helm, if helm is not in inventory or wardrobe, this will not fire, for those who do not own one
	sets.WSDayBonus = {}
	-- Earrings to use with Upheaval when TP is 3000
	--sets.VIT_earring = {ear1="Terra's Pearl",ear2="Brutal Earring"}
	-- Earrings to use with all other weaponskills when TP is 3000
	sets.STR_earring = {ear1="Vulcan's Pearl",ear2="Brutal Earring"}
	-- Mantle to use with Upheaval on Darksday
	sets.Upheaval_shadow = {}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)

end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.type == 'WeaponSkill' then
            if is_sc_element_today(spell) and player.inventory['Gavialis Helm'] or player.wardrobe['Gavialis Helm'] then
                equip(sets.WSDayBonus)
            end
			if player.tp == 3000 then
				if spell.english == "Upheaval" then
					equip(sets.STR_earring)
				end
			end
			if spell.english == "Upheaval" and world.day_element == 'Dark' then
				equip(sets.Upheaval_shadow)
			end
			if world.time >= (17*60) or world.time <= (7*60) then
			    equip({ear1="Lugra Earring +1"})
			end	
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if spell.english == "Tomahawk" and not spell.interrupted then 
		send_command('timers create "Tomahawk" 90 down')
	end
end

-- Run after the default aftercast() is done.
-- eventArgs is the same one used in job_aftercast, in case information needs to be persisted.
function job_post_aftercast(spell, action, spellMap, eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)
	update_combat_weapon()
	update_melee_groups()
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if buff == "Aftermath: Lv.3" or buff == "Aftermath" then
		classes.CustomMeleeGroups:clear()
		if (buff == "Aftermath: Lv.3" and gain) or buffactive["Aftermath: Lv.3"] then
			if player.equipment.main == "Conqueror" then
				classes.CustomMeleeGroups:append('AM3')
				if gain then
					send_command('timers create "Aftermath: Lv.3" 180 down;wait 120;input /echo Aftermath: Lv.3 [WEARING OFF IN 60 SEC.];wait 30;input /echo Aftermath: Lv.3 [WEARING OFF IN 30 SEC.];wait 20;input /echo Aftermath: Lv.3 [WEARING OFF IN 10 SEC.]')
				else
					send_command('timers delete "Aftermath: Lv.3"')
                    add_to_chat(123,'AM3: [OFF]')
				end
			end
		end
		if (buff == "Aftermath" and gain) or buffactive.Aftermath then
			if player.equipment.main == "Bravura" and state.HybridMode.value == 'PDT' then
				classes.CustomMeleeGroups:append('AM')
			end
		end
	end
	if buff == "Aftermath: Lv.3" or buff == "Aftermath" then
		handle_equipping_gear(player.status)
	end
	if buff == 'Blood Rage' and gain then
		send_command('timers create "Blood Rage" 60 down abilities/00255.png')
		else
		send_command('timers delete "Blood Rage"')
	end
	if buff == 'Warcry' and gain then
		send_command('timers create "Warcry" 60 down abilities/00255.png')
		else
		send_command('timers delete "Warcry"')
	end
	if buff == "sleep" and gain and player.hp > 200 and player.status == "Engaged" then
		equip({neck="Berserker's Torque"})
		else
		handle_equipping_gear(player.status)
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, spellMap, default_wsmode)
	local wsmode = ''
	if state.Buff['Mighty Strikes'] then
        wsmode = wsmode .. 'MS'
    end
        if wsmode ~= '' then
            return wsmode
    end
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	if buffactive["Mighty Strikes"] then
		meleeSet = set_combine(meleeSet, sets.buff.MS)
	end
	return meleeSet
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
	update_combat_weapon()
	update_melee_groups()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
local msg = 'Melee'
if state.CombatForm.has_value then
msg = msg .. ' (' .. state.CombatForm.value .. ')'
end
if state.CombatWeapon.has_value then
msg = msg .. ' (' .. state.CombatWeapon.value .. ')'
end
msg = msg .. ': '
msg = msg .. state.OffenseMode.value
if state.HybridMode.value ~= 'Normal' then
msg = msg .. '/' .. state.HybridMode.value
end
msg = msg .. ', WS: ' .. state.WeaponskillMode.value
if state.DefenseMode.value ~= 'None' then
msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
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

-- Select default macro book on initial load or subjob change.
function select_default_macro_book(WAR)
	set_macro_page(3,11)
end

function update_combat_weapon()
	state.CombatWeapon:set(player.equipment.main)
end

function update_melee_groups()
	classes.CustomMeleeGroups:clear()
	if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Conqueror" then
		classes.CustomMeleeGroups:append('AM3')
	end
	if buffactive.Aftermath and player.equipment.main == "Bravura" and state.HybridMode.value == 'PDT' then
		classes.CustomMeleeGroups:append('AM')
	end
end

function is_sc_element_today(spell)
    if spell.type ~= 'WeaponSkill' then
        return
    end

   local weaponskill_elements = S{}:
    union(skillchain_elements[spell.skillchain_a]):
    union(skillchain_elements[spell.skillchain_b]):
    union(skillchain_elements[spell.skillchain_c])

    if weaponskill_elements:contains(world.day_element) then
        return true
    else
        return false
    end
end