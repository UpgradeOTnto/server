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
local position1 = {x=getThingPosition(getCreatureTarget(cid)).x+3, y=getThingPosition(getCreatureTarget(cid)).y+0, z=getThingPosition(getCreatureTarget(cid)).z}
local pos = getCreaturePosition(cid)
addEvent(doSendMagicEffect, 1, {x = pos.x+1, y = pos.y+0, z = pos.z}, 14)
doSendMagicEffect(position1, 16)
exhaustion.set(cid, storage, waittime)
return doCombat(cid, combat, var)
end
