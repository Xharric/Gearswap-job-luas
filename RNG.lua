-------------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

	-- Load and initialize the include file.
	include('Mote-Include.lua')
	include('organizer-lib')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	state.Buff.Barrage = buffactive.Barrage or false
	state.Buff.Camouflage = buffactive.Camouflage or false
	state.Buff['Unlimited Shot'] = buffactive['Unlimited Shot'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.RangedMode:options('Normal', 'Acc', 'FullAcc')
	state.OffenseMode:options('Normal', 'DW', 'Acc', 'DWAcc')
	state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('PDT', 'Range')
	state.IdleMode:options('Normal', 'Range')
	
	gear.default.weaponskill_neck = "Fotia Gorget"
	gear.default.weaponskill_waist = "Fotia Belt"
	
	gear.HercHeadMAB = { name="Herculean Helm", augments={'Mag. Acc.+14 "Mag.Atk.Bns."+14','Weapon skill damage +3%','Mag. Acc.+8','"Mag.Atk.Bns."+15'}}
	gear.HercHeadSTR = { name="Herculean Helm", augments={'Rng.Atk.+25','Weapon skill damage +1%','STR+13','Rng.Acc.+8'}}
	
	gear.HercHandsPDT = { name="Herculean Gloves", augments={'Accuracy+24 Attack+24','Phys. dmg. taken -3%','DEX+5','Accuracy+11','Attack+1',}}
	
	gear.HercLegsAGI = { name="Herculean Trousers", augments={'Rng.Atk.+12','Phys. dmg. taken -3%','AGI+15','Rng.Acc.+15'}}
	gear.HercLegsMAB = { name="Herculean Trousers", augments={'Mag. Acc.+13 "Mag.Atk.Bns."+13','MND+9','Mag. Acc.+14','"Mag.Atk.Bns."+11'}}
	
	gear.TaeonFeetSnap = { name="Taeon Boots", augments = {'Rng.Acc.+19 Rng.Atk.+19','"Snapshot"+5','"Snapshot"+4'}}
	gear.HercFeetAGI = { name="Herculean Boots", augments = {'Rng.Acc.+24 Rng.Atk.+24','AGI+13'}}
	gear.HercFeetMAB = { name="Herculean Boots", augments = {'Accuracy+15','MND+7','Weapon skill damage +3%','Mag. Acc.+20 "Mag.Atk.Bns."+20',}}
	
	DefaultAmmo = {['Nobility'] = "Achiyalabopa arrow", ['Annihilator'] = "Eradicating bullet"}
	U_Shot_Ammo = {['Nobility'] = "Achiyalabopa arrow", ['Annihilator'] = "Eradicating bullet"}

	select_default_macro_book()

	send_command('bind f9 gs c cycle RangedMode')
	send_command('bind ^f9 gs c cycle OffenseMode')
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind f9')
	send_command('unbind ^f9')
end


-- Set up all gear sets.
function init_gear_sets()
	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
	sets.precast.JA['Bounty Shot'] = {hands="Sylvan Glovelettes +2"}
	sets.precast.JA['Camouflage'] = {body="Orion Jerkin +1"}
	sets.precast.JA['Scavenge'] = {feet="Orion Socks +1"}
	sets.precast.JA['Shadowbind'] = {hands="Orion Bracers +2"}
	sets.precast.JA['Sharpshot'] = {legs="Orion Braccae +1"}
	sets.precast.JA['Eagle Eye Shot'] = set_combine(sets.midcast.RA,{legs="Arcadian Braccae +1"})


	-- Fast cast sets for spells

	sets.precast.FC = {
		head="Herculean Helm",ear2="Loquacious Earring",
		body="Dread Jupon",hands="Leyline Gloves",ring1="Lebeche Ring"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC)


	-- Ranged sets (snapshot)
	
	sets.precast.RA = {
		head="Arcadian Beret +1",
		body="Amini Caban +1",hands="Carmine Finger Gauntlets +1",ring1="Haverton Ring",
		back="Lutian Cape",waist="Yemaya Belt",legs="Adhemar Kecks",feet=gear.TaeonFeetSnap}


	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head=gear.HercHeadSTR,neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Vulcan's Pearl",
		body="Amini Caban +1",hands="Adhemar Wristbands",ring1="Ifrit Ring +1",ring2="Rajas Ring",
		back="Belenus's Cape",waist="Fotia Belt",legs="Pursuer's Pants",feet="Pursuer's Gaiters" }    
	
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {body="Amini Caban +1",ring1="Haverton Ring",
		back="Lutian Cape",legs="Orion Braccae +1"})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

	sets.precast.WS['Coronach'] = {range="Annihilator",
		head=gear.HercHeadSTR,neck="Fotia Gorget",ear1="Vulcan's Pearl",ear2="Ishvara Earring",
		body="Amini Caban +1",hands="Meghanada Gloves +1",ring1="Dingir Ring",ring2="Ifrit Ring +1",
		back="Belenus's Cape",waist="Fotia Belt",legs="Pursuer's Pants",feet=gear.HercFeetAGI }
	
	sets.precast.WS['Last Stand'] = {
		head="Meghanada Visor +1",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Enervating Earring",
		body="Amini Caban +1",hands="Meghanada Gloves +1",ring1="Dingir Ring",ring2="Garuda Ring +1",
		back="Belenus's Cape",waist="Fotia Belt",legs=gear.HercLegsAGI,feet=gear.HercFeetAGI }
	
    sets.precast.WS['Wildfire'] = {
		head=gear.HercHeadMAB,neck="Sanctity Necklace",ear1="Crematio Earring",ear2="Friomisi Earring",
		body="Samnuha Coat",hands="Carmine Finger Gauntlets +1",ring1="Dingir Ring",ring2="Shiva Ring +1",
		back="Argochampsa Mantle",waist="Eschan Stone",legs=gear.HercLegsMAB,feet=gear.HercFeetMAB }
	
	sets.precast.WS['Trueflight'] = {
		head=gear.HercHeadMAB,neck="Sanctity Necklace",ear1="Moonshade Earring",ear2="Friomisi Earring",
		body="Samnuha Coat",hands="Carmine Finger Gauntlets +1",ring1="Dingir Ring",ring2="Shiva Ring +1",
		back="Argochampsa Mantle",waist="Eschan Stone",legs=gear.HercLegsMAB,feet=gear.HercFeetMAB }
	
	sets.precast.WS['Jishnu/s Radiance'] = {
		head="Adhemar Bonnet",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Enervating Earring",
		body="Amini Caban +1",hands="Adhemar Wristbands",ring1="Apate Ring",ring2="Rajas Ring",
		back="Lutian Cape",waist="Fotia Belt",legs="Samnuha Tights",feet="Pursuer's Gaiters" }
	
	sets.precast.WS['Aeolian Edge'] = {
		head=gear.HercHeadMAB,neck="Sanctity Necklace",ear1="Moonshade Earring",ear2="Friomisi Earring",
		body="Samnuha Coat",hands="Leyline Gloves",ring1="Fenrir Ring +1",ring2="Shiva Ring +1",
		back="Argochampsa Mantle",waist="Eschan Stone",legs=gear.HercLegsMAB,feet=gear.HercFeetMAB }
	
	
	--To ensure Organizer grabs some otherwise undefined gear.--
	sets.precast.WS['Drakesbane'] = {main="Perun +1",sub="Nusku Shield",range="Nobility",ammo="Achiyalabopa Arrow",
	ring1="Warp Ring",ring2="Capacity Ring"}
	sets.precast.WS['Drakesbane'].Acc = {main="Oneiros Knife",sub="Nusku Shield",range="Annihilator", ammo="Eradicating Bullet",
	ring1="Warp Ring",ring2="Capacity Ring"}
	
	
	--------------------------------------
	-- Midcast sets
	--------------------------------------

	-- Fast recast for spells
	
	sets.midcast.FastRecast = {
		head="Orion Beret +1",ear1="Loquacious Earring",legs="Orion Braccae +1",feet="Orion Socks +1"}

	sets.midcast.Utsusemi = {}

	--------------------------------------
	-- Ranged sets
    --------------------------------------
	
	sets.midcast.RA = {
		head="Arcadian Beret +1",neck="Iskur Gorget",ear1="Telos Earring",ear2="Enervating Earring",
		body="Amini Caban +1",hands="Adhemar Wristbands",ring1="Haverton Ring",ring2="Rajas Ring",
		back="Belenus's Cape",waist="Yemaya Belt",legs="Amini Brague +1",feet="Adhemar Gamashes"}
	
	sets.midcast.RA.Acc = set_combine(sets.midcast.RA,
		{head="Arcadian Beret +1",
		ring2="Cacoethic Ring +1",
		legs="Adhemar Kecks",feet=gear.HercFeetAGI})
		
	sets.midcast.RA.FullAcc	= set_combine(sets.midcast.RA.Acc,{
	     head="Meghanada Visor +1",
		 waist="Eschan Stone"})

	-------GUNS-------
	
	---297 TP---
	sets.midcast.RA.Annihilator = set_combine(sets.midcast.RA)
    ---277 TP---
	sets.midcast.RA.Annihilator.Acc = set_combine(sets.midcast.RA.Acc)
	---203 TP---
    sets.midcast.RA.Annihilator.FullAcc = set_combine(sets.midcast.RA.FullAcc)
    
	-------BOWS-------
    
	---291 TP---
	sets.midcast.RA.Nobility = set_combine(sets.midcast.RA)
    ---272 TP---
	sets.midcast.RA.Nobility.Acc = set_combine(sets.midcast.RA.Acc)
	---200 TP ---
	sets.midcast.RA.Nobility.FullAcc = set_combine(sets.midcast.RA.FullAcc)
	
	-------XBOWS-------
	
	
	
	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {head="Ocelomeh Headpiece +1",neck="Bathy Choker +1",
		ring1="Sheltered Ring",ring2="Paguroidea Ring"}

	-- Idle sets
	sets.idle = {
		head="Ocelomeh Headpiece +1",neck="Bathy Choker +1",ear1="Merman's Earring",ear2="Etiolation Earring",
		body="Kheper Jacket",hands="Umuthi Gloves",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Solemnity Cape",waist="Flume Belt",legs="Carmine Cuisses +1",feet="Qaaxo Leggings"}
		
	sets.idle.Town = {
		head="Ocelomeh Headpiece +1",neck="Bathy Choker +1",ear1="Merman's Earring",ear2="Etiolation Earring",
		body="Councilor's Garb",hands="Umuthi Gloves",ring1="Sheltered Ring",ring2="Trizek Ring",
		back="Solemnity Cape",waist="Flume Belt",legs="Carmine Cuisses +1",feet="Qaaxo Leggings"}	
	
	sets.idle.Range = {
		head="Arcadian Beret +1",neck="Ocachi Gorget",ear1="Telos Earring",ear2="Enervating Earring",
		body="Amini Caban +1",hands="Adhemar Wristbands",ring1="Haverton Ring",ring2="Rajas Ring",
		back="Lutian Cape",waist="Yemaya Belt",legs="Amini Brague +1",feet="Amini Bottillons +1"}
		
	-- Defense sets
	sets.defense.PDT = {
		head="Genmei Kabuto",neck="Loricate Torque +1",ear1="Merman's Earring",ear2="Etiolation Earring",
		body="Samnuha Coat",hands=gear.HercHandsPDT,ring1="Defending Ring",ring2="Dark Ring",
		back="Solemnity Cape",waist="Flume Belt",legs=gear.HercLegsAGI,feet="Qaaxo Leggings"}
	
	sets.defense.Range = {
		head="Arcadian Beret +1",neck="Ocachi Gorget",ear1="Telos Earring",ear2="Enervating Earring",
		body="Amini Caban +1",hands="Adhemar Wristbands",ring1="Haverton Ring",ring2="Rajas Ring",
		back="Lutian Cape",waist="Yemaya Belt",legs="Amini Brague +1",feet="Amini Bottillons +1"}
	
	sets.defense.MDT = {
		head=gear.HercHeadSTR,neck="Loricate Torque +1",ear1="Merman's Earring",ear2="Etiolation Earring",
		body="Amini Caban +1",hands="Leyline Gloves",ring1="Defending Ring",ring2="Shadow Ring",
		back="Engulfer Cape +1",waist="Eschan Stone",legs="Iuitl Tights +1",feet="Adhemar Gamashes"}

	sets.Kiting = {feet="Skadi's Jambeaux +1"}


	--------------------------------------
	-- Engaged sets
	--------------------------------------

	sets.engaged = {
		head="Adhemar Bonnet",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Rawhide Vest", hands="Adhemar Wristbands", ring1="Petrov Ring",ring2="Rajas Ring",
		back="Bleating Mantle",waist="Windbuffet Belt +1",legs="Samnuha Tights",feet="Adhemar Gamashes"}

	sets.engaged.Acc = set_combine(sets.engaged,{neck="Lissome Necklace",
		body="Samnuha Coat",ring1="Cacoethic Ring",ring2="Patricius Ring",
		back="Letalis Mantle",waist="Kentarch Belt +1"})
	
	sets.engaged.DW = set_combine(sets.engaged,{ear1="Heartseeker Earring",ear2="Dudgeon Earring",
	ring1="Haverton Ring"})
	
	sets.engaged.DWAcc = set_combine(sets.engaged.Acc,{ear1="Heartseeker Earring",ear2="Dudgeon Earring"})
	
	--------------------------------------
	-- Custom buff sets
	--------------------------------------

	sets.buff.Barrage = set_combine(sets.midcast.RA.Acc, {hands="Orion Bracers +2"})
	sets.buff.Camouflage = {body="Orion Jerkin +1"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Ranged Attack' then
		state.CombatWeapon:set(player.equipment.range)
	end

	if spell.action_type == 'Ranged Attack' or
	  (spell.type == 'WeaponSkill' and (spell.skill == 'Marksmanship' or spell.skill == 'Archery')) then
		check_ammo(spell, action, spellMap, eventArgs)
	end
	
	if state.DefenseMode.value ~= 'None' and spell.type == 'WeaponSkill' then
		-- Don't gearswap for weaponskills when Defense is active.
		eventArgs.handled = true
	end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Ranged Attack' and state.Buff.Barrage then
		equip(sets.buff.Barrage)
		eventArgs.handled = true
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if buff == "Camouflage" then
		if gain then
			equip(sets.buff.Camouflage)
			disable('body')
		else
			enable('body')
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Check for proper ammo when shooting or weaponskilling
function check_ammo(spell, action, spellMap, eventArgs)
	-- Filter ammo checks depending on Unlimited Shot
	if state.Buff['Unlimited Shot'] then
		if player.equipment.ammo ~= U_Shot_Ammo[player.equipment.range] then
			if player.inventory[U_Shot_Ammo[player.equipment.range]] or player.wardrobe[U_Shot_Ammo[player.equipment.range]] then
				add_to_chat(122,"Unlimited Shot active. Using custom ammo.")
				equip({ammo=U_Shot_Ammo[player.equipment.range]})
			elseif player.inventory[DefaultAmmo[player.equipment.range]] or player.wardrobe[DefaultAmmo[player.equipment.range]] then
				add_to_chat(122,"Unlimited Shot active but no custom ammo available. Using default ammo.")
				equip({ammo=DefaultAmmo[player.equipment.range]})
			else
				add_to_chat(122,"Unlimited Shot active but unable to find any custom or default ammo.")
			end
		end
	else
		if player.equipment.ammo == U_Shot_Ammo[player.equipment.range] and player.equipment.ammo ~= DefaultAmmo[player.equipment.range] then
			if DefaultAmmo[player.equipment.range] then
				if player.inventory[DefaultAmmo[player.equipment.range]] then
					add_to_chat(122,"Unlimited Shot not active. Using Default Ammo")
					equip({ammo=DefaultAmmo[player.equipment.range]})
				else
					add_to_chat(122,"Default ammo unavailable.  Removing Unlimited Shot ammo.")
					equip({ammo=empty})
				end
			else
				add_to_chat(122,"Unable to determine default ammo for current weapon.  Removing Unlimited Shot ammo.")
				equip({ammo=empty})
			end
		elseif player.equipment.ammo == 'empty' then
			if DefaultAmmo[player.equipment.range] then
				if player.inventory[DefaultAmmo[player.equipment.range]] then
					add_to_chat(122,"Using Default Ammo")
					equip({ammo=DefaultAmmo[player.equipment.range]})
				else
					add_to_chat(122,"Default ammo unavailable.  Leaving empty.")
				end
			else
				add_to_chat(122,"Unable to determine default ammo for current weapon.  Leaving empty.")
			end
		elseif player.inventory[player.equipment.ammo].count < 15 then
			add_to_chat(122,"Ammo '"..player.inventory[player.equipment.ammo].shortname.."' running low ("..player.inventory[player.equipment.ammo].count..")")
		end
	end
end



-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(2, 1)
end