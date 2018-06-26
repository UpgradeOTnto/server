local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, 2)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -1.2, 1, -2.2, 1)

function onCastSpell(cid, var)
local position1 = {x=getThingPosition(getCreatureTarget(cid)).x+0, y=getThingPosition(getCreatureTarget(cid)).y+0, z=getThingPosition(getCreatureTarget(cid)).z}
doSendMagicEffect(position1, 67)
return doCombat(cid, combat, var)
end
