local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatFormula(combat1, COMBAT_FORMULA_LEVELMAGIC, -3.2, 1, -4.2, 1)

arr1 = {
	{1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 3, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1}
}

local area1 = createCombatArea(arr1)
setCombatArea(combat1, area1)
 
local function onCastSpell1(parameters)
    return isPlayer(parameters.cid) and doCombat(parameters.cid, combat1, parameters.var)
end
 
function onCastSpell(cid, var)
local parameters = { cid = cid, var = var}
local pos = getCreaturePosition(cid)
addEvent(doSendMagicEffect, 100, {x = pos.x+7, y = pos.y-2, z = pos.z}, 160)
addEvent(doSendMagicEffect, 100, {x = pos.x+7, y = pos.y-1, z = pos.z}, 160)
addEvent(doSendMagicEffect, 100, {x = pos.x+7, y = pos.y+0, z = pos.z}, 160)
addEvent(doSendMagicEffect, 100, {x = pos.x+7, y = pos.y+1, z = pos.z}, 160)
addEvent(doSendMagicEffect, 100, {x = pos.x+7, y = pos.y+2, z = pos.z}, 160)
addEvent(onCastSpell1, 100, parameters)
return TRUE
end 