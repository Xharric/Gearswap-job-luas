-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
  state.OffenseMode:options('None', 'Normal')
  state.CastingMode:options('Normal', 'Resistant')
  state.IdleMode:options('CP', 'Normal', 'PDT', 'MDT', 'MDTOnca', 'CPPDT', 'CPMDT')
 
  -- Default macro set/book
    set_macro_page(1, 2)
end
 
-- Define sets and vars used by this job file.
function init_gear_sets()
  --------------------------------------
  -- Start defining the sets
  --------------------------------------
 
  -- Precast Sets
 
  -- Fast cast sets for spells
 
  -- 48%/24% Total (80/40 cap) + 15% (if RDM sub)
  sets.precast.FC = {
    -- 3%
    main=gear.FastcastStaff,
    --sub="Mephitis Grip",
    ammo="Impatiens",
    -- 10%
    head="Nahtirah Hat",
    -- 5%
    neck="Orison Locket",
    -- 2%
    ear1="Loquacious Earring",
    -- 1%
        ear2="Etiolation Earring",
        -- 5%
    body="Vrikodara Jupon",
    -- 7%
    hands="Fanatic Gloves",
    -- 3%
    back="Swith Cape",
    -- 3%
    waist="Witful Belt",
    -- 5%
    legs="Lengo Pants",
    -- 4% + 1%~3%
    feet="Regal Pumps +1"
  }
 
  sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {
    legs="Ebers Pant. +1"
  })
 
  sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {
    main="Queller Rod",
    sub="Genbu's Shield",
    head="Theo. Cap +1",
    ear2="Nourish. Earring",
    back="Pahtli Cape",
    legs="Ebers Pant. +1",
    feet="Vanya Clogs"
  })
 
  sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']
 
  sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
    waist="Siegel Sash"
  })
 
  sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {
    head="Umuthi Hat"
  })
 
  sets.precast.FC.Impact = set_combine(sets.precast.FC, {
    head=empty,
    body="Twilight Cloak"
  })
 
  sets.precast.FC.Curaga = sets.precast.FC.Cure
  sets.precast.FC.CureSolace = sets.precast.FC.Cure
  -- CureMelee spell map should default back to Healing Magic.
 
  -- Precast sets to enhance JAs
  sets.precast.JA.Benediction = {
    body="Piety Briault +1"
  }
 
  -- Waltz set (chr and vit)
  sets.precast.Waltz = {
    head="Theo. Cap +1",
    ear1="Roundel Earring",
    body="Vrikodara Jupon",
    hands="Dynasty Mitts",
    legs="Gyve Trousers",
    feet="Helios Boots"
  }
 
  -- Weaponskill sets
 
  -- Default set for any weaponskill that isn't any more specifically defined
  gear.default.weaponskill_neck = "Fotia Gorget"
  gear.default.weaponskill_waist = "Fotia Belt"
  sets.precast.WS = {
    head="Buremte Hat",
    neck=gear.default.weaponskill_neck,
    ear1="Brutal Earring",
    ear2="Moonshade Earring",
    body="Vrikodara Jupon",
    hands="Dynasty Mitts",
    ring1="Rajas Ring",
    ring2="K'ayres Ring",
    back="Aurist's Cape +1",
    waist=gear.default.weaponskill_waist,
    legs="Telchine Braconi",
    feet="Medium's Sabots"
  }
  sets.precast.WS.MAB = set_combine(sets.precast.WS,{
    --neck="Sanctity Necklace",
    ear1="Crematio Earring",
    ear2="Friomisi Earring",
    body="Count's Garb",
    hands="Helios Gloves",
    ring1="Acumen Ring",
    ring2="Strendu Ring",
    back="Toro Cape",
    --waist="Yamabuki-no-Obi",
    legs="Chironic Hose",
    feet="Helios Boots"
  })
 
  sets.precast.WS['Hexa Strike'] = set_combine(sets.precast.WS,{
  })
  sets.precast.WS['Realmrazer'] = set_combine(sets.precast.WS,{
  })
 
  sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS.MAB,{
  })
  sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS.MAB,{
  })
 
  -- Midcast Sets
 
  sets.midcast.FastRecast = {
    head="Nahtirah Hat",
    neck="Orison Locket",
    ear1="Loquacious Earring",
    ear2="Etiolation Earring",
    ear2="Gifted Earring",
    body="Vrikodara Jupon",
    hands="Fanatic Gloves",
    ring1="Prolix Ring",
    ring2="Defending Ring",
    back="Swith Cape",
    waist="Cetl Belt",
    legs="Theo. Pant. +1",
    feet="Regal Pumps +1"
  }
   
  sets.midcast.MACC = {
    main=gear.MaccStaff,
    sub="Mephitis Grip",
    range="Aureole",
    head="Befouled Crown",
    neck="Sanctity Necklace",
    ear1="Psystorm Earring",
    ear2="Lifestorm Earring",
    body="Vanya Robe",
    hands="Lurid Mitts",
    ring1="Sangoma Ring",
    ring2="Strendu Ring",
    back="Aurist's Cape +1",
    waist="Eschan Stone",
    legs="Chironic Hose",
    feet="Medium's Sabots"
  }
 
  sets.midcast.MAB = {
    --main=gear.MainStaff,
    --sub="Niobid Strap",
    main="Rubicundity",
        sub="Culminus",
    ammo="Ombre Tathlum +1",
    head="Buremte Hat",
    neck="Sanctity Necklace",
    ear1="Crematio Earring",
    ear2="Friomisi Earring",
    body="Count's Garb",
    hands="Helios Gloves",
    ring1="Acumen Ring",
    ring2="Strendu Ring",
    back=gear.ElementalCape,
        waist=gear.ElementalObi,
    legs="Chironic Hose",
    feet="Helios Boots"
  }
   
  -- Cure sets
  gear.default.obi_waist = "Cleric's Belt"
  gear.default.obi_back = "Mending Cape"
   
  sets.midcast['Healing Magic'] = {
    main="Divinity",
    sub="Genbu's Shield",
    head="Hyksos Khat",
    neck="Colossus's Torque",
    body="Ebers Bliaud +1",
    hands="Fanatic Gloves",
    ring1="Sirona's Ring",
    ring2="Ephedra Ring",
    back="Mending Cape",
    waist="Cleric's Belt",
    legs="Piety Pantaln. +1",
    feet="Vanya clogs"
  }
 
  -- 53% + 2% II Total
  sets.midcast.Cure = set_combine(sets.midcast['Healing Magic'],{
    -- 10% 2% II
    main="Queller Rod",
    sub="Genbu's Shield",
    -- 13%
    head="Ebers Cap",
    neck="Colossus's Torque",
    -- 5%
    -- neck="Nodens Gorget",
    ear1="Lifestorm Earring",
    -- 2%
    ear2="Nourish. Earring",
    body="Ebers Bliaud +1",
    -- 16%
    hands="Telchine Gloves",
    -- 7%
    back="Solemnity Cape",
    waist=gear.ElementalObi,
    legs="Ebers Pant. +1",
    -- 5%
    feet="Vanya clogs"
  })
 
  sets.midcast.CureSolace = set_combine(sets.midcast.Cure,{
  })
 
  sets.midcast.Curaga = set_combine(sets.midcast.Cure,{
    head="Hyksos Khat",
    body="Vrikodara Jupon"
  })
 
  sets.midcast.CureMelee = set_combine(sets.midcast.Cure,{
  })
 
  sets.midcast.Cursna = set_combine(sets.midcast['Healing Magic'],{
    neck="Malison Medallion",
    hands="Fanatic Gloves",
    ring1="Ephedra Ring",
    ring2="Ephedra Ring",
    back="Mending Cape",
    legs="Theo. Pant. +1",
    feet="Vanya clogs"
  })
 
  sets.midcast.StatusRemoval = set_combine(sets.midcast['Healing Magic'],{
    head="Ebers Cap",
    legs="Ebers Pant. +1"
  })
       
  sets.midcast['Enhancing Magic'] = {
    main="Serenity",
    head="Befouled Crown",
    neck="Colossus's Torque",
    ear2="Andoaa Earring",
    body="Telchine Chas.",
    hands="Dynasty Mitts",
    back="Mending Cape",
    waist="Siegel Sash",
    legs="Piety Pantaln. +1",
    feet="Ebers Duckbills"
  }
 
  sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'],{
    neck="Nodens Gorget",
    ear1="Earthcry Earring",
    hands="Carapacho Cuffs",
    waist="Siegel Sash",
    legs="Haven Hose"
  })
 
  sets.midcast.Auspice = {
    hands="Dynasty Mitts",
    feet="Ebers Duckbills"
  }
 
  sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'],{
    head="Ebers Cap",
    body="Ebers Bliaud +1",
    hands="Ebers Mitts",
    legs="Piety Pantaln. +1",
    feet="Ebers Duckbills"
  })
       
  sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'],{
    main="Bolelabunga",
    sub="Genbu's Shield",
    body="Piety Briault +1",
    hands="Ebers Mitts",
    legs="Theo. Pant. +1"
  })
 
  sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'],{
    ring1="Sheltered Ring",
    feet="Piety Duckbills +1"
  })
 
  sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'],{
    ring1="Sheltered Ring",
    legs="Piety Pantaln. +1"
  })
 
  sets.midcast['Divine Magic'] = set_combine(sets.midcast.MAB,{
    hands="Fanatic Gloves",
    ring2="Globidonta Ring",
    legs="Theo. Pant. +1"
  })
 
  sets.midcast['Dark Magic'] = set_combine(sets.midcast.MACC,{
    neck="Aesir Torque"
  })
 
  sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.MACC,{
    head="Befouled Crown",
    body="Vanya Robe",
    hands="Lurid Mitts",
    ring2="Globidonta Ring",
    waist="Rumination Sash",
    legs="Chironic Hose",
    feet="Medium's Sabots"
  })
 
  sets.midcast['Elemental Magic'] = set_combine(sets.midcast.MAB,{
  })
 
  sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'],{
    body="Witching Robe",
    ring1="Sangoma Ring"
  })
     
  sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})
 
  -- Custom spell classes
  sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'],{
  })
 
  sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'],{
  })
   
  -- Sets to return to when not performing an action.
 
  -- Resting sets
  sets.resting = set_combine(sets.sharedResting,{
  })
 
  -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
  sets.idle = {
    main="Queller Rod",
    sub="Genbu's Shield",
    ammo="Impatiens",
    head="Befouled Crown",
    neck="Twilight Torque",
    ear1="Loquacious Earring",
    ear2="Novia Earring",
    body="Vrikodara Jupon",
    hands="Dynasty Mitts",
    ring1="Sheltered Ring",
    ring2="Defending Ring",
    back="Solemnity Cape",
    waist="Fucho-no-Obi",
    legs="Lengo Pants",
    feet="Herald's Gaiters"
  }
 
  -- Total: 33% + 20% (PDT Staff)
  -- <36%: use Shadow Mantle
  sets.idle.PDT = set_combine(sets.idle,{
    main=gear.Staff.PDT,
    sub="Mephitis Grip",
    -- 3%
    head="Blistering Sallet +1",
    -- 5%
    neck="Twilight Torque",
    -- 3%
    body="Vrikodara Jupon",
    -- 3%
    hands="Gendewitha Gages",
    -- 5%
    ring1="Dark Ring",
    -- 10%
    ring2="Defending Ring",
    -- 4%
        back="Solemnity Cape",
    legs="Theo. Pant. +1",
    feet="Vanya Clogs"
  })
 
  -- MDT: 27%
  -- MDB: 25
  -- To cap: Shellra5: 23%, Shell5: 26%, Shell4: 29%
  sets.idle.MDT = set_combine(sets.idle,{
    -- 5
    head="Blistering Sallet +1",
    -- 5%
    neck="Twilight Torque",
    -- 3%
        ear1="Etiolation Earring",
    -- 6
    body="Vrikodara Jupon",
    -- 3
    hands="Dynasty Mitts",
    ring1="Shadow Ring",
    -- 10%
    ring2="Defending Ring",
    -- 4%
        back="Solemnity Cape",
    -- 2% 6
    legs="Gyve Trousers",
    -- 3% 5
    feet="Vanya Clogs"
  })
 
  sets.idle.MDTOnca = {
        -- 5
        head="Blistering Sallet +1",
        -- 5%
        neck="Twilight Torque",
        -- 3%
        ear1="Etiolation Earring",
        -- 12
        body="Onca Suit",
        hands=empty,
        -- 4%
        back="Solemnity Cape",
        legs=empty,
        feet=empty
    }
 
  sets.idle.CP = set_combine(sets.idle,{
        back="Mecistopins Mantle"
    })
   
    sets.idle.CPPDT = set_combine(sets.idle.PDT,{
        back="Mecistopins Mantle"
    })
   
    sets.idle.CPMDT = set_combine(sets.idle.MDT,{
        back="Mecistopins Mantle"
    })
 
  sets.idle.Town = set_combine(sets.idle, {
        body="Councilor's Garb"
    })
 
  sets.idle.Weak = set_combine(sets.idle,{
  })
 
  sets.idle.Regen = set_combine(sets.idle,{
        neck="Bathy Choker +1",
        ring1="Sheltered Ring"
    })
   
  -- Defense sets
 
  sets.defense.PDT = set_combine(sets.idle.PDT,{
  })
 
  sets.defense.MDT = set_combine(sets.idle.MDT,{
  })
 
  sets.Kiting = {feet="Herald's Gaiters"}
 
  sets.latent_refresh = {waist="Fucho-no-obi"}
 
  -- Engaged sets
 
  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.
  -- If you create a set with both offense and defense modes, the offense mode should be first.
  -- EG: sets.engaged.Dagger.Accuracy.Evasion
 
  -- Basic set for if no TP weapon is defined.
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
        waist="Cetl Belt",
        legs=empty,
        feet=empty
  }
 
  -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
  sets.buff['Divine Caress'] = {
    hands="Ebers Mitts",
    back="Mending Cape"
  }
 
end