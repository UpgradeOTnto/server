local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, 22)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -1.2, 1, -2.2, 1)

function onCastSpell(cid, var)
return doCombat(cid, combat, var)
end
