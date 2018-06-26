local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -4.2, 1, -5.2, 1)

function onCastSpell(cid, var)
local position1 = {x=getThingPosition(getCreatureTarget(cid)).x+2, y=getThingPosition(getCreatureTarget(cid)).y+1, z=getThingPosition(getCreatureTarget(cid)).z}
local target = getCreatureTarget(cid)
local pos = getCreaturePosition(target)
addEvent(doSendMagicEffect, 1, {x = pos.x+1, y = pos.y+0, z = pos.z}, 38)
return doCombat(cid, combat, var)
end