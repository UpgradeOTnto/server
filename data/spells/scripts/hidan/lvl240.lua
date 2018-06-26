local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -6.2, 1, -8.2, 1)

function onCastSpell(cid, var)
local waittime = 0.8 -- Tempo de exhaustion
local storage = 115818

if exhaustion.check(cid, storage) then
    doPlayerSendCancel(cid, "You are exhausted")
return false
end
local position1 = {x=getThingPosition(getCreatureTarget(cid)).x+1, y=getThingPosition(getCreatureTarget(cid)).y+1, z=getThingPosition(getCreatureTarget(cid)).z}
local pos = getCreaturePosition(cid)
local target = getCreatureTarget(cid)
local posi = getCreaturePosition(target)
addEvent(doSendMagicEffect, 100, {x = pos.x+1, y = pos.y+1, z = pos.z}, 11)
setPlayerStorageValue(cid, 17000, 0)
removeHealth(cid, 3, 1.2, 17000)
doSendMagicEffect(position1, 11)
addEvent(setPlayerStorageValue, 10000, cid, 17000, 1)
exhaustion.set(cid, storage, waittime)
return doCombat(cid, combat, var)
end
