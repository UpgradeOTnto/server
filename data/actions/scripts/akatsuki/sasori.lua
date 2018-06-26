---> Quest System by: Dknight <---

local completed = 10000 -- Storage da Quest Completa
local rank = 7000 -- Rank S
local premio = 11408 -- Premio

local config = {
    msg = "Congratulations, you have completed the Quest Sasori [Rank S +1]",
}

function onUse(cid, item, fromPosition, itemEx, toPosition)

	if getPlayerStorageValue(cid, completed) >= 0 then
		return doPlayerSendCancel(cid, "You already got your prize.")
	end

	doPlayerAddItem(cid, premio, 1)
	doPlayerSendTextMessage(cid,22, config.msg)
	setPlayerStorageValue(cid, completed, 1)
	setPlayerStorageValue(cid, rank, getPlayerStorageValue(cid, rank)+1)
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "Congratulations, you have completed "..getPlayerStorageValue(cid, rank).." Mission Rank S!")
end
