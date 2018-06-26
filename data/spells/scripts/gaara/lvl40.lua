local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, 19)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -1.2, 1, -2.0, 1)

function onCastSpell(cid, var)
return doCombat(cid, combat, var)
end
