-------------------------------------------------------------------------------------------------------------------
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

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant', 'Burst')
    state.IdleMode:options('Normal', 'PDT', 'Vag')
	
		gear.MerlHatIdle = { name="Merlinic Hood", augments={'Attack+7','Crit. hit damage +2%','"Refresh"+2','Accuracy+12 Attack+12','Mag. Acc.+7 "Mag.Atk.Bns."+7'}}
		gear.MerlHatBurst = { name="Merlinic Hood", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic burst dmg.+9%','CHR+4','"Mag.Atk.Bns."+13'}}
	  
		gear.MerlFeetAspir = { name="Merlinic Crackows", augments={'Mag. Acc.+12','"Drain" and "Aspir" potency +10','CHR+3','"Mag.Atk.Bns."+1'}}
		gear.MerlFeetMAB = { name="Merlinic Crackows", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','CHR+7','Mag. Acc.+14','"Mag.Atk.Bns."+15'}}
		gear.MerlFeetBurst = { name="Merlinic Crackows", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+9%','CHR+4','Mag. Acc.+13'}}
		
		gear.AspirHands = { name="Merlinic Dastanas", augments={'Mag. Acc.+30','"Drain" and "Aspir" potency +10',}}
		gear.TPHands = { name="Merlinic Dastanas", augments={'"Occult Acumen"+11','MND+5','Mag. Acc.+14','"Mag.Atk.Bns."+10',}}
	  
    lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
        'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II', 'Stonega', 'Waterga', 'Aeroga', 
		'Firaga', 'Blizzaga'}


   -- gear.macc_hagondes = {name="Hagondes Cuffs", augments={'Phys. dmg. taken -3%','Mag. Acc.+29'}}
    
    -- Additional local binds
    send_command('bind ^` input /ma Stun <t>; input /p Stun just went. Surma\s up next.')
    send_command('bind !` gs c toggle MagicBurst')

    select_default_macro_book(BLM)
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
	
	
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    ---- Precast Sets ----
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {}

    sets.precast.JA.Manafont = {}
    
    -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
    sets.precast.JA.Convert = {}


    -- Fast cast sets for spells

    sets.precast.FC = {ammo="Impatiens",
        head="Vanya Hood",neck="Voltsurge Torque",ear1="Etiolation Earring",ear2="Loquacious Earring",
		body="Helios Jacket", hands="Otomi Gloves", ring1="Lebeche Ring", ring2="Kishar Ring",
        back="Swith Cape",waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {head="Wicce Petasos",ear1="Barkarole Earring"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {back="Pahtli Cape"})

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    
	sets.precast.FC['Death'] = {ammo="Impatiens",
        head="Vanya Hood",neck="Voltsurge Torque",ear1="Etiolation Earring",ear2="Loquacious Earring",
		body="Helios Jacket", hands="Otomi Gloves", ring1="Lebeche Ring", ring2="Sangoma Ring",
        back="Bane Cape",waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}
    
	sets.precast.FC['Impact'] ={range="Impatiens",
        head=empty,neck="Voltsurge Torque",ear1="Barkarole Earring",ear2="Loquacious Earring",
        body="Twilight Cloak",hands="Otomi Gloves",ring1="Lebeche Ring",ring2="Kishar Ring",
        back="Swith Cape",waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}
	
	-- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Telchine Cap",neck="Fotia Gorget",ear1="Zennaroi Earring",ear2="Moonshade Earring",
        body="Onca Suit",ring1="Cacoethic Ring",ring2="Patricius Ring",
        back="Kayapa Cape",waist="Fotia Belt"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Myrkr'] = {ammo="Ghastly Tathlum +1",
        head="Vanya Hood",neck="Fotia Gorget",ear1="Gifted Earring",ear2="Moonshade Earring",
        body="Amalric Doublet",hands="Otomi Gloves",ring1="Mephitas's Ring",ring2="Sangoma Ring",
        back="Bane Cape",waist="Fotia Belt",legs="Amalric Slops",feet="Medium's Sabots"}
    
	--To ensure Organizer grabs some otherwise undefined gear.--
	sets.precast.WS['Drakesbane'] = {ring1="Warp Ring",ring2="Capacity Ring"}
    
    ---- Midcast Sets ----

    sets.midcast.FastRecast = {
        head="Vanya Hood",neck="Voltsurge Torque",ear1="Etiolation Earring",ear2="Loquacious Earring",
        body="Helios Jacket",hands="Otomi Gloves",ring1="Lebeche Ring",
        back="Swith Cape",waist="Goading Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}

    sets.midcast.Cure = {ammo="Ghastly Tathlum +1",
        head="Vanya Hood",neck="Phalaina Locket",ear1="Mendicant's Earring",ear2="Gwati Earring",	
        body="Telchine Chasuble",hands="Telchine Gloves",ring2="Metamorph Ring +1",ring1="Lebeche Ring",
        back="Aurist's Cape +1",legs="Psycloth Lappas",feet="Medium's Sabots"}

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast['Enhancing Magic'] = {
        head="Befouled Crown",
        body="Telchine Chasuble"}
    
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})

    sets.midcast['Enfeebling Magic'] = {ammo="Ghastly Tathlum +1",
        head="Befouled Crown",neck="Sanctity Necklace",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body="Amalric Doublet",hands="Amalric Gages +1",ring1="Metamorph Ring +1",ring2="Sangoma Ring",
        back="Aurist's Cape +1",waist="Eschan Stone",legs="Psycloth Lappas",feet="Medium's Sabots"}
        
    sets.midcast.ElementalEnfeeble = sets.midcast['Enfeebling Magic']

    sets.midcast['Dark Magic'] = {ammo="Pemphredo Tathlum",
        head=gear.MerlHatBurst,neck="Sanctity Necklace",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body="Amalric Doublet",hands="Amalric Gages +1",ring1="Metamorph Ring +1",ring2="Sangoma Ring",
        back="Bane Cape",waist="Eschan Stone",legs="Psycloth Lappas",feet="Medium's Sabots"}

    sets.midcast.Drain = {ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Voltsurge Torque",ear1="Barkarole Earring",ear2="Gwati Earring",
        body="Amalric Doublet",hands=gear.AspirHands,ring1="Evanescence Ring",ring2="Archon Ring",
        back="Bane Cape",waist="Fucho-no-obi",legs="Psycloth Lappas",feet=gear.MerlFeetAspir}
    
    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = {ammo="Pemphredo Tathlum",
        head="Vanya Hood",neck="Voltsurge Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body="Helios Jacket",hands="Amalric Gages +1",ring1="Metamorph Ring +1",ring2="Sangoma Ring",
        back="Bane Cape",waist="Goading Belt",legs="Psycloth Lappas",feet="Medium's Sabots"}
    
	sets.midcast['Death'] = {ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",neck="Mizukage-no-Kubikazari",ear1="Barkarole Earring",ear2="Etiolation Earring",
        body="Amalric Doublet",hands="Amalric Gages +1",ring1="Mujin Band",ring2="Archon Ring",
        back="Taranus's Cape",waist="Yamabuki-no-obi",legs="Amalric Slops",feet=gear.MerlFeetBurst}
	
	sets.midcast['Comet'] = {ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Mizukage-no-Kubikazari",ear1="Barkarole Earring",ear2="Friomisi Earring",
        body="Amalric Doublet",hands="Amalric Gages +1",ring1="Mujin Band",ring2="Archon Ring",
        back="Taranus's Cape",waist="Yamabuki-no-obi",legs="Merlinic Shalwar",feet=gear.MerlFeetBurst}
		
	sets.midcast['Impact'] = {ammo="Seraphic Ampulla",
		head=empty, neck="Lissome Necklace", ear1="Telos Earring", ear2="Tripudio Earring",
		body="Twilight Cloak", hands=gear.TPHands, ring1="Petrov Ring", ring2="Rajas Ring",
		back="Taranus's Cape", waist="Goading Belt", legs="Perdition Slops", feet="Helios Boots"}
	
	
	
	sets.midcast['Quake'] = {ammo="Seraphic Ampulla",
		head="Welkin Crown", neck="Lissome Necklace", ear1="Telos Earring", ear2="Tripudio Earring",
		body="Spae. Coat +1", hands=gear.TPHands, ring1="Petrov Ring", ring2="Rajas Ring",
		back="Taranus's Cape", waist="Goading Belt", legs="Perdition Slops", feet="Helios Boots"}
		
   -- sets.midcast.BardSong = {main="Lehbrailg +2",sub="Mephitis Grip",ammo="Sturm's Report",
     --   head="Nahtirah Hat",neck="Weike Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
       -- body="Helios Jacket",hands="Yaoyotl Gloves",ring1="Strendu Ring",ring2="Sangoma Ring",
        --back="Aurist's Cape +1",legs="Bokwus Slops",feet="Bokwus Boots"}


    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {ammo="Ghastly Tathlum +1",
        head="Buremte Hat",neck="Sanctity Necklace",ear1="Crematio Earring",ear2="Friomisi Earring",
        body="Amalric Doublet",hands="Amalric Gages +1",ring1="Shiva Ring +1",ring2="Fenrir Ring +1",
        back="Taranus's Cape",waist="Sekhmet Corset",legs="Merlinic Shalwar",feet="Umbani Boots"}

    sets.midcast['Elemental Magic'].Resistant = {ammo="Ghastly Tathlum +1",
        head=gear.MerlHatBurst,neck="Sanctity Necklace",ear1="Crematio Earring",ear2="Friomisi Earring",
        body="Merlinic Jubbah",hands="Amalric Gages +1",ring1="Metamorph Ring +1",ring2="Fenrir Ring +1",
        back="Taranus's Cape",waist="Sekhmet Corset",legs="Merlinic Shalwar",feet=gear.MerlFeetMAB}

    sets.midcast.HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {ammo="Pemphredo Tathlum",
	head=gear.MerlHatBurst,ear1="Barkarole Earring",
	body="Spaekona's Coat +1",hands= "Amalric Gages +1",
	waist="Refoccilation Stone",feet=gear.MerlFeetMAB})
	
    sets.midcast.HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'], {ammo="Pemphredo Tathlum",
	body="Spaekona's Coat +1",
	hands="Amalric Gages +1",ring2="Metamorph Ring +1",
	back="Taranus's Cape",waist="Eschan Stone"})
	
	
	--Magic Burst Set
	
    sets.midcast['Elemental Magic'].Burst = {ammo="Ghastly Tathlum +1",
	  head=gear.MerlHatBurst,neck="Mizukage-no-Kubikazari", ear1="Barkarole Earring",ear2="Friomisi Earring",
	  body="Amalric Doublet",hands="Amalric Gages +1",ring1="Mujin Band",ring2="Shiva Ring +1",
	  back="Taranus's Cape",waist="Eschan Stone",legs="Merlinic Shalwar",feet=gear.MerlFeetBurst}

    sets.midcast.HighTierNuke.Burst = {ammo="Pemphredo Tathlum",
	  head=gear.MerlHatBurst,neck="Mizukage-no-Kubikazari", ear1="Barkarole Earring",ear2="Friomisi Earring",
	  body="Merlinic Jubbah",hands="Amalric Gages +1",ring1="Mujin Band",ring2="Shiva Ring +1",
	  back="Taranus's Cape",waist="Refoccilation Stone",legs="Merlinic Shalwar",feet=gear.MerlFeetBurst}
    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    --sets.resting = {main="Chatoyant Staff",ammo="Clarus Stone",
      --  head="Nefer Khat +1",neck="Grandiose Chain",
        --body="Heka's Kalasiris",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        --waist="Austerity Belt",legs="Nares Trews",feet="Serpentes Sabots"}
    

    -- Idle sets
    
    -- Normal refresh idle set
    sets.idle = {ammo="Ghastly Tathlum +1",
        head=gear.MerlHatIdle,neck="Bathy Choker +1",ear1="Loquacious Earring",ear2="Etiolation Earring",
        body="Amalric Doublet",hands="Otomi Gloves",ring1="Metamorph Ring +1",ring2="Sangoma Ring",
        back="Bane Cape",waist="Fucho-no-obi",legs="Assiduity Pants +1",feet="Serpentes Sabots"}

	sets.idle.Town = set_combine(sets.idle, {main="Lathi",sub="Niobid Strap",
	body="Councilor's Garb",back="Solemnity Cape",ring2="Trizek Ring"})	
		
    sets.idle.PDT = sets.precast.WS['Myrkr']
	
	sets.idle.Vag = {ammo="Ghastly Tathlum +1",
	  head=gear.MerlHatBurst,neck="Sanctity Necklace", ear1="Barkarole Earring",ear2="Friomisi Earring",
	  body="Amalric Doublet",hands="Amalric Gages +1",ring1="Mujin Band",ring2="Shiva Ring +1",
	  back="Taranus's Cape",waist="Eschan Stone",legs="Merlinic Shalwar",feet=gear.MerlFeetBurst}

    -- Defense sets


    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    
    sets.buff['Mana Wall'] = {feet="Wicce Sabots +1", back="Taranus's Cape"}

    --sets.magic_burst = {ammo="Ghastly Tathlum +1",
      --  head="Helios Band",neck="Sanctity Necklace",ear1="Crematio Earring",ear2="Friomisi Earring",
        --body="Amalric Doublet",hands="Helios Gloves",ring1="Shiva Ring +1",ring2="Fenrir Ring +1",
        --back="Toro Cape",waist="Eschan Stone",legs="Merlinic Shalwar",feet="Merlinic Crackows"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
   -- sets.engaged = {
     --   head="Telchine Cap",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
       -- body="Onca Suit",ring1="Rajas Ring",ring2="Petrov Ring",
        --back="Kayapa Cape",waist="Goading Belt"}
		
	 sets.engaged = {
        head="Hike Khat +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Loquacious Earring",
        body="Hagondes Coat +1",ring1="Defending Ring",ring2="Dark Ring",
        back="Taranus's Cape",waist="Yamabuki-no-obi",legs="Miasmic Pants",feet="Wicce Sabots +1"}	
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
--function job_precast(spell, action, spellMap, eventArgs)
  --  if spellMap == 'Cure' or spellMap == 'Curaga' then
    --    gear.default.obi_waist = "Goading Belt"
    --elseif spell.skill == 'Elemental Magic' then
      --  gear.default.obi_waist = "Sekhmet Corset"
        --if state.CastingMode.value == 'Proc' then
           -- classes.CustomClass = 'Proc'
        --end
    --end
--end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.

--function job_post_midcast(spell, action, spellMap, eventArgs)
  --  if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
    --    equip(sets.magic_burst)
    --end
--end

--function job_aftercast(spell, action, spellMap, eventArgs)
    -- Lock feet after using Mana Wall.
  --  if not spell.interrupted then
    --    if spell.english == 'Mana Wall' then
      --      enable('feet')
        --    equip(sets.buff['Mana Wall'])
  --          disable('feet')
        --elseif spell.skill == 'Elemental Magic' then
          --  state.CastingMode:reset()
        --end
    --end
--end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- Unlock feet when Mana Wall buff is lost.
    if buff == "Mana Wall" and not gain then
        enable('feet')
        handle_equipping_gear(player.status)
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
    
        if lowTierNukes:contains(spell.english) then
            return 'LowTierNuke'
        else
            return 'HighTierNuke'
        end
        
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1,9)
end