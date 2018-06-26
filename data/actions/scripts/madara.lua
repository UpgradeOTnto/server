function onUse(cid, item, fromPosition, itemEx, toPosition)

local waittime = 1 -- Tempo de exhaustion
local storage = 115818

if exhaustion.check(cid, storage) then
    doPlayerSendCancel(cid, "You are exhausted")
return false
end

local vocation = 250
doPlayerSetVocation(cid, vocation)
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "Congratulations, voce agora e um Madara")
doRemoveItem(item.uid, 1) 
end
