local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, 3)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, false)

local condition = createConditionObject(CONDITION_HASTE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 32000)
setConditionFormula(condition, 0.5, -20, 0.6, -20)
setCombatCondition(combat, condition)

function onCastSpell(cid, var)
	return doCombat(cid, combat, var)
end