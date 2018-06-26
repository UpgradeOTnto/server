---> Quest System by: Dknight <---

local completed = 10010 -- Storage da Quest Completa
local rank = 7000 -- Rank S
local premio = 11460 -- Premio
local premio2 = 11403
local premio3 = 11466

local config = {
    msg = "Congratulations, you have completed the Quest Madara [Rank S +1]",
}

function onUse(cid, item, fromPosition, itemEx, toPosition)

	if getPlayerStorageValue(cid, completed) >= 0 then
		return doPlayerSendCancel(cid, "You already got your prize.")
	end

	doPlayerAddItem(cid, premio, 1)
	doPlayerAddItem(cid, premio2, 1)
	doPlayerAddItem(cid, premio3, 1)
	doPlayerSendTextMessage(cid,22, config.msg)
	setPlayerStorageValue(cid, completed, 1)
	setPlayerStorageValue(cid, rank, getPlayerStorageValue(cid, rank)+1)
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "Congratulations, you have completed "..getPlayerStorageValue(cid, rank).." Mission Rank S!")
end
