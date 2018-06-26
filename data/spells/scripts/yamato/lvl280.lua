local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 67)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, 2)
setCombatParam(combat, COMBAT_PARAM_CREATEITEM, 4035)
local arr = {
{ 0, 1, 1, 1, 1, 0. },
{ 1, 1, 0, 0, 1, 1. },
{ 1, 0, 0, 0, 0, 1, },
{ 1, 0, 0, 2, 0, 1, },
{ 1, 0, 0, 0, 0, 1, },
{ 1, 1, 0, 0, 1, 1, },
{ 0, 1, 1, 1, 1, 0, },
}
local area = createCombatArea(arr)
setCombatArea(combat, area)

function onCastSpell(cid, var)
local waittime = 1 -- Tempo de exhaustion
local storage = 115818

if exhaustion.check(cid, storage) then
    doPlayerSendCancel(cid, "You are exhausted")
return false
end
exhaustion.set(cid, storage, waittime)
return doCombat(cid, combat, var)
end