function onSay(cid, words, param)
   if doPlayerRemoveMoney(cid, 20000) then
      doPlayerAddItem(cid, 2173, 1)
      doSendMagicEffect(getThingPos(cid),13)
      doCreatureSay(cid, "Voce comprou um AOL!", TALKTYPE_ORANGE_1)
   else
      doPlayerSendCancel(cid, "Você não tem dinheiro suficiente para comprar uma AOL.")
      doSendMagicEffect(getThingPos(cid), 2)
   end
  return true
end