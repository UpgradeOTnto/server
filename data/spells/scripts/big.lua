local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, 34)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -0.9, 1, -1.8, 1)

function onCastSpell(cid, var)
return doCombat(cid, combat, var)
end
