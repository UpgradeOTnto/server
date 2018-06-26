local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatParam(combat1, COMBAT_PARAM_DISTANCEEFFECT, 15)
setCombatFormula(combat1, COMBAT_FORMULA_LEVELMAGIC, -1.1, 1, -1.2, 1)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_DISTANCEEFFECT, 15)
setCombatFormula(combat2, COMBAT_FORMULA_LEVELMAGIC, -1.5, 1, -1.2, 1)

local combat3 = createCombatObject()
setCombatParam(combat3, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatParam(combat3, COMBAT_PARAM_DISTANCEEFFECT, 15)
setCombatFormula(combat3, COMBAT_FORMULA_LEVELMAGIC, -1.2, 1, -1.2, 1)

local combat4 = createCombatObject()
setCombatParam(combat4, COMBAT_PARAM_DISTANCEEFFECT, 15)
setCombatParam(combat4, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatFormula(combat4, COMBAT_FORMULA_LEVELMAGIC, -1.5, 1, -2.5, 1)


arr1 = {
	{3}
}

arr2 = {
	{3}
}

arr3 = {
	{3}
}

arr4 = {
	{3}
}

local area1 = createCombatArea(arr1)
local area2 = createCombatArea(arr2)
local area3 = createCombatArea(arr3)
local area4 = createCombatArea(arr4)
setCombatArea(combat1, area1)
setCombatArea(combat2, area2)
setCombatArea(combat3, area3)
setCombatArea(combat4, area4)
 
local function onCastSpell1(parameters)
    return isPlayer(parameters.cid) and doCombat(parameters.cid, combat1, parameters.var)
end
 
local function onCastSpell2(parameters)
    return isPlayer(parameters.cid) and doCombat(parameters.cid, combat2, parameters.var)
end

local function onCastSpell3(parameters)
    return isPlayer(parameters.cid) and doCombat(parameters.cid, combat3, parameters.var)
end

local function onCastSpell4(parameters)
    return isPlayer(parameters.cid) and doCombat(parameters.cid, combat4, parameters.var)
end
 
function onCastSpell(cid, var)
local position127 = {x=getPlayerPosition(cid).x, y=getPlayerPosition(cid).y, z=getPlayerPosition(cid).z}
local parameters = { cid = cid, var = var}
local target = getCreatureTarget(cid)
local pos = getCreaturePosition(target)
addEvent(doSendMagicEffect, 200, {x = pos.x, y = pos.y, z = pos.z}, 8)
addEvent(doSendMagicEffect, 600, {x = pos.x, y = pos.y, z = pos.z}, 8)
addEvent(doSendMagicEffect, 1000, {x = pos.x, y = pos.y, z = pos.z}, 8)
addEvent(onCastSpell1, 200, parameters)
addEvent(onCastSpell2, 600, parameters)
addEvent(onCastSpell2, 1000, parameters)
return TRUE
end 