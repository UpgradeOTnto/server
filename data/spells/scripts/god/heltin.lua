local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -300.8, 1, -300.2, 1)

function onCastSpell(cid, var)
local waittime = 1 -- Tempo de exhaustion
local storage = 115818

if exhaustion.check(cid, storage) then
    doPlayerSendCancel(cid, "You are exhausted")
return false
end
local position1 = {x=getThingPosition(getCreatureTarget(cid)).x+0, y=getThingPosition(getCreatureTarget(cid)).y, z=getThingPosition(getCreatureTarget(cid)).z}
doSendMagicEffect(position1, 48)
exhaustion.set(cid, storage, waittime)
return doCombat(cid, combat, var)
end
