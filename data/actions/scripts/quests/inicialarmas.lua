---> Quest System by: Dknight <---

local completed = 3001 -- Storage da Quest Completa

local config = {
    msg = "Voce pegou suas armas iniciais",
}

function onUse(cid, item, fromPosition, itemEx, toPosition)

	if getPlayerStorageValue(cid, completed) >= 0 then
		return doPlayerSendCancel(cid, "You already got your prize.")
	end

	doPlayerAddItem(cid, 11441, 1)
	doPlayerAddItem(cid, 11443, 1)
	doPlayerSendTextMessage(cid,22, config.msg)
	setPlayerStorageValue(cid, completed, 1)
end
