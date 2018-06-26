---> Quest System by: Dknight <---

local completed = 3000 -- Storage da Quest Completa
local rank = 7000 -- Rank S
local config = {
    msg = "Voce pegou seu itens iniciais",
}

function onUse(cid, item, fromPosition, itemEx, toPosition)

	if getPlayerStorageValue(cid, completed) >= 0 then
		return doPlayerSendCancel(cid, "You already got your prize.")
	end

	doPlayerAddItem(cid, 1988, 1)
	doPlayerAddItem(cid, 11389, 1)
	doPlayerAddItem(cid, 11395, 1)
	doPlayerAddItem(cid, 11404, 1)
	doPlayerAddItem(cid, 11411, 1)
	doPlayerAddItem(cid, 11441, 1)
	doPlayerAddItem(cid, 2160, 10)
	doPlayerSendTextMessage(cid,22, config.msg)
	setPlayerStorageValue(cid, completed, 1)
	setPlayerStorageValue(cid, rank, getPlayerStorageValue(cid, rank)+1)
end
