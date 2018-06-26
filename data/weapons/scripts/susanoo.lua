local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatFormula(combat, COMBAT_FORMULA_SKILL, 1, 0, 1, 0)
function onGetFormulaValues(cid, level)
local danoporlevel = 0.9
local min = -((level*danoporlevel)+5)
local max = -((level*danoporlevel)+5)
return min, max
end
setCombatCallback(combat, CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")
function onUseWeapon(cid, var)
local position1 = {x=getThingPosition(getCreatureTarget(cid)).x+0, y=getThingPosition(getCreatureTarget(cid)).y+0, z=getThingPosition(getCreatureTarget(cid)).z}
doSendMagicEffect(position1, 44)
return doCombat(cid, combat, var)
end