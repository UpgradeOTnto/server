-- Premium Scroll
-- By: Reborn

local pdays = 30 -- Dias de Premium que ira ganhar

	function onUse(cid, item, fromPosition, itemEx, toPosition)

			doPlayerAddPremiumDays(cid, pdays)
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You have bought " .. pdays .. " days of premium account.")
		    doSendMagicEffect(getCreaturePosition(cid), CONST_ME_MAGIC_RED)
			doRemoveItem(item.uid, 1)
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You will disconnect in 5 seconds.")
			addEvent(doRemoveCreature, 1500, cid)
end
