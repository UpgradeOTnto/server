-- Start Config --
local item = 11438
 
function onUse(cid)

 if(getPlayerItemCount(cid, 5943) >= 7) then
   doPlayerRemoveItem(cid, 5943, 7)
   doPlayerAddItem(cid, item, 1)
  doPlayerSendTextMessage(cid,20,"Parabens voce ganhou uma 1 Shaolin Gloves.") -- Mude o NAME para o nome do local que o player será teleportado.
 else
  doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Voce nao tem 7 Coracoes.")
 end
end