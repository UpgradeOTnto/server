-- Start Config --
local ranks = 7000
local completed = 10010 -- Storage da Quest Completa
local pos = {x=1546, y=1024, z=7}

function onUse(cid, item, fromPosition, itemEx, toPosition)

if getPlayerStorageValue(cid, ranks) >= 3 then
   doTeleportThing(cid, pos)
 else
  doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Voce nao possui 3 mission Rank S, digite !missions.")
 end
end