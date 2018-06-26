local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_ENERGYHIT)
setAttackFormula(combat, COMBAT_FORMULA_LEVELMAGIC, 5, 5, 4, 7)

local area = createCombatArea(AREA_BEAM7, AREADIAGONAL_BEAM7)
setCombatArea(combat, area)

function onCastSpell(cid, var)
	if getCreatureLookDir(cid) == 0 then
		addEvent(doAreaCombatHealth, 600, cid, COMBAT_FIREDAMAGE, find_area, KATON, dmg, dmg, 255)
		addEvent(doSendMagicEffect, 600, {x = pos.x+1, y = pos.y-1, z = pos.z}, 17)
	elseif getCreatureLookDir(cid) == 1 then
		addEvent(doAreaCombatHealth, 600, cid, COMBAT_FIREDAMAGE, find_area, KATON, dmg, dmg, 255)
		addEvent(doSendMagicEffect, 600, {x = pos.x+5, y = pos.y+1, z = pos.z}, 18)
	elseif getCreatureLookDir(cid) == 2 then
		addEvent(doAreaCombatHealth, 600, cid, COMBAT_FIREDAMAGE, find_area, KATON, dmg, dmg, 255)
		addEvent(doSendMagicEffect, 600, {x = pos.x+1, y = pos.y+5, z = pos.z}, 19)
	elseif getCreatureLookDir(cid) == 3 then
		addEvent(doAreaCombatHealth, 600, cid, COMBAT_FIREDAMAGE, find_area, KATON, dmg, dmg, 255)
		addEvent(doSendMagicEffect, 600, {x = pos.x-1, y = pos.y+1, z = pos.z}, 16)
	return doCombat(cid, combat, var)
end
