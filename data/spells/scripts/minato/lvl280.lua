local config = {
storage = 49708, -- storage que sera utilizado, deixe igual no login.lua
tempo = 5, --- tempo até teleportar para o player
effectuse = 33, --- efeito ao usar a spell (aparece no player e no target)
effectdamage = 33   --- efeito ao desferir o golpe
}


local exception = {"Gamabunta", "Training Monk", "Itachi"}


function onCastSpell(cid, var)
local name = getCreatureName(getCreatureTarget(cid))
if not isInArray(exception, name) then
if getPlayerStorageValue(cid, config.storage) <= 0 then
doPlayerSetStorageValue(cid, config.storage, 1)
doSendMagicEffect(getThingPos(cid), config.effectuse)
doSendMagicEffect(getThingPos(variantToNumber(var)), config.effectuse)
addEvent(function()
  if isCreature(cid) then
  doPlayerSetStorageValue(cid, config.storage, 0)
  doTeleportThing(cid, getThingPos(variantToNumber(var)), true)
  arr = {3}
  doAreaCombatHealth(cid, 1, getThingPos(variantToNumber(var)), arr, -getPlayerLevel(cid), -2*(getPlayerLevel(cid)), config.effectdamage)    
  end
 end, 1000*config.tempo)
elseif getPlayerStorageValue (cid, config.storage) > 0 then
doSendMagicEffect(getThingPos(cid), 2)
doPlayerSendCancel(cid, "You've already set your target.")
end
else
doPlayerSendCancel (cid, "You can't use this spell in this creature.")
return false
end
return true
end