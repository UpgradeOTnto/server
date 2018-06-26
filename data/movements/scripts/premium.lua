local npos = {x=1022, y=908, z=6} --- posição para onde sera teleportado
function onStepIn(cid, item, position, fromPosition, toPosition)
if isPremium(cid) then
doTeleportThing(cid, npos)
doSendMagicEffect(npos,10)
else
doTeleportThing(cid, fromPosition)
doPlayerSendCancel(cid, "Você não é premium.")
end
return true
end