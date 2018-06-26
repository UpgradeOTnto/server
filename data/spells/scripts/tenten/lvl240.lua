local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatFormula(combat1, COMBAT_FORMULA_LEVELMAGIC, -1.8, 1, -2.0, 1)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatFormula(combat2, COMBAT_FORMULA_LEVELMAGIC, -1.8, 1, -2.0, 1)

local combat3 = createCombatObject()
setCombatParam(combat3, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatFormula(combat3, COMBAT_FORMULA_LEVELMAGIC, -1.8, 1, -2.0, 1)

local combat4 = createCombatObject()
setCombatParam(combat4, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatFormula(combat4, COMBAT_FORMULA_LEVELMAGIC, -1.8, 1, -2.0, 1)


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
local waittime = 0.8 -- Tempo de exhaustion
local storage = 115818

if exhaustion.check(cid, storage) then
    doPlayerSendCancel(cid, "You are exhausted")
return false
end
local position127 = {x=getPlayerPosition(cid).x, y=getPlayerPosition(cid).y, z=getPlayerPosition(cid).z}
local parameters = { cid = cid, var = var}
local target = getCreatureTarget(cid)
local pos = getCreaturePosition(target)
local posi = getCreaturePosition(cid)
addEvent(doSendMagicEffect, 100, {x = posi.x+1, y = posi.y+0, z = posi.z}, 184)
addEvent(doSendDistanceShoot, 100, getCreaturePosition(cid), pos, 6)
addEvent(doSendDistanceShoot, 200, getCreaturePosition(cid), pos, 10)
addEvent(doSendDistanceShoot, 300, getCreaturePosition(cid), pos, 15)
addEvent(doSendDistanceShoot, 400, getCreaturePosition(cid), pos, 20)
addEvent(doSendDistanceShoot, 500, getCreaturePosition(cid), pos, 21)
addEvent(doSendDistanceShoot, 600, getCreaturePosition(cid), pos, 14)
addEvent(onCastSpell1, 150, parameters)
addEvent(onCastSpell2, 300, parameters)
addEvent(onCastSpell3, 450, parameters)
addEvent(onCastSpell4, 600, parameters)
exhaustion.set(cid, storage, waittime)
return TRUE
end 