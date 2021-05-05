-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')
    	
    state.MagicBurst = M(false, 'Magic Burst')
		
    -- Additional local binds
    send_command('bind ^` input /ma Stun <t>')
    send_command('bind ^delete gs c toggle MagicBurst')

    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind @`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
	--include('augmented-items.lua')
	
    ---- Precast Sets ----
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {feet="Goetia Sabots +2"}

    sets.precast.JA.Manafont = {body="Sorcerer's Coat +2"}
    
    -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
    sets.precast.JA.Convert = {}


    -- Fast cast sets for spells

    sets.precast.FC = {ammo="Impatiens",
        head="Nahtirah Hat",neck="Baetyl Pendant",ear1="Etiolation Earring",ear2="Loquacious Earring",
        body="Vanir Cotehardie",hands=gear.MerlinHandsFC,ring1="Kishar ring",ring2="Lebeche ring",
        back=gear.TaranusFC,waist="Witful Belt",legs="Lengo Pants",feet="Regal Pumps +1"}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {hands="Loagaeth cuffs",ear2="Barkarole earring"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		main="Serenity",
		ear2="Mendicant's earring",
		body="Heka's Kalasiris",hands="Vanya cuffs",
		legs="Doyen pants"})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Hagondes Hat",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="Icesoul Ring",
        back="Refraction Cape",waist="Cognition Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Vidohunir'] = {ammo="Dosis Tathlum",
        head="Hagondes Hat",neck="Eddy Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Icesoul Ring",ring2="Acumen Ring",
        back="Toro Cape",waist="Thunder Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}
    
    
    ---- Midcast Sets ----

    sets.midcast.FastRecast = {main="Malevolence",sub="Ammurapi shield",ammo="Staunch Tathlum",
        head="Nahtirah Hat",neck="Orunmila's torque",ear1="Etiolation Earring",ear2="Loquacious Earring",
        body="Merlinic jubbah",hands=gear.MerlinHandsFC,ring1="Defending ring",ring2="Lebeche ring",
        back=gear.TaranusFC,waist="Witful belt",legs="Lengo Pants",feet="Regal Pumps +1"}

    sets.midcast.Cure = {main="Gada",sub="Genbu's shield",ammo="Impatiens",
        head="Vanya hood",neck="Incanter's torque",ear1="Novia earring",ear2="Mendicant's earring",
        body="Vanya robe",hands="Vanya cuffs",ring1="Sirona's ring",ring2="Lebeche ring",
        back="Tempered cape +1",waist="Bishop's sash",legs="Academic's pants +2",feet="Vanya clogs"}

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast['Enhancing Magic'] = {sub="Ammurapi shield",
        head="Befouled crown",neck="Incanter's torque",ear1="Andoaa earring",
        body="Pedagogy gown +1",hands="Arbatel Bracers +1",ring1="Stikini ring",ring2="Stikini ring",
        back="Perimede cape",waist="Olympus sash",legs="Shedir seraweels",feet="Regal pumps +1"}
    
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})

    sets.midcast['Enfeebling Magic'] = {main="Grioavolr",sub="Enki strap",ammo="Pemphredo tathlum",
        head="Merlinic hood",neck="Erra pendant",ear1="Gwati Earring",ear2="Dignitary's earring",
        body="Vanya robe",hands="Lurid mitts",ring1="Kishar ring",ring2="Stikini ring",
        back=gear.TaranusMB,waist="Luminary sash",legs=gear.ChironicLegsMACC,feet="Medium's sabots"}
        
    sets.midcast.ElementalEnfeeble = sets.midcast['Enfeebling Magic']

    sets.midcast['Dark Magic'] = {main="Rubicundity",sub="Genmei shield",ammo="Pemphredo tathlum",
        head="Pixie hairpin +1",neck="Incanter's torque",ear1="Gwati Earring",ear2="Barkarole earring",
        body="Merlinic Jubbah",hands="Lurid mitts",ring1="Stikini ring",ring2="Stikini ring",
        back=gear.TaranusMB,waist="Luminary sash",legs="Merlinic Shalwar",feet="Merlinic Crackows"}

    sets.midcast.Drain = {main="Rubicundity",sub="Genmei shield",ammo="Pemphredo tathlum",
        head="Pixie hairpin +1",neck="Erra pendant",ear1="Gwati Earring",ear2="Barkarole earring",
        body="Merlinic Jubbah",hands="Lurid mitts",ring1="Archon ring",ring2="Evanescence ring",
        back=gear.TaranusMB,waist="Fucho-no-obi",legs="Merlinic Shalwar",feet="Merlinic Crackows"}
    
    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = {main="Apamajas II",sub="Enki strap",ammo="Pemphredo tathlum",
        head="Merlinic Hood",neck="Orunmila's torque",ear1="Etiolation Earring",ear2="Loquacious earring",
        body="Merlinic Jubbah",hands="Jhakri cuffs +2",ring1="Stikini ring",ring2="Stikini ring",
        back="Perimede cape",waist="Witful Belt",legs="Psycloth lappas",feet="Merlinic Crackows"}
		
	sets.midcast.Stun.Resistant = {main="Rubicundity",sub="Ammurapi shield",ammo="Pemphredo tathlum",
        head="Merlinic Hood",neck="Erra pendant",ear1="Etiolation Earring",ear2="Dignitary's earring",
        body="Merlinic Jubbah",hands="Jhakri cuffs +2",ring1="Stikini ring",ring2="Stikini ring",
        back=gear.TaranusMB,waist="Luminary sash",legs=gear.ChironicLegsMACC,feet="Merlinic Crackows"}

    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {main="Grioavolr",sub="Niobid strap",ammo="Pemphredo tathlum",
        head="Merlinic Hood",neck="Sanctity necklace",ear1="Regal earring",ear2="Barkarole earring",
        body="Merlinic Jubbah",hands="Amalric gages",ring1="Shiva ring +1",ring2="Shiva ring +1",
        back=gear.TaranusMB,waist=gear.ElementalObi,legs="Merlinic Shalwar",feet="Merlinic Crackows"}

    sets.midcast['Elemental Magic'].Resistant = {main="Grioavolr",sub="Enki strap",ammo="Pemphredo tathlum",
        head="Merlinic Hood",neck="Sanctity necklace",ear1="Regal earring",ear2="Barkarole earring",
        body="Merlinic Jubbah",hands="Amalric gages",ring1="Shiva ring +1",ring2="Shiva ring +1",
        back=gear.TaranusMB,waist="Eschan stone",legs="Merlinic Shalwar",feet="Merlinic Crackows"}
		
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {main="Bolelabunga",sub="Genmei shield",ammo="Staunch Tathlum",
        head="Befouled Crown",neck="Bathy Choker +1",ear1="Infused earring",ear2="ethereal earring",
        body="Witching Robe",hands="Serpentes cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Moonbeam cape",waist="Fucho-no-obi",legs="Assiduity pants +1",feet="Herald's Gaiters"}
    

    -- Idle sets
    
    -- Normal refresh idle set
    sets.idle = {main="Bolelabunga",sub="Genmei shield",ammo="Staunch Tathlum",
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Infused earring",ear2="ethereal earring",
        body="Jhakri robe +2",hands="Serpentes cuffs",ring1="Defending Ring",ring2="Paguroidea Ring",
        back="Mecisto. Mantle",waist="Fucho-no-obi",legs="Assiduity pants +1",feet="Herald's Gaiters"}

    -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
    sets.idle.PDT = {main="Terra's staff",sub="Oneiros grip",ammo="Staunch Tathlum",
        head="Befouled Crown",neck="Loricate torque +1",ear1="Sanare earring",ear2="ethereal earring",
        body="Jhakri robe +2",hands="Hagondes cuffs +1",ring1="Defending Ring",ring2="Dark Ring",
        back="Moonbeam cape",waist="Fucho-no-obi",legs="Assiduity pants +1",feet="Battlecast gaiters"}

    -- Idle mode scopes:
    -- Idle mode when weak.
    sets.idle.Weak = {main="Bolelabunga",sub="Genmei shield",ammo="Staunch Tathlum",
        head="Befouled Crown",neck="Bathy Choker +1",ear1="Infused earring",ear2="ethereal earring",
        body="Jhakri robe +2",hands="Serpentes cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Moonbeam cape",waist="Fucho-no-obi",legs="Assiduity pants +1",feet="Herald's Gaiters"}
    
    -- Town gear.
    sets.idle.Town = {main="Bolelabunga",sub="Genmei shield",ammo="Staunch Tathlum",
        head="Befouled Crown",neck="Bathy Choker +1",ear1="Infused earring",ear2="ethereal earring",
        body="Jhakri robe +2",hands="Serpentes cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Mecisto. Mantle",waist="Fucho-no-obi",legs="Assiduity pants +1",feet="Herald's Gaiters"}
        
    -- Defense sets

    sets.defense.PDT = {main="Mafic cudgel",sub="Genmei shield",ammo="Staunch Tathlum",
        head="Vanya hood",neck="Loricate torque +1",ear1="Infused earring",ear2="ethereal earring",
        body="Mallquis saio +1",hands="Hagondes cuffs +1",ring1="Defending Ring",ring2="Dark ring",
        back="Moonbeam cape",waist="Fucho-no-obi",legs="Assiduity pants +1",feet="Battlecast gaiters"}

    sets.defense.MDT = {main="Mafic cudgel",sub="Genmei shield",ammo="Staunch Tathlum",
        head="Vanya hood",neck="Loricate torque +1",ear1="Infused earring",ear2="ethereal earring",
        body="Mallquis saio +1",hands="Hagondes cuffs +1",ring1="Defending Ring",ring2="Dark ring",
        back="Moonbeam cape",waist="Fucho-no-obi",legs="Assiduity pants +1",feet="Vanya clogs"}

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    
    sets.buff['Mana Wall'] = {back=gear.TaranusMB,feet="Goetia Sabots +2"}

    sets.magic_burst = {main="Grioavolr",sub="Niobid strap",ammo="Pemphredo tathlum",
        head="Merlinic Hood",neck="Mizukage-no-Kubikazari",ear1="Regal earring",ear2="Barkarole earring",
        body="Merlinic Jubbah",hands="Amalric gages",ring1="Mujin band",ring2="Shiva ring +1",
        back=gear.TaranusMB,waist=gear.ElementalObi,legs="Merlinic Shalwar",feet="Merlinic Crackows"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        head="Zelus Tiara",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Hagondes Coat",hands="Bokwus Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Umbra Cape",waist="Goading Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spellMap == 'Cure' or spellMap == 'Curaga' then
        gear.default.obi_waist = "Bishop's sash"
    elseif spell.skill == 'Elemental Magic' then
        gear.default.obi_waist = "Yamabuki-no-Obi"
        if state.CastingMode.value == 'Proc' then
            classes.CustomClass = 'Proc'
        end
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)

end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
        equip(sets.magic_burst)
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    -- Lock feet after using Mana Wall.
    if not spell.interrupted then
        if spell.english == 'Mana Wall' then
            enable('feet')
            equip(sets.buff['Mana Wall'])
            disable('feet')
        elseif spell.skill == 'Elemental Magic' then
            state.MagicBurst:reset()
        end
    end
end

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
        --[[ No real need to differentiate with current gear.
        if lowTierNukes:contains(spell.english) then
            return 'LowTierNuke'
        else
            return 'HighTierNuke'
        end
        --]]
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
    set_macro_page(1, 14)
end
