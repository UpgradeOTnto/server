local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 193)
setAttackFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -4.2, 1, -5.2, 1)

local area = createCombatArea(AREA_WAVE4, AREADIAGONAL_WAVE4)
setCombatArea(combat, area)

function onCastSpell(cid, var)
	return doCombat(cid, combat, var)
end
