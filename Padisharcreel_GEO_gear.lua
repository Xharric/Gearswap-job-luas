-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('None', 'Normal')
	options.DefenseModes = {'Normal'}
	options.WeaponskillModes = {'Normal'}
	options.IdleModes = {'Normal', 'PDT'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'PDT'}
	options.MagicalDefenseModes = {'MDT'}

	-- state.Defense.PhysicalMode = 'PDT'

end

	include('organizer-lib')

--Augmented Gear--
		gear.MerlHatIdle = { name="Merlinic Hood", augments={'Attack+7','Crit. hit damage +2%','"Refresh"+2','Accuracy+12 Attack+12','Mag. Acc.+7 "Mag.Atk.Bns."+7'}}
		gear.MerlHatBurst = { name="Merlinic Hood", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic burst mdg.+9%','CHR+4','"Mag.Atk.Bns."+13'}}
	  
		gear.MerlFeetAspir = { name="Merlinic Crackows", augments={'Mag. Acc.+12','"Drain" and "Aspir" potency +10','CHR+3','"Mag.Atk.Bns."+1'}}
		gear.MerlFeetMAB = { name="Merlinic Crackows", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','CHR+7','Mag. Acc.+14','"Mag.Atk.Bns."+15'}}
		gear.MerlFeetBurst = { name="Merlinic Crackows", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst mdg.+9%','CHR+4','Mag. Acc.+13'}}

	lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
        'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II', 'Stonega', 'Waterga', 'Aeroga', 
		'Firaga', 'Blizzaga','Fira','Blizzara','Aerora','Stonera','Thundara','Watera'}	
		
-- Called when this job file is unloaded (eg: job change)
function file_unload()
	if binds_on_unload then
		binds_on_unload()
	end
end

 send_command('bind ^` input /ma Stun <t>; input /p Stun just went. Surma\s up next.')

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
		
	-- Precast sets to enhance JAs
	sets.precast.JA.Bolster = {body="Bagua Tunic"}
	sets.precast.JA['Life Cycle'] = {body="Geomancy Tunic +1", back="Nantosuelta's Cape"}
	sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals"}
	sets.precast.JA['Full Circle'] = {head="Azimuth Hood","Bagua Mitaines"}
	
	-- Fast cast sets for spells
	
	sets.precast.FC = {main="Solstice",sub="Culminus",Range="Dunna",
		head="Vanya Hood",neck="Voltsurge Torque",ear1="Etiolation Earring",ear2="Loquacious Earring",
		body="Helios Jacket",hands="Otomi Gloves",ring1="Lebeche Ring",
		back="Lifestream Cape",waist="Witful Belt",legs="Geomancy Pants +1",feet=gear.MerlFeetMAB}

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {sub="Genbu's Shield", body="Heka's Kalasiris",ear2="Mendicant's Earring"})
		
	sets.precast.FC['Impact'] = set_combine(sets.precast.FC, {body="Twilight Cloak"})
	
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS = {
		head="Blistering Sallet +1",neck="Fotia Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Onca Suit",hands=empty,ring1="Rajas Ring",ring2="Mars's Ring",
		back="Kayapa Cape",waist="Fotia Belt",legs=empty,feet=empty}
	
	sets.precast.WS['Flash Nova'] = {
		head="Jhakri Coronal +1",neck="Sanctity Necklace",ear1="Barkarole Earring",ear2="Friomisi Earring",
		body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Acumen Ring",ring2="Shiva Ring +1",
		back="Toro Cape",waist="Refoccilation Stone",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}
		
	sets.precast.WS['Resolution'] ={ring1="Trizek Ring",ring2="Capacity Ring"}	

	sets.precast.WS['Starlight'] = {ear2="Moonshade Earring"}

	sets.precast.WS['Moonlight'] = {ear2="Moonshade Earring"}
	
	-- Midcast Sets
	
	gear.default.obi_waist = "Eschan Stone"
	
	sets.midcast.FastRecast = set_combine(sets.precast.FC)
		
	sets.midcast.Geomancy = {main="Solstice",sub="Genbu's Shield",range="Dunna",
		head="Azimuth Hood",neck="Incanter's Torque",ear2="Gwati Earring",
		body="Bagua Tunic",hands="Geomancy Mitaines +1",ring2="Stikini Ring",
		back="Lifestream Cape",legs="Bagua Pants",feet="Azimuth Gaiters"}

	sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy, {back="Nantosuelta's Cape",legs="Bagua Pants",feet="Azimuth Gaiters"})
		
	sets.midcast.Cure = {main="Nibiru Cudgel",sub="Genbu's Shield",
		head="Vanya Hood",neck="Phalaina Locket",ear1="Mendicant's Earring",
		body="Heka's Kalasiris",hands="Telchine gloves",ring1="Lebeche Ring",}

	sets.midcast['Enfeebling Magic'] = {main="Grioavolr",sub="Enki Strap",ammo="Pemphredo Tathlum",
		head="Befouled Crown",neck="Incanter's Torque",ear1="Barkarole Earring",ear2="Gwati Earring",
		body="Merlinic Jubbah",hands="Jhakri Cuffs +1",ring1="Metamorph Ring +1",ring2="Sangoma Ring",
		back="Aurist's Cape +1",waist="Eschan Stone",legs="Psycloth Lappas",feet="Medium's Sabots"}
	
	sets.midcast['Enhancing Magic'] = {head="Befouled Crown",neck="Incanter's Torque",ear2="Andoaa Earring",waist="Olympus Sash",feet="Medium's Sabots"}
		
	sets.midcast['Impact'] = {main="Grioavolr",sub="Enki Strap",ammo="Hydrocera",
		head=empty,neck="Erra Pendant",ear1="Barkarole earring",ear2="Gwati earring",
		body="Twilight Cloak",hands="Jhakri Cuffs +1",ring1="Archon Ring",ring2="Sangoma Ring",
		back="Aurist's Cape +1",waist="Eschan Stone",legs="Merlinic Shalwar",feet=gear.MerlFeetMAB}
		
	sets.midcast.Stun = {ammo="Pemphredo Tathlum",
        head="Vanya Hood",neck="Voltsurge Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body="Helios Jacket",hands="Amalric Gages +1",ring1="Metamorph Ring +1",ring2="Sangoma Ring",
        back="Aurist's Cape +1",waist="Goading Belt",legs="Psycloth Lappas",feet=gear.MerlFeetMAB}
		
	sets.midcast['Dark Magic'] = {main="Grioavolr",sub="Enki Strap",ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Incanter's Torque",ear1="Barkarole Earring",ear2="Gwati Earring",
        body="Merlinic Jubbah",hands="Helios Gloves",ring1="Archon Ring",ring2="Evanescence Ring",
        back="Aurist's Cape +1",waist="Fucho-no-obi",legs="Merlinic Shalwar",feet=gear.MerlFeetAspir}

	--Elemental Magic--	

	
	sets.midcast['Elemental Magic'] = {ammo="Pemphredo Tathlum",
	  head=gear.MerlHatBurst,neck="Mizukage-no-Kubikazari", ear1="Barkarole Earring",ear2="Friomisi Earring",
	  body="Merlinic Jubbah",hands="Amalric Gages +1",ring1="Mujin Band",ring2="Shiva Ring +1",
	  back="Seshaw Cape",waist="Eschan Stone",legs="Merlinic Shalwar",feet=gear.MerlFeetBurst}

	  -- Sets to return to when not performing an action.
	

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

	sets.idle = {main="Bolelabunga",sub="Genbu's Shield",range="Dunna",
		head=gear.MerlHatIdle,neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Merman's Earring",
		body="Jhakri Robe +1",hands="Geomancy Mitaines +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Mecistopins Mantle",waist="Fucho-no-Obi",legs="Assiduity Pants +1",feet="Geomancy Sandals +1"}	
	
    sets.idle.Pet = {main="Sucellus",sub="Genbu's Shield",range="Dunna",
        head="Telchine cap",neck="Loricate Torque +1",ear1="Handler's Earring +1",ear2="Handler's Earring",
        body="Telchine Chasuble",hands="Geomancy Mitaines +1",ring1="Defending Ring",ring2="Dark Ring",
        back="Nantosuelta's Cape",waist="Isa Belt",legs="Telchine Braconi",feet="Telchine Pigaches"}

	-- sets.idle.PDT.Pet = set_combine(sets.idle.Pet, {})
		
	sets.idle.Weak = {main="Bolelabunga",sub="Genbu's Shield",range="Dunna",
		head="Befouled Crown",neck="Loricate Torque +1",ear1="Moonshade Earring",ear2="Infused Earring",
		body="Hagondes Coat +1",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Solemnity Cape",waist="Fucho-no-Obi",legs="Hagondes Pants +1",feet="Geomancy Sandals +1"}

	-- Defense sets

	sets.defense.PDT = set_combine (sets.idle.Pet)
	--- sets.defense.PDT = {main="Terra's Staff", sub="Oneiros Grip",range="Dunna",
	---	head="Befouled Crown",neck="Loricate Torque +1",ear1="Moonshade Earring",ear2="Infused Earring",
	---	body="Hagondes Coat +1",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2="Dark Ring",
	---	back="Solemnity Cape",waist="Fucho-no-Obi",legs="Hagondes Pants +1",feet="Geomancy Sandals +1"}
	
	sets.Kiting = {feet="Geomancy Sandals +1"}

	-- Engaged sets
	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- ear1="Bladeborn Earring",ear2="Steelflash Earring", - ear1="Dudgeon Earring",ear2="Heartseeker Earring",	
	-- neck="Clotharius Torque"  neck="Subtlety Spectacles"
	
	-- Normal melee group
	sets.engaged = {range="Dunna",
		head="Blistering Sallet +1",neck="Clotharius Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Onca Suit",hands=empty,ring1="Rajas Ring",ring2="Petrov Ring",
		back="Kayapa Cape",waist="Cetl Belt",legs=empty,feet=empty}
		
end




function select_default_macro_book()
    set_macro_page(1,4)
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------