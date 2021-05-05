-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	options.OffenseModes = {'Normal', 'Acc'}
	options.DefenseModes = {'Normal'}
	options.WeaponskillModes = {'Normal'}
	options.CastingModes = {'Normal', 'Resistant', 'Dire'}
	options.IdleModes = {'Normal', 'PDT'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'None','PDT'}
	options.MagicalDefenseModes = {'None','MDT'}

	-- Default macro set/book
	set_macro_page(2, 2)
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.

-- Called when this job file is unloaded (eg: job change)
function file_unload()
	if binds_on_unload then
		binds_on_unload()
	end
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets

	-- Fast cast sets for spells
	sets.precast.FC = {main="Marin Staff +1",sub="Arbuda Grip",ammo="Impatiens",
		head="Nahtirah Hat",neck="Cleric's Torque",ear1="Etiolation Earring",ear2="Loquacious Earring",
		body="Inyanga Jubbah +1",hands="Fanatic Gloves",ring1="Prolix Ring",ring2="Weatherspoon Ring",
		back="Perimede Cape",waist="Witful Belt",legs="Aya. Cosciales +2",feet=gear.TelchineFCBoots}
		
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {head="Umuthi Hat"})

	sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {legs="Ebers Pantaloons +1"})

	sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

	sets.precast.FC.Cure = {main="Vadose Rod",sub="Genbu's Shield",ammo="Impatiens",
		head="Theophany Cap +2",neck="Cleric's Torque",ear1="Etiolation Earring",ear2="Loquacious Earring",
		body="Heka's Kalasiris",hands="Vanya Cuffs",ring1="Prolix Ring",ring2="Weatherspoon Ring",
		back="Pahtli Cape",waist="Witful Belt",legs="Ebers Pantaloons +1",feet="Hygieia Clogs +1"}

	sets.precast.FC.Curaga = sets.precast.FC.Cure
	
	-- Precast sets to enhance JAs
	sets.precast.JA.Benediction = {body="Piety Bliaud +1"}
	sets.precast.JA['Devotion'] = {feet="Piety Cap +1"}
	
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Nahtirah Hat",ear1="Roundel Earring",
		body="Helios Jacket",hands="Theophany Mitts +2",
		back="Aurist's Cape +1",legs="Assiduity Pants +1",feet="Piety Duckbills +1"}

	-- Weaponskill sets

	-- Default set for any weaponskill that isn't any more specifically defined
	gear.default.weaponskill_neck = "Clotharius Torque"
	gear.default.weaponskill_waist = "Wanion Belt"
	sets.precast.WS = {ammo="Floestone",
		head="Ayanmo Zucchetto +1",neck=gear.ElementalGorget,ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Ayanmo Corazza +2",hands="Ayanmo Manopolas +1",ring1="Ilabrat Ring",ring2="Rufescent Ring",
		back="Aurist's Cape +1",waist=gear.ElementalBelt,legs="Aya. Cosciales +2",feet="Ayanmo Gambieras +1"}
	sets.precast.WS['Flash Nova'] = {ammo="Floestone",
		head="Chironic Hat",neck="Sanctity Necklace",ear1="Crematio Earring",ear2="Friomisi Earring",
		body="Witching Robe",hands="Chironic Gloves",ring1="Acumen Ring",ring2="Shiva Ring +1",
		back="Toro Cape",waist="Refoccilation Stone",legs="Gyve Trousers",feet="Chironic Slippers"}
	sets.precast.WS['Mystic Boon'] = {ammo="Hydrocera",
		head="Befouled Crown",neck=gear.ElementalGorget,ear1="Lifestorm Earring",ear2="Bladeborn Earring",
		body="Vanya Robe",hands="Theophany Mitts +1",ring1="Ilabrat Ring",ring2="Rufescent Ring",
		back="Aurist's Cape +1",waist=gear.ElementalBelt,legs="Vanya Slops",feet="Ebers Duckbills +1"}	

	-- Midcast Sets
	
	sets.midcast.FastRecast = {main="Marin Staff",sub="Arbuda Grip",ammo="Hasty Pinion +1",
		head="Nahtirah Hat",neck="Cleric's Torque",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
		body="Inyanga Jubbah +1",hands="Fanatic Gloves",ring1="Lebeche Ring",ring2="Weatherspoon Ring",
		back="Swith Cape",waist="Witful Belt",legs="Aya. Cosciales +2",feet="Umbani Boots"}
	
	-- Cure sets
	gear.default.obi_waist = "Bishop's Sash"
	gear.default.obi_back = "Mending Cape"
	gear.default.ElementalCape = "Alaunus's Cape"
	
	sets.midcast.CureSolace = {main="Queller Rod",sub="Genbu's Shield",ammo="Hydrocera",
		head="Vanya Hood",neck="Incanter's Torque",ear1="Nourish. Earring +1",ear2="Beatific Earring",
		body="Ebers Bliaud +1",hands="Theophany Mitts +2",ring1="Haoma's Ring",ring2="Sirona's Ring",
		back="Mending Cape",waist="Bishop's Sash",legs="Ebers Pantaloons +1",feet="Vanya Clogs"}

	sets.midcast.Cure = {main="Queller Rod",sub="Genbu's Shield",ammo="Hydrocera",
		head="Vanya Hood",neck="Incanter's Torque",ear1="Nourish. Earring +1",ear2="Beatific Earring",
		body="Ebers Bliaud +1",hands="Theophany Mitts +2",ring1="Haoma's Ring",ring2="Sirona's Ring",
		back="Mending Cape",waist="Bishop's Sash",legs="Ebers Pantaloons +1",feet="Vanya Clogs"}

	sets.midcast.Curaga = {main="Ababinili",sub="Achaq Grip",ammo="Hydrocera",
		head="Ebers cap +1",neck="Imbodla Necklace",ear1="Novia Earring",ear2="Magnetic Earring",
		body="Heka's Kalasiris",hands="Theophany Mitts +2",ring1="Globidonta Ring",ring2="Lebeche Ring",
		back="Mending Cape",waist="Pythia Sash +1",legs="Ebers Pantaloons +1",feet="Vanya Clogs"}

	sets.midcast.CureMelee = {ammo="Impatiens",
		head="Vanya Hood",neck="Incanter's Torque",ear1="Nourish. Earring +1",ear2="Beatific Earring",
		body="Helios Jacket",hands="Theophany Mitts +2",ring1="Haoma's Ring",ring2="Sirona's Ring",
		back="Mending Cape",waist="Bishop's Sash",legs="Ebers Pantaloons +1",feet="Vanya Clogs"}

	sets.midcast.Cursna = {main="Yagrush",sub="Thuellaic Ecu +1",ammo="Hasty Pinion +1",
		head="Vanya Hood",neck="Malison Medallion",ear2="Beatific Earring",
		body="Ebers Bliaud +1",hands="Fanatic Gloves",ring1="Haoma's Ring",ring2="Ephedra Ring",
		back="Alaunus's Cape",waist="Bishop's Sash",legs="Th. Pantaloons +2",feet="Vanya Clogs"}

	sets.midcast.StatusRemoval = {main="Yagrush",sub="Thuellaic Ecu +1",
		head="Nahtirah Hat",neck="Cleric's Torque",legs="Ebers Pantaloons +1"}

	sets.midcast.Stoneskin = {
		head="Umuthi Hat",neck="Cleric's Torque",ear2="Loquacious Earring",
		body="Helios Jacket",hands="Dynasty Mitts",
		back="Swith Cape",waist="Siegel Sash",legs="Gendewitha Spats",feet="Theo. Duckbills +2"}

	sets.midcast.Auspice = {hands="Dynasty Mitts",feet="Ebers Duckbills +1"}
	sets.midcast.Haste = {}
	sets.midcast.Aquaveil = set_combine(sets.precast.FC['Enhancing Magic'],{main="Vadose Rod"})
	
	sets.midcast.BarElement = {main="Beneficus",sub="Thuellaic Ecu +1",
		head="Ebers Cap +1",neck="Incanter's Torque",
		body="Ebers Bliaud +1",hands="Ebers Mitts +1",
		back="Perimede Cape",waist="Olympus Sash",legs="Piety Pantaloons +1",feet="Ebers Duckbills +1"}

	sets.midcast.Regen = {main="Bolelabunga",sub="Thuellaic Ecu +1",
		head="Inyanga Tiara +2",body="Piety Briault +1",hands="Ebers Mitts +1",
		legs="Th. Pantaloons +2"}

	sets.midcast.Protectra = {main="Seveneyes",sub="Thuellaic Ecu +1",
		hands="Dynasty Mitts",ring1="Sheltered Ring",waist="Pythia Sash +1",feet="Piety Duckbills +1"}

	sets.midcast.Shellra = {main="Seveneyes",sub="Thuellaic Ecu +1",
		hands="Dynasty Mitts",ring1="Sheltered Ring",waist="Pythia Sash +1",legs="Piety Pantaloons +1"}

	-- 110 total Enhancing Magic Skill; caps even without Light Arts
	sets.midcast['Enhancing Magic'] = {main="Beneficus",sub="Thuellaic Ecu +1",
		head="Befouled Crown",neck="Incanter's Torque",
		body="Anhur Robe",hands="Dynasty Mitts",
		back="Mending Cape",waist="Olympus Sash",legs="Piety Pantaloons +1",feet="Ebers Duckbills +1"}

	sets.midcast['Enfeebling Magic'] = {main="Serenity",sub="Enki Strap",ammo="Hydrocera",
		head="Befouled Crown",neck="Imbodla Necklace",ear1="Enchanter earring +1",ear2="Gwati earring",
		body="Vanya Robe",hands="Chironic Gloves",ring1="Globidonta Ring",ring2="Weatherspoon Ring",
		back="Alaunus's Cape",waist="Luminary Sash",legs="Chironic Hose",feet="Medium's Sabots"}
	
	sets.midcast['Elemental Magic'] = {main="Serenity",sub="Niobid Strap",ammo="Pemphredo Tathlum",
		head="Chironic Hat",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Crematio Earring",
		body="Witching Robe",hands="Chironic Gloves",ring1="Acumen Ring",ring2="Shiva Ring +1",
		back=gear.ElementalCape,waist=gear.ElementalObi,legs="Chironic Hose",feet="Chironic Slippers"}	
	
	sets.midcast['Divine Magic'] = {main="Serenity",sub="Niobid Strap",ammo="Pemphredo Tathlum",
		head="Chironic Hat",neck="Sanctity Necklace",ear1="Enchanter earring +1",ear2="Gwati earring",
		body="Witching Robe",hands="Chironic Gloves",ring1="Shiva Ring +1",ring2="Weatherspoon Ring",
		back="Alaunus's Cape",waist="Luminary Sash",legs="Th. Pantaloons +2",feet="Chironic Slippers"}

	sets.midcast['Dark Magic'] = {main="Yagrush",sub="Thuellaic Ecu +1",
		head="Nahtirah Hat",neck="Incanter's Torque",ear1="Enchanter earring +1",ear2="Gwati earring",
		body="Vanya Robe",hands="Chironic Gloves",ring1="Shiva Ring +1",ring2="Weatherspoon Ring",
		back="Alaunus's Cape",waist="Luminary Sash",legs="Chironic Hose",feet="Medium's Sabots"}

	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {main="Boonwell Staff",sub="Oneiros Grip",ammo="Homiliary",
		head="Befouled Crown",body="Gendewitha Bliaut",hands="Serpentes Cuffs",
		waist="Fucho-no-Obi",legs="Assiduity Pants +1",feet="Serpentes Sabots"}

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {main="Bolelabunga",sub="Genbu's Shield", ammo="Homiliary",
		head="Befouled Crown", neck="Twilight Torque", ear1="Moonshade Earring", ear2="Infused Earring",
		body="Gendewitha Bliaut", hands="Inyan. Dastanas +2", ring1="Defending Ring", ring2="Shadow Ring",
		back="Moonbeam Cape", waist="Fucho-no-Obi", legs="Assiduity Pants +1", feet="Herald's Gaiters"}

	sets.idle.PDT = {main="Terra's Staff", sub="Oneiros Grip", ammo="Homiliary",
		head="Inyanga Tiara +2", neck="Twilight Torque", ear1="Moonshade Earring", ear2="Infused Earring",
		body="Ayanmo Corazza +2", hands="Inyan. Dastanas +2", ring1="Defending Ring", ring2="Shadow Ring",
		back="Moonbeam Cape", waist="Fucho-no-Obi", legs="Assiduity Pants +1", feet="Inyan. Crackows +1"}

	sets.idle.Town = {main="Yagrush",sub="Genbu's Shield", ammo="Homiliary",
		head="Befouled Crown", neck="Twilight Torque", ear1="Moonshade Earring", ear2="Infused Earring",
		body="Gendewitha Bliaut", hands="Inyan. Dastanas +2", ring1="Defending Ring", ring2="Shadow Ring",
		back="Moonbeam Cape", waist="Fucho-no-Obi", legs="Assiduity Pants +1", feet="Herald's Gaiters"}
	
	sets.idle.Weak = {main="Bolelabunga",sub="Genbu's Shield",ammo="Homiliary",
		head="Ebers cap +1",neck="Twilight Torque",ear1="Moonshade Earring",ear2="Infused Earring",
		body="Inyanga Jubbah +1",hands="Inyan. Dastanas +2",ring1="Defending Ring",ring2="Shadow Ring",
		back="Moonbeam Cape",waist="Fucho-no-Obi",legs="Assiduity Pants +1",feet="Inyan. Crackows +1"}
	
	-- Defense sets

	sets.defense.PDT = {main="Terra's Staff", sub="Oneiros Grip", ammo="Homiliary",
		head="Inyanga Tiara +2", neck="Twilight Torque", ear1="Moonshade Earring", ear2="Infused Earring",
		body="Ayanmo Corazza +2", hands="Inyan. Dastanas +2", ring1="Defending Ring", ring2="Shadow Ring",
		back="Moonbeam Cape", waist="Fucho-no-Obi", legs="Assiduity Pants +1", feet="Inyan. Crackows +1"}

	sets.defense.MDT = {main="Terra's Staff", sub="Oneiros Grip", ammo="Homiliary",
		head="Inyanga Tiara +2", neck="Twilight Torque", ear1="Moonshade Earring", ear2="Infused Earring",
		body="Ayanmo Corazza +2", hands="Inyan. Dastanas +2", ring1="Defending Ring", ring2="Shadow Ring",
		back="Moonbeam Cape", waist="Fucho-no-Obi", legs="Assiduity Pants +1", feet="Inyan. Crackows +1"}

	sets.Kiting = {feet="Herald's Gaiters"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Basic set for if no TP weapon is defined.  
	-- ear1="Bladeborn Earring",ear2="Steelflash Earring", - ear1="Dudgeon Earring",ear2="Heartseeker Earring",
	sets.engaged = {ammo="Hasty Pinion +1",
		head="Ayanmo Zucchetto +1",neck="Clotharius Torque",ear1="Heartseeker Earring",ear2="Dudgeon Earring",
		body="Ayanmo Corazza +2",hands="Ayanmo Manopolas +1",ring1="Ilabrat Ring",ring2="Petrov Ring",
		back="Moonbeam Cape",waist="Windbuffet Belt +1",legs="Aya. Cosciales +2",feet="Ayanmo Gambieras +1"}
	sets.engaged.Acc = {ammo="Hasty Pinion +1",
		head="Blistering Sallet +1",neck="Subtlety Spectacles",ear1="Heartseeker Earring",ear2="Dudgeon Earring",
		body="Onca Suit",hands=empty,ring1="Cacoethic Ring",ring2="Petrov Ring",
		back="Moonbeam Cape",waist="Olseni Belt",legs=empty,feet=empty}
	sets.engaged.DW = {ammo="Hasty Pinion +1",
		head="Blistering Sallet +1",neck="Clotharius Torque",ear1="Heartseeker Earring",ear2="Dudgeon Earring",
		body="Onca Suit",hands=empty,ring1="Ilabrat Ring",ring2="Petrov Ring",
		back="Moonbeam Cape",waist="Windbuffet Belt +1",legs=empty,feet=empty}

	-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	sets.buff['Divine Caress'] = {hands="Ebers Mitts +1",back="Mending Cape"}

end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
