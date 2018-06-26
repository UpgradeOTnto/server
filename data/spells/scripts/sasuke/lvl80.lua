local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -2.2, 1, -3.2, 1)

function onCastSpell(cid, var)
local position1 = {x=getThingPosition(getCreatureTarget(cid)).x+1, y=getThingPosition(getCreatureTarget(cid)).y+0, z=getThingPosition(getCreatureTarget(cid)).z}
doSendMagicEffect(position1, 99)
return doCombat(cid, combat, var)
end
