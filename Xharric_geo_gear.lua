-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()  
    gear.GeoBell = "Dunna"
   
    gear.AugLifestreamIndi = {name="Lifestream Cape",augments={'Geomancy Skill +8','Ind. eff. dur. +20','Damage taken -2%','Pet: Damage taken -5%'}}
    gear.default.obi_back = "Nantosuelta's Cape"
   
    state.OffenseMode:options('None', 'Normal', 'Acc')
    --state.OffenseMode:options('None')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('CP', 'Normal', 'PDT', 'MDT', 'MDTOnca', 'CPPDT', 'CPMDT')
  state.WeaponskillMode:options('Normal', 'Acc')
 
  state.MagicBurst = M(false, 'Magic Burst')
 
  LowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
        'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
        'Stonera', 'Watera', 'Aerora', 'Fira', 'Blizzara', 'Thundara',
        'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',
        'Stonega II', 'Waterga II', 'Aeroga II', 'Firaga II', 'Blizzaga II', 'Thundaga II'}
   
    send_command('bind !f9 gs c cycle CastingMode')
    send_command('bind @f9 gs c cycle DefenseMode')
    send_command('bind @` gs c cycle MagicBurst')
 
    -- Default macro set/book
    set_macro_page(1, 13)
end
 
-- Called when this job file is unloaded (eg: job change)
function user_unload()
  send_command('unbind !f9')
  send_command('unbind @f9')
  send_command('unbind @`')
end
 
-- Define sets and vars used by this job file.
function init_gear_sets()
 
    --------------------------------------
    -- Precast sets
    --------------------------------------
   
    -- Precast sets to enhance JAs
    sets.precast.JA.Bolster = {body="Bagua Tunic +1"}
    sets.precast.JA['Life cycle'] = {
        body="Geo. Tunic +1",
        back="Toro Cape",
    }
    sets.precast.JA['Primeaval Zeal'] = {head="Bagua Galero +1"}
    -- AF2 hands enhances Curative Recantation
    sets.precast.JA['Full Circle'] = {head="Azimuth Hood +1",hands="Bagua Mitaines +1"}
    sets.precast.JA['Mending Halation'] = {legs="Bagua Pants +1"}
    sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals +1"}
   
    -- Fast cast sets for spells
    -- 56%/28% Total (80/40 cap) + 15% (if RDM sub)
    sets.precast.FC = {
        -- 3%
        main=gear.FastcastStaff,
        --sub="Niobid Strap",
        --ammo="Impatiens",
        -- 10%
        head="Nahtirah Hat",
        -- 4%
        neck="Baetyl Pendant",
        -- 1%
        ear1="Etiolation Earring",
        -- 2%
        ear2="Loquacious Earring",
        -- 8%
        body="Vanir Cotehardie",
        -- 2%
        ring1="Prolix Ring",
        -- 7%
        back="Lifestream Cape",
        -- 3%
        waist="Witful Belt",
        -- 11%
        legs="Geo. Pants +1",
        -- 4% + 1%~3%
        feet="Regal Pumps +1"
    }
   
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        back="Pahtli Cape",
        hands=gear.Vanya_hands_B,
        feet=gear.Vanya_feet_B
    })
   
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        waist="Siegel Sash"
    })
   
    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {
        head="Umuthi Hat",
        hands="Carapacho Cuffs"
    })
   
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
        neck="Stoicheion Medal",
        hands="Bagua Mitaines +1"
    })
   
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {
    head=empty,
    body="Twilight Cloak"
  })
   
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Merlinic Hood",
        neck="Fotia Gorget",
        ear1="Brutal Earring",
        ear2="Moonshade Earring",
        body="Amalric Doublet",
        hands="Geo. Mitaines +1",
        ring1="Rajas Ring",
        ring2="Petrov Ring",
        back="Aurist's Cape +1",
        waist="Fotia Belt",
        legs="Bagua Pants +1",
        feet="Medium's Sabots"
    }
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
    ear1="Zennaroi Earring",
    ring1="Cacoethic Ring +1",
    ring2="Ramuh Ring +1",
    waist="Eschan Stone"
    })
   
    sets.precast.WS.MAB = set_combine(sets.precast.WS,{
        head="Merlinic Hood",
        --neck="Sanctity Necklace",
        ear1="Crematio Earring",
        ear2="Friomisi Earring",
        body="Amalric Doublet",
        hands="Amalric Gages",
        ring1="Acumen Ring",
        ring2="Strendu Ring",
        back="Toro Cape",
        --waist="Yamabuki-no-Obi",
        legs="Jhakri Slops +1",
        feet="Jhakri Pigaches +1"
    })
   
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
   
    sets.precast.WS['Hexa Strike'] = set_combine(sets.precast.WS,{
    })
    sets.precast.WS['Retribution'] = set_combine(sets.precast.WS,{
    })
   
    -- Magical WS
   
    sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS.MAB,{
    })
    sets.precast.WS['Spirit Taker'] = set_combine(sets.precast.WS.MAB, {
    })
    sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS.MAB, {
    })
   
    --------------------------------------
    -- Midcast sets
    --------------------------------------
   
    -- Base fast recast for spells
    sets.midcast.FastRecast = set_combine(sets.precast.FC, {
        head="Geo. Galero +1",
        neck="Baetyl Pendant",
        ear1="Gifted Earring",
        ear2="Loquacious Earring",
        body="Vanir Cotehardie",
        hands="Geo. Mitaines +1",
        back="Lifestream Cape",
        waist="Ninurta's Sash",
        legs="Geo. Pants +1",
        feet="Regal Pumps +1"
    })
   
    sets.midcast.MACC = {
        main=gear.MaccStaff,
        sub="Niobid Strap",
        range=gear.GeoBell,
        head="Befouled Crown",
        neck="Incanter's Torque",
        ear1="Psystorm Earring",
        ear2="Lifestorm Earring",
        body="Azimuth Coat",
        hands="Lurid Mitts",
        ring1="Sangoma Ring",
        ring2="Strendu Ring",
        back="Toro Cape",
        waist="Eschan Stone",
        legs="Jhakri Slops +1",
        feet="Jhakri Pigaches +1"
    }
   
    sets.midcast.MAB = {
        --main=gear.MainStaff,
        --sub="Niobid Strap",
        main="Solstice",
        sub="Ammurapi Shield",
        head="Pemphredo Tathlum",
        head="Merlinic Hood",
        neck="Sanctity Necklace",
        ear1="Crematio Earring",
        ear2="Regal Earring",
        body="Merlinic Jubbah",
        hands="Amalric Gages",
        ring1="Acumen Ring",
        ring2="Strendu Ring",
        back=gear.ElementalCape,
        waist=gear.ElementalObi,
        legs="Merlinic Shalwar",
        feet="Merlinic crackows"
    }
   
    sets.midcast.ConserveMP = set_combine(sets.midcast.FastRecast,{
        main="Solstice",
        sub="Genmei Shield",
        neck="Reti Pendant",
        ear1="Gifted Earring",
        back="Aurist's Cape +1",
        waist="Austerity Belt",
        feet="Medium's Sabots"
    })
   
    -- 850 base with gifts (900 to cap all spell potency)
    sets.midcast.Geomancy = set_combine(sets.midcast.ConserveMP,{
        main="Solstice",
        neck="Incanter's Torque",
        sub="Genbu's Shield",
        -- 18
        range=gear.GeoBell,
        -- 15
        head="Azimuth Hood +1",
        -- 5
        neck="Reti Pendant",
        -- 12
        body="Bagua Tunic +1",
        -- 15
        hands="Geo. Mitaines +1",
        -- 5 + 8
        back="Lifestream Cape",
        feet="Medium's Sabots"
    })
    sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy,{
        main="Solstice",
        sub="Genbu's Shield",
        back="Lifestream Cape",
        legs="Bagua Pants +1",
        feet="Azimuth Gaiters +1"
    })
   
    sets.midcast['Healing Magic'] = {
        main="Divinity",
        sub="Genbu's Shield",
        head="Hyksos Khat",
        neck="Incanter's Torque",
        body=gear.Vanya_body_B,
        hands=gear.Vanya_hands_B,
        ring1="Sirona's Ring",
        ring2="Ephedra Ring",
        back="Altruistic Cape",
        feet=gear.Vanya_feet_B
    }
   
    -- 59% Total
    sets.midcast.Cure = set_combine(sets.midcast['Healing Magic'],{
        -- 15%
        main="Divinity",
        sub="Genbu's Shield",
        head="Befouled Crown",
        neck="Incanter's Torque",
        ear1="Novia Earring",
        ear2="Lifestorm Earring",
        -- 13%
        body="Vrikodara Jupon",
        -- 16%
        hands="Telchine Gloves",
        -- 10%
        legs="Gyve Trousers",
        -- 5%
        feet=gear.Vanya_feet_B
    });
           
    sets.midcast.Curaga = set_combine(sets.midcast.Cure,{
        body="Vrikodara Jupon"
    })
   
    sets.midcast.Cursna = set_combine(sets.midcast['Healing Magic'],{
        neck="Malison Medallion",
        ring1="Ephedra Ring",
        ring2="Ephedra Ring",
        feet=gear.Vanya_feet_B
    })
   
    sets.midcast['Enhancing Magic'] = {
        main="Serenity",
        head="Befouled Crown",
        neck="Incanter's Torque",
        ear2="Andoaa Earring",
        body="Telchine Chas.",
        hands="Ayao's Gages",
        back="Fi Follet Cape",
        waist="Witful Belt",
        legs="Geo. Pants +1",
        feet="Regal Pumps +1"      
    }
   
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'],{
        neck="Nodens Gorget",
        ear1="Earthcry Earring",
        waist="Siegel Sash",
        legs="Haven Hose"
    })
   
    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'],{
        main="Bolelabunga",
        sub="Genbu's Shield",
        body="Telchine Chas."
    })
   
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'],{
        feet="Inspirited Boots"
    })
   
    sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'],{
        ring1="Sheltered Ring"
    })
 
    sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'],{
        ring1="Sheltered Ring"
    })
   
    sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.MACC,{
        sub="Mephitis Grip",
        head="Befouled Crown",
        neck="Incanter's Torque",
        body="Vanya Robe",
        hands="Lurid Mitts",
        back="Lifestream Cape",
        waist="Rumination Sash",
        legs="Psycloth Lappas",
        feet="Medium's Sabots"
    })
   
    sets.midcast['Elemental Magic'] = set_combine(sets.midcast.MAB,{
        --head="Geo. Galero +1",
        head="Merlinic Hood",
        hands="Amalric Gages",
        --ring2="Resonance Ring",
    })
   
    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'],{
        head="Merlinic Hood",
        body="Jhakri Robe +2",
        ring1="Sangoma Ring",
        ring2="Resonance Ring",
        legs="Jhakri Slops +1",
        feet="Jhakri Pigaches +1"
    })
   
    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {
        main="Solstice",
        sub="Ammurapi Shield",
        head="Merlinic Hood",
    })
    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {
        main="Solstice",
        sub="Ammurapi Shield",
        head="Merlinic Hood",
    })
   
    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})
   
    sets.midcast['Divine Magic'] = set_combine(sets.midcast.MAB,{
    })
   
    sets.midcast.Repose = set_combine(sets.midcast.FastRecast,{
    })
   
    sets.midcast['Dark Magic'] = set_combine(sets.midcast.MACC,{
        main="Rubicundity",
        sub="Ammurapi Shield",
        neck="Erra Pendant",
        body="Vanir Cotehardie",
        legs="Azimuth Tights +1"
    })
   
    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
        main=gear.MaccStaff,
        sub="Mephitis Grip",
		neck="Incanter's Torque"
    })
   
    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        main="Rubicundity",
        sub="Ammurapi Shield",
        head="Bagua Galero +1",
        waist="Fucho-no-Obi",
        feet="Jhakri Pigaches +1"
    })
   
    sets.midcast.Aspir = sets.midcast.Drain
 
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
 
  -- Resting sets
    sets.resting = set_combine(sets.sharedResting,{
    })
 
    -- Idle sets
    sets.idle = {
        main="Solstice",
        sub="Ammurapi Shield",               
        range=gear.GeoBell,
        head="Befouled Crown",
        neck="Loricate Torque +1",
        ear1="Sanare Earring",
        ear2="Loquac. Earring",
        body="Jhakri Robe +2",
        hands="Bagua Mitaines +1",
        ring1="Sheltered Ring",
        ring2="Defending Ring",
        back="Moonbeam Cape",
        waist="Fucho-no-Obi",
        legs="Lengo Pants",
        feet="Geo. Sandals +1"
    }
       
    -- Total: 27% + 20% (PDT Staff)
    -- <36%: use Shadow Mantle
    sets.idle.PDT = set_combine(sets.idle,{
        main=gear.Staff.PDT,
        sub="Niobid Strap",
        head="Merlinic Hood",
        -- 5%
        neck="Loricate Torque +1",
        -- 3%
        body="Vrikodara Jupon",
        -- 1%
        hands="Geo. Mitaines +1",
        -- 5%
        ring1="Dark Ring",
        -- 10%
        ring2="Defending Ring",
        -- 4%
        back="Solemnity Cape",
        legs="Gyve Trousers",
        --feet="Azimuth Gaiters"
        feet=gear.Vanya_feet_B
    })
           
    -- MDT: 31%
    -- MDB: 25
    -- To cap: Shellra5: 23%, Shell5: 26%, Shell4: 29%
    sets.idle.MDT = set_combine(sets.idle,{
        -- 5
        head="Merlinic Hood",
        -- 5%
        neck="Loricate Torque +1",
        -- 3%
        ear1="Etiolation Earring",
        -- 6 1% DT 3%
        body=gear.Vanya_body_B,
        -- 3
        hands="Geo. Mitaines +1",
        ring1="Shadow Ring",
        -- 10%
        ring2="Defending Ring",
        -- 4%
        back="Solemnity Cape",
        -- 2% 6
        legs="Gyve Trousers",
        -- 3% 5
        feet=gear.Vanya_feet_B
    })
   
    sets.idle.MDTOnca = {
        -- 5
        head="Merlinic Hood",
        -- 5%
        neck="Loricate Torque +1",
        -- 3%
        ear1="Etiolation Earring",
        ear2="Dominance Earring",
        -- 12
        body="Onca Suit",
        hands=empty,
        -- 6
        back="Tuilha Cape",
        legs=empty,
        feet=empty
    }
   
    sets.idle.CP = set_combine(sets.idle,{
    })
   
    sets.idle.CPPDT = set_combine(sets.idle.PDT,{
    })
   
    sets.idle.CPMDT = set_combine(sets.idle.MDT,{
    })
   
    sets.idle.Town = set_combine(sets.idle,{
        body="Councilor's Garb",
        feet="Geo. Sandals +1"
    })
   
    sets.idle.Weak = set_combine(sets.idle,{
    })
   
    sets.idle.Regen = set_combine(sets.idle,{
        neck="Bathy Choker +1",
        ring1="Sheltered Ring"
    })
 
    -- .Pet sets are for when Luopan is present.
    sets.idle.Pet = set_combine(sets.idle,{
        hands="Geo. Mitaines +1",
        back="Lifestream Cape",
        feet="Bagua Sandals +1"
    })
   
    sets.idle.PDT.Pet = set_combine(sets.idle,PDT,{
        hands="Geo. Mitaines +1",
        back="Lifestream Cape",
        feet="Bagua Sandals +1"
    })
 
  -- .Indi sets are for when an Indi-spell is active.
  sets.idle.Indi = set_combine(sets.idle, {
    --back="Lifestream Cape",
    --legs="Bagua Pants +1",
    --feet="Azimuth Gaiters +1"
  })
  sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {
    head="Azimuth Hood +1",
    back="Lifestream Cape",
    --legs="Bagua Pants +1"
  })
  sets.idle.PDT.Indi = set_combine(sets.idle.PDT, {
    back="Lifestream Cape",
    --legs="Bagua Pants +1",
    feet="Azimuth Gaiters +1"
  })
  sets.idle.PDT.Pet.Indi = set_combine(sets.idle.PDT.Pet, {
    back="Lifestream Cape",
    --legs="Bagua Pants +1"
  })
 
    -- Defense sets
 
    sets.defense.PDT = set_combine(sets.idle.PDT,{
        back="Solemnity Cape"
    })
   
    sets.defense.MDT = set_combine(sets.idle.MDT,{
        back="Solemnity Cape"
    })
 
    sets.Kiting = {feet="Geo. Sandals +1"}
   
    sets.latent_refresh = {waist="Fucho-no-obi"}
 
  --------------------------------------
  -- Engaged sets
  --------------------------------------
 
  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.
  -- If you create a set with both offense and defense modes, the offense mode should be first.
  -- EG: sets.engaged.Dagger.Accuracy.Evasion
 
    -- Normal melee group
    sets.engaged = {
        head="Blistering Sallet +1",
        neck="Asperity Necklace",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        body="Onca Suit",
        hands=empty,
        ring1="Rajas Ring",
        ring2="Petrov Ring",
        back="Buquwik Cape",
        waist="Ninurta's Sash",
        legs=empty,
        feet=empty
    }
   
    sets.engaged.Acc = set_combine(sets.engaged, {
        neck="Subtlety Spec.",
        ring1="Cacoethic Ring +1",
        ring2="Ramuh Ring +1",
        back="Aurist's Cape +1",
        waist="Eschan Stone"
    })
 
    --------------------------------------
    -- Custom buff sets
    --------------------------------------
   
    sets.magic_burst = {
        head=gear.Merlinic_head_burst,
        neck="Mizu. Kubikazari",
        body="Amalric Doublet",
        hands="Amalric Gages",
        ring1="Mujin Band",
        --ring2="Locus Ring",
        feet="Jhakri Pigaches +1"
    }
 
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
 
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if (newValue == 'Normal' or newValue == 'Acc') then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end
 
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Geomancy' then
            if spell.english:startswith('Indi') then
                return 'Indi'
            end
        elseif spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
            if LowTierNukes:contains(spell.english) then
                return 'LowTierNuke'
            else
                return 'HighTierNuke'
            end
            end
    end
end
 
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
        equip(sets.magic_burst)
    end
end