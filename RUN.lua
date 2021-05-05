-- NOTE: I do not play run, so this will not be maintained for 'active' use.
-- It is added to the repository to allow people to have a baseline to build from,
-- and make sure it is up-to-date with the library API.
-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job. Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
-- Initialization function for this job file.
function get_sets()
mote_include_version = 2
-- Load and initialize the include file.
include('Mote-Include.lua')
include('organizer-lib')
end
-- Setup vars that are user-independent.
function job_setup()
-- Table of entries
rune_timers = T{}
-- entry = rune, index, expires
if player.main_job_level >= 65 then
max_runes = 3
elseif player.main_job_level >= 35 then
max_runes = 2
elseif player.main_job_level >= 5 then
max_runes = 1
else
max_runes = 0
end
end
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job. Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
function user_setup()
 state.OffenseMode:options('DD', 'Acc', 'Dual', 'DualAcc')
 state.WeaponskillMode:options('Normal', 'Acc')
 state.PhysicalDefenseMode:options('PDT','BDT')
 state.IdleMode:options('Regen', 'Refresh')

 update_combat_weapon()
 select_default_macro_book(RUN)
 
 gear.HercHeadMAB = { name="Herculean Helm", augments={'Mag. Acc.+14 "Mag.Atk.Bns."+14','Weapon skill damage +3%','Mag. Acc.+8','"Mag.Atk.Bns."+15'}}
 gear.HercHeadSTR = { name="Herculean Helm", augments={'Rng.Atk.+25','Weapon skill damage +1%','STR+13','Rng.Acc.+8'}}
 
 gear.TaeonBodyPhal = { name="Taeon Tabard", augments={'Pet: Attack+20 Pet: Rng.Atk.+20','Pet: "Dbl. Atk."+2','Phalanx +3'}}
 
 gear.HercHandsPDT = { name="Herculean Gloves", augments={'Accuracy+24 Attack+24','Phys. dmg. taken -3%','DEX+5','Accuracy+11','Attack+1',}}
 
 gear.RawFeetSTR = { name="Rawhide Boots", augments={'STR+10','Attack+15','"Store TP"+5'}}
 gear.RawFeetDEX = { name="Rawhide Boots", augments={'DEX+10','STR+7','INT+7'}}
 gear.TaeonFeetDW = { name="Taeon Boots", augments={'Accuracy+11','"Dual Wield"+5','Crit. hit damage +3%'}}
 gear.TaeonFeetPhal = { name="Taeon Boots", augments={'Pet: "Mag.Atk.Bns."+16','Pet: Crit.hit rate +4','Phalanx +3'}}
 gear.HercFeetTA = { name="Herculean Boots", augments={'Accuracy+21','"Triple Atk."+3','DEX+1','Attack+13'}}
 gear.HercFeetMAB = { name="Herculean Boots", augments = {'Accuracy+15','MND+7','Weapon skill damage +3%','Mag. Acc.+20 "Mag.Atk.Bns."+20',}}
 
 gear.TankCape = { name="Ogma's cape", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Enmity+10',}}
 gear.DDCape = { name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}}
end

function init_gear_sets()
sets.enmity = {ammo="Iron Gobbet",
 head="Halitus Helm", neck="Unmoving Collar", ear1="Friomisi Earring",ear2="Trux Earring",
 body="Emet Harness +1", hands="Futhark Mitons +1", ring2="Petrov Ring",
 back=gear.TankCape, waist="Goading Belt",legs="Erilaz Leg Guards +1",feet="Erilaz Greaves +1"}
 
--Additional local binds--

 send_command('bind ^` input //gs equip sets.defense.Resist')
 
--------------------------------------
-- Precast sets
--------------------------------------
-- Precast sets to enhance JAs
sets.precast.JA['Vallation'] = {body="Runeist coat +1", legs="Futhark Trousers +1"}

sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']

sets.precast.JA['Pflug'] = {feet="Runeist bottes +1"}

sets.precast.JA['Battuta'] = {head="Futhark Bandeau +1"}

sets.precast.JA['Liement'] = {body="Futhark Coat +1"}

sets.precast.JA['Lunge'] = {ammo="Seeth. Bomblet +1",
 head=gear.HercHeadMAB, neck="Sanctity Necklace", ear1="Crematio Earring", ear2="Friomisi Earring",
 body="Samnuha Coat", hands="Carmine Finger Gauntlets +1", ring1="Mujin Band", ring2="Fenrir Ring +1",
 back="Argochampsa Mantle", waist="Eschan Stone", legs="Limbo Trousers", feet=gear.HercFeetMAB}

sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']

sets.precast.JA['Gambit'] = set_combine(sets.enmity, {hands="Runeist Mitons +1"})

sets.precast.JA['Rayke'] = set_combine(sets.enmity, {feet="Futhark Boots +1"})

sets.precast.JA['Elemental Sforzo'] = {body="Futhark Coat +1"}

sets.precast.JA['Swordplay'] = {hands="Futhark Mitons +1"}

sets.precast.JA['Embolden'] = {back="Evasionist's Cape"}

sets.precast.JA['Vivacious Pulse'] = {head="Erilaz Galea +1"}

sets.precast.JA['One For All'] = {}

sets.precast.JA['Provoke'] = sets.enmity

-- Fast cast sets for spells
sets.precast.FC = {ammo="Impatiens",
 head="Runeist bandeau +1",neck="Voltsurge Torque", ear1="Loquacious Earring", ear2= "Etiolation Earring",
 body="Dread Jupon", hands="Leyline Gloves", ring2="Lebeche Ring",
 legs="Limbo Trousers",feet="Chelona Boots +1"}

sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash", legs="Futhark Trousers +1"})

sets.precast.FC['Utsusemi: Ichi'] = set_combine(sets.precast.FC, {body="Passion Jacket"})

sets.precast.FC['Utsusemi: Ni'] = set_combine(sets.precast.FC['Utsusemi: Ichi'], {})

-- Weaponskill sets

sets.precast.WS = {ammo="Seeth. Bomblet +1",
head=gear.HercHeadSTR, neck="Fotia Gorget", ear1="Moonshade Earring", ear2="Brutal Earring",
body="Rawhide Vest", hands="Rawhide Gloves", ring1="Ifrit Ring +1", ring2="Epona's Ring",
back=gear.DDCape, waist="Fotia Belt", legs="Samnuha Tights", feet=gear.RawFeetSTR}

sets.precast.WS.Acc = set_combine(sets.precast.WS,{ammo="Ginsen", 
head="Skormoth Mask",
body="Erilaz Surcoat +1", hands="Erilaz Gauntlets +1", ring2="Cacoethic Ring"})

sets.precast.WS['Resolution'] = {ammo="Seeth. Bomblet +1",
head="Meghanada Visor +1", neck="Fotia Gorget", ear1="Moonshade Earring", ear2="Sherida Earring",
body="Meghanada Cuirie +1", hands="Meghanada Gloves +1", ring1="Ifrit Ring +1", ring2="Shukuyu Ring",
back=gear.DDcape, waist="Fotia Belt", legs="Meghanada Chausses +1", feet=gear.RawFeetSTR}

sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'].Normal,{
head="Skormoth Mask",
body="Erilaz Surcoat +1", hands="Erilaz Gauntlets +1"})

sets.precast.WS['Dimidiation'] = {ammo="Knobkierrie",
head="Lilitu Headpiece", neck="Fotia Gorget", ear1="Moonshade Earring", ear2="Ishvara Earring",
body="Rawhide Vest", hands="Rawhide Gloves", ring1="Rajas Ring", ring2="Apate Ring",
back=gear.DDCape, waist="Fotia Belt", legs="Samnuha Tights", feet=gear.RawFeetDEX}

sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS['Dimidiation'].Normal,
{ammo="Ginsen", head="Adhemar Bonnet", body="Erilaz Surcoat +1", hands="Erilaz Gauntlets +1"})

sets.precast.WS['Herculean Slash'] = set_combine(sets.precast['Lunge'], {})
sets.precast.WS['Herculean Slash'].Acc = set_combine(sets.precast.WS['Herculean Slash'].Normal, {})

sets.precast.WS['Savage Blade'] = {ammo="Iron Gobbet",
head=gear.HercHeadSTR, neck="Fotia Gorget", ear1="Moonshade Earring", ear2="Ishvara Earring",
body="Dread Jupon", hands="Rawhide Gloves", ring1="Ifrit Ring +1", ring2="Rufescent Ring",
back=gear.DDcape, waist="Fotia Belt", legs="Taeon Tights", feet=gear.RawFeetSTR}

sets.precast.WS['Sanguine Blade'] =  set_combine(sets.precast['Lunge'], {head="Pixie Hairpin +1",ring1="Archon Ring"})

--To ensure Organizer grabs some otherwise undefined gear.--
	sets.precast.WS['Drakesbane'] = {ring1="Warp Ring",ring2="Capacity Ring"}

--------------------------------------
-- Midcast sets
--------------------------------------
sets.midcast.FastRecast = {}
sets.midcast['Enhancing Magic'] = {head="Erilaz Galea +1", neck="Incanter's Torque",
 hands="Runeist mitons +1", ring1="Stikini Ring",
 waist="Olympus Sash", legs="Futhark Trousers +1"}

sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {head="Futhark Bandeau +1", body=gear.TaeonBodyPhal,
 feet=gear.TaeonFeetPhal})
sets.midcast['Refresh'] = set_combine(sets.midcast['Enhancing Magic'], {head="Erilaz Galea +1"})
sets.midcast['Regen'] = set_combine(sets.midcast['Enhancing Magic'], {head="Runeist Bandeau +1"})
sets.midcast['Stoneskin'] = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})

sets.midcast['Flash'] = sets.enmity

sets.midcast['Foil'] = sets.enmity

sets.midcast['Blank Gaze'] = sets.enmity

sets.midcast['Geist Wall'] = sets.enmity

sets.midcast['Jettatura'] = sets.enmity

sets.midcast['Wild Carrot'] = {ammo="Iron Gobbet", 
 neck="Phalaina Locket", ear1="Mendicant's Earring", ear2="Friomisi Earring",
 hands="Buremte Gloves", ring1="Lebeche Ring",
 back="Solemnity Cape", feet="Futhark Boots +1"}

sets.midcast.Cure = sets.midcast['Wild Carrot']
--------------------------------------
-- Idle/resting/defense/etc sets
--------------------------------------
sets.idle = {ammo="Impatiens",
 head="Ocelomeh Headpiece +1", neck="Bathy Choker +1", ear1="Ethereal earring", ear2="Etiolation Earring",
 body="Futhark Coat +1", hands="Runeist Mitons +1", ring1="Sheltered Ring", ring2="Paguroidea ring",
 back="Evasionist's Cape", waist="Flume Belt", legs="Rawhide Trousers", feet="Skadi's Jambeaux +1"}

sets.idle.Refresh = set_combine(sets.idle, {head="Rawhide Mask",body="Runeist Coat +1", waist="Fucho-no-obi"})

sets.idle.Town = {ammo="Impatiens",
 head="Ocelomeh Headpiece +1", neck="Bathy Choker +1", ear1="Ethereal earring", ear2="Etiolation Earring",
 body="Councilor's Garb", hands="Runeist Mitons +1", ring1="Sheltered Ring", ring2="Trizek Ring",
 back="Evasionist's Cape", waist="Flume Belt", legs="Erilaz Leg Guards +1", feet="Skadi's Jambeaux +1"}

	
	
 --*DEFENSE SETS*--
 
-- sets.defense.PDT = {ammo="Amar Cluster",
	--head="Erilaz Galea +1", neck="Loricate Torque +1", ear1="Genmei Earring", ear2="Cryptic Earring",
	--body="Erilaz Surcoat +1", hands=gear.HercHandsPDT, ring1="Defending Ring", ring2="Gelatinous Ring +1",
	--back=gear.TankCape, waist="Flume Belt", legs="Erilaz Leg Guards +1", feet="Erilaz Greaves +1"}
 
--Resist PDT
sets.defense.PDT = {
    main="Epeolatry",
    sub="Refined Grip +1",
    ammo="Staunch Tathlum",
    head="Erilaz Galea +1",
    body={ name="Futhark Coat +1", augments={'Enhances "Elemental Sforzo" effect',}},
    hands="Erilaz Gauntlets +1",
    legs="Rune. Trousers +2",
    feet="Erilaz Greaves +1",
    neck="Loricate Torque +1",
    waist="Flume Belt",
    left_ear="Genmei Earring",
    right_ear="Hearty Earring",
    left_ring="Defending Ring",
    right_ring="Gelatinous Ring +1",
    back={ name="Ogma's cape", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Enmity+10',}},}
 



sets.defense.MDT = {ammo="Seeth. Bomblet +1",
 head="Erilaz Galea +1", neck="Loricate Torque +1", ear1="Ethereal Earring", ear2="Sanare Earring",
 body="Runeist Coat +1", hands="Erilaz Gauntlets +1", ring1="Defending Ring", ring2="Shadow Ring",
 back="Engulfer Cape +1", waist="Flume Belt", legs="Erilaz Leg Guards +1", feet="Erilaz Greaves +1"}

--Breath 
--sets.defense.MDT = {ammo="Staunch tathlum",
 --head="Erilaz Galea +1", neck="Loricate Torque +1", ear1="Ethereal Earring", ear2="Sanare Earring",
 --body="Futhark Coat +1", hands="Erilaz Gauntlets +1", ring1="Defending Ring", ring2="Dark Ring",
 --back="Evasionist's Cape", waist="Kentarch Belt +1", legs="Erilaz Leg Guards +1", feet="Erilaz Greaves +1"}
 
sets.defense.Resist = {
    main="Epeolatry",
    sub="Refined Grip +1",
    ammo="Staunch Tathlum",
    head="Erilaz Galea +1",
    body={ name="Futhark Coat +1", augments={'Enhances "Elemental Sforzo" effect',}},
    hands="Erilaz Gauntlets +1",
    legs="Rune. Trousers +2",
    feet="Erilaz Greaves +1",
    neck="Loricate Torque +1",
    waist="Flume Belt",
    left_ear="Genmei Earring",
    right_ear="Hearty Earring",
    left_ring="Defending Ring",
    right_ring="Gelatinous Ring +1",
    back={ name="Ogma's cape", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Enmity+10',}},
}

sets.Kiting = {feet="Skadi's Jambeaux +1"}
--------------------------------------
-- Engaged sets
--------------------------------------
sets.engaged.DD = {ammo="Ginsen",
 head="Skormoth Mask", neck="Lissome Necklace", ear1="Bladeborn Earring", ear2="Steelflash Earring",
 body="Rawhide Vest", hands="Adhemar Wristbands", ring1="Rajas Ring", ring2="Epona's Ring",
 back=gear.DDCape, waist="Windbuffet Belt +1", legs="Samnuha Tights", feet=gear.RawFeetSTR}

sets.engaged.Acc = set_combine(sets.engaged.DD, {ammo="Yamarang", 
head="Dampening Tam",neck="Combatant's Torque",
body="Adhemar Jacket",hands=gear.HercHandsPDT,ring1="Cacoethic Ring",ring2="Cacoethic Ring +1",
waist="Ioskeha Belt",feet=gear.RawFeetSTR})

sets.engaged.Dual = {ammo="Ginsen",
 head="Skormoth Mask", neck="Lissome Necklace", ear1="Heartseeker Earring", ear2="Dudgeon Earring",
 body="Samnuha Coat", hands="Adhemar Wristbands", ring1="Haverton Ring", ring2="Epona's Ring",
 back=gear.TankCape,waist="Windbuffet Belt +1", legs="Samnuha Tights", feet=gear.TaeonFeetDW}
 
sets.engaged.Dual.acc = set_combine (sets.engaged.Dual, {ammo="Ginsen",
 head="Dampening Tam", neck="Asperity Necklace", ear1="Heartseeker Earring", ear2="Dudgeon Earring",
 body="Samnuha Coat", hands="Adhemar Wristbands", ring1="Haverton Ring", ring2="Epona's Ring",
 waist="Kentarch Belt +1"})

    --------------------------------------
    -- Vivacious Pulse sets
    --------------------------------------
 
    -- Maximize the stat listed for each set.
    sets.pulse = {}
    -- STR
    sets.pulse.Ignis = {ammo="Seeth. Bomblet +1",
        ear1="Vulcan's Pearl",ear2="Vulcan's Pearl",
        body="Rawhide Vest",hands="Rawhide Gloves",ring1="Rufescent Ring",ring2="Ifrit Ring +1",
        back=gear.DDCape,legs="Samnuha Tights",feet=gear.RawFeetSTR}
    -- DEX
    sets.pulse.Gelus = {
        neck="Love Torque",ear1="Dominance Earring",
        body="Rawhide Vest",hands="Rawhide Gloves",ring1="Rajas Ring",ring2="Apate Ring",
        back=gear.DDCape,legs="Samnuha Tights",feet=gear.RawFeetDEX}
    -- VIT
    sets.pulse.Flabra = {ammo="Iron Gobbet",
        neck="Unmoving Collar",
        body="Dread Jupon",hands="Rawhide Gloves",ring2="Dark Ring",
        back=gear.TankCape,legs="Runeist Trousers +2",feet="Futhark Boots +1"}
    -- AGI
    sets.pulse.Tellus = {
        ear2="Suppanomimi",
        body="Dread Jupon",hands="Runeist Mitons +1",ring1="Dark Ring",ring2="Apate Ring",
        legs="Runeist Trousers +2",feet="Futhark Boots +1"}
    -- MND
    sets.pulse.Unda = {
        ear1="Lifestorm Earring",
        body="Dread Jupon",hands="Runeist Mitons +1",ring1="Rufescent Ring",ring2="Dark Ring",
        legs="Runeist Trousers +2"}
    -- INT
    sets.pulse.Sulpor = {ammo="Ghastly Tathlum +1",
        ear1="Psystorm Earring",
        body="Dread Jupon",hands="Rawhide Gloves",ring1="Shiva Ring +1",ring2="Dark Ring",
        back="Toro Cape",waist="Yamabuki-no-obi",legs="Runeist Trousers +2"}
    -- CHR
    sets.pulse.Lux = {
        neck="Unmoving Collar",
        body="Dread Jupon",hands="Erilaz Gauntlets +1",ring2="Dark Ring",
        legs="Runeist Trousers +2"}
    -- Divine Magic skill and possibly all stats?
    sets.pulse.Tenebrae = {
        legs="Runeist Trousers +2"}

end

--------------------------------------
-- Vivacious Pulse Sets
--------------------------------------
-- Precast sets to enhance Vivacious Pulse

function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == 'Vivacious Pulse' then
        -- There's got to be a less verbose way of doing this
        if buffactive['Ignis'] then
            equip(sets.pulse.Ignis)
        elseif buffactive['Gelus'] then
            equip(sets.pulse.Gelus)
        elseif buffactive['Flabra'] then
            equip(sets.pulse.Flabra)
        elseif buffactive['Tellus'] then
            equip(sets.pulse.Tellus)
        elseif buffactive['Sulpor'] then
            equip(sets.pulse.Sulpor)
        elseif buffactive['Unda'] then
            equip(sets.pulse.Unda)
        elseif buffactive['Lux'] then
            equip(sets.pulse.Lux)
        elseif buffactive['Tenebrae'] then
            equip(sets.pulse.Tenebrae)
        end
    end
end
 

------------------------------------------------------------------
-- Action events
------------------------------------------------------------------
-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
if spell.english == 'Lunge' or spell.english == 'Swipe' then
local obi = get_obi(get_rune_obi_element())
if obi then
equip({waist=obi})
end
end
end
function job_aftercast(spell)
if not spell.interrupted then
if spell.type == 'Rune' then
update_timers(spell)
elseif spell.name == "Lunge" or spell.name == "Gambit" or spell.name == 'Rayke' then
reset_timers()
elseif spell.name == "Swipe" then
send_command(trim(1))
end
end
end
-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------
-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)
	update_combat_weapon()
	
end

function job_update(cmdParams, eventArgs)
	update_combat_weapon()
	
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
-- Default macro set/book
if player.sub_job == 'BLU' then
set_macro_page(1, 5)
elseif player.sub_job == 'NIN' then
set_macro_page(1, 5)
elseif player.sub_job == 'SAM' then
set_macro_page(1, 5)
else
set_macro_page(1, 5)
end
end

function update_combat_weapon()
	state.CombatWeapon:set(player.equipment.main)
end


function get_rune_obi_element()
weather_rune = buffactive[elements.rune_of[world.weather_element] or '']
day_rune = buffactive[elements.rune_of[world.day_element] or '']
local found_rune_element
if weather_rune and day_rune then
if weather_rune > day_rune then
found_rune_element = world.weather_element
else
found_rune_element = world.day_element
end
elseif weather_rune then
found_rune_element = world.weather_element
elseif day_rune then
found_rune_element = world.day_element
end
return found_rune_element
end
function get_obi(element)
if element and elements.obi_of[element] then
return (player.inventory[elements.obi_of[element]] or player.wardrobe[elements.obi_of[element]]) and elements.obi_of[element]
end
end
------------------------------------------------------------------
-- Timer manipulation
------------------------------------------------------------------
-- Add a new run to the custom timers, and update index values for existing timers.
function update_timers(spell)
local expires_time = os.time() + 300
local entry_index = rune_count(spell.name) + 1
local entry = {rune=spell.name, index=entry_index, expires=expires_time}
rune_timers:append(entry)
local cmd_queue = create_timer(entry).. ';wait 0.05;'
cmd_queue = cmd_queue .. trim()
add_to_chat(123,'cmd_queue='..cmd_queue)
send_command(cmd_queue)
end
-- Get the command string to create a custom timer for the provided entry.
function create_timer(entry)
local timer_name = '"Rune: ' .. entry.rune .. '-' .. tostring(entry.index) .. '"'
local duration = entry.expires - os.time()
return 'timers c ' .. timer_name .. ' ' .. tostring(duration) .. ' down'
end
-- Get the command string to delete a custom timer for the provided entry.
function delete_timer(entry)
local timer_name = '"Rune: ' .. entry.rune .. '-' .. tostring(entry.index) .. '"'
return 'timers d ' .. timer_name .. ''
end
-- Reset all timers
function reset_timers()
local cmd_queue = ''
for index,entry in pairs(rune_timers) do
cmd_queue = cmd_queue .. delete_timer(entry) .. ';wait 0.05;'
end
rune_timers:clear()
send_command(cmd_queue)
end
-- Get a count of the number of runes of a given type
function rune_count(rune)
local count = 0
local current_time = os.time()
for _,entry in pairs(rune_timers) do
if entry.rune == rune and entry.expires > current_time then
count = count + 1
end
end
return count
end
-- Remove the oldest rune(s) from the table, until we're below the max_runes limit.
-- If given a value n, remove n runes from the table.
function trim(n)
local cmd_queue = ''
local to_remove = n or (rune_timers:length() - max_runes)
while to_remove > 0 and rune_timers:length() > 0 do
local oldest
for index,entry in pairs(rune_timers) do
if oldest == nil or entry.expires < rune_timers[oldest].expires then
oldest = index
end
end
cmd_queue = cmd_queue .. prune(rune_timers[oldest].rune)
to_remove = to_remove - 1
end
return cmd_queue
end
-- Drop the index of all runes of a given type.
-- If the index drops to 0, it is removed from the table.
function prune(rune)
local cmd_queue = ''
for index,entry in pairs(rune_timers) do
if entry.rune == rune then
cmd_queue = cmd_queue .. delete_timer(entry) .. ';wait 0.05;'
entry.index = entry.index - 1
end
end
for index,entry in pairs(rune_timers) do
if entry.rune == rune then
if entry.index == 0 then
rune_timers[index] = nil
else
cmd_queue = cmd_queue .. create_timer(entry) .. ';wait 0.05;'
end
end
end
return cmd_queue
end
------------------------------------------------------------------
-- Reset events
------------------------------------------------------------------
windower.raw_register_event('zone change',reset_timers)
windower.raw_register_event('logout',reset_timers)
windower.raw_register_event('status change',function(new, old)
if gearswap.res.statuses[new].english == 'Dead' then
reset_timers()
end
end)