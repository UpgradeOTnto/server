local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, 34)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -3.2, 1, -4.2, 1)

function onCastSpell(cid, var)
return doCombat(cid, combat, var)
end
