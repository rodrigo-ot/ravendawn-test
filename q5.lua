-- this table stores the areas used by the spell
local areas= {
	[0] = {
		{0, 0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0, 0},
		{0, 1, 0, 0, 0, 0, 0},
		{1, 1, 0, 2, 0, 0, 1},
		{0, 1, 1, 0, 0, 0, 0},
		{0, 0, 1, 0, 0, 0, 0},
		{0, 0, 0, 1, 0, 0, 0}
	},
	[1] = {
		{0, 0, 0, 0, 0, 0, 0},
		{0, 0, 1, 0, 1, 0, 0},
		{0, 0, 0, 0, 0, 1, 0},
		{0, 0, 0, 2, 0, 0, 0},
		{0, 0, 0, 1, 0, 1, 0},
		{0, 0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0, 0}
	},
	[2] = {
		{0, 0, 0, 0, 0, 0, 0},
		{0, 0, 1, 0, 1, 0, 0},
		{0, 0, 0, 0, 0, 0, 0},
		{0, 0, 1, 2, 1, 0, 0},
		{0, 0, 0, 0, 0, 0, 0},
		{0, 0, 1, 0, 1, 0, 0},
		{0, 0, 0, 0, 0, 0, 0}
	},
	[3] = {
		{0, 0, 0, 1, 0, 0, 0},
		{0, 0, 0, 1, 0, 0, 0},
		{0, 0, 0, 1, 0, 0, 0},
		{0, 0, 0, 2, 0, 0, 0},
		{0, 0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0, 0}
	}
}
-- create a list to store combat objects
Combats = {}
-- stores 4 combat objects into Combats, each one representing one of the areas
for i = 0, 3 do
	function onGetFormulaValues(player, level, magicLevel)
		local min = (level / 5) + (magicLevel * 5.5) + 25
		local max = (level / 5) + (magicLevel * 11) + 50
		return -min, -max
	end
	local combat = Combat()
    combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
    combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
    combat:setArea(createCombatArea(areas[i]))
    combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
    table.insert(Combats, combat)
end

-- this function is used to execute a combat
local function doCombatArea(combat, cid, vid)
	local creature = Player(cid)
	local variant = Variant(vid)
    return combat:execute(creature,variant)
end

function onCastSpell(creature, variant)
    for i = 0, 11 do
		-- this index varies from 0 to 3. It is used to call every combat
        local combatIndex = i % 4 
		-- calls combat from list based on combatIndex
        local combat = Combats[combatIndex + 1]
		-- calls doCombatArea, with an interval of 240ms to execute the combats
        addEvent(doCombatArea, i * 240, combat, creature:getId(), variant:getNumber())
	end
    return true
end
