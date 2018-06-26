local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, 9)
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
addEvent(doSendMagicEffect, 1, {x = pos.x+2, y = pos.y+1, z = pos.z}, 236)
doSendMagicEffect(position1, 29)
exhaustion.set(cid, storage, waittime)
return doCombat(cid, combat, var)
end
