local config = {
-- Helmets
	["anbu mask"] = {id = 11392, sell = 'yes 12000', buy = 'no' },
	["elite anbu mask"] = {id = 11393, sell = 'yes 66000', buy = 'no' },
	["akatsuki hat"] = {id = 11394, sell = 'yes 120000', buy = 'no' },
-- Roupas
	["chakra armor"] = {id = 11399, sell = 'yes 12000', buy = 'no' },
	["anbu armor"] = {id = 11398, sell = 'yes 66000', buy = 'no' },
	["akatsuki robe"] = {id = 11402, sell = 'yes 120000', buy = 'no' },
-- Legs
	["elite legs"] = {id = 11408, sell = 'yes 120000', buy = 'no' },
-- Botas
	["speed boots"] = {id = 11412, sell = 'yes 12000', buy = 'no' },
	["black boots"] = {id = 11413, sell = 'yes 24000', buy = 'no' },
	["kage boots"] = {id = 11414, sell = 'yes 48000', buy = 'no' },
	["akatsuki sandals"] = {id = 11415, sell = 'yes 120000', buy = 'no' },
-- Luvas
	["elite taijutsu glove"] = {id = 11434, sell = 'yes 12000', buy = 'no' },
	["jounin glove"] = {id = 11435, sell = 'yes 24000', buy = 'no' },
	["sound glove"] = {id = 11436, sell = 'yes 48000', buy = 'no' },
	["crystal gloves"] = {id = 11437, sell = 'yes 66000', buy = 'no' },
	["shaolin gloves"] = {id = 11438, sell = 'yes 120000', buy = 'no' },
-- Espadas
	["knuckle duster"] = {id = 11442, sell = 'yes 12000', buy = 'no' },
	["chakra sword"] = {id = 11447, sell = 'yes 24000', buy = 'no' },
	["third scythe"] = {id = 11448, sell = 'yes 48000', buy = 'no' },
	["shark absorb sword"] = {id = 11449, sell = 'yes 66000', buy = 'no' },
	["chakra eletric katana"] = {id = 11450, sell = 'yes 120000', buy = 'no' }
}

function upperfirst(first, rest)
	return first:upper()..rest:lower()
end

function onSay(cid, words, param, channel)

	if (param == nil or param == '' or param == 'lista' or param == 'list') then
		if (words == "!sell" or words == "/sell") then
			str = "Items que voce pode vender:\n\n"
		else
			str = "Items que voce pode comprar:\n\n"
		end
		for item, vars in pairs(config) do
			if (words == "!sell" or words == "/sell") then
				expl = string.explode(vars.sell, " ")
			else
				expl = string.explode(vars.buy, " ")
			end
			item = item:gsub("(%a)([%w_']*)", upperfirst)
			if (expl[1] == 'no') then
				str = str
			else
				str = str .. item.. " - " .. expl[2] .. " gps\n"
			end
		end
		return doShowTextDialog(cid, 2160, str)
	end
	local item = config[param:lower()]
	param = param:lower()
	if (item) then
		local sell = string.explode(item.sell, " ")
		local buy = string.explode(item.buy, " ")
		if (words == "!sell" or words == "/sell") then
			if (sell[1] == "yes") then
				if (doPlayerRemoveItem(cid, item.id, 1)) then
					doPlayerAddMoney(cid, sell[2])
					doSendMagicEffect(getPlayerPosition(cid), 30)
					return doPlayerSendTextMessage(cid,29,"Aqui esta, voce vendeu  "..param.." por "..sell[2].." gold coins.")
				else
					doSendMagicEffect(getPlayerPosition(cid), 2)
					return doPlayerSendTextMessage(cid,29,"Você não tem nenhum "..param.." para vender.")
				end
			else
				doSendMagicEffect(getPlayerPosition(cid), 2)
				return doPlayerSendTextMessage(cid,29,"Desculpe, "..param.." esse item nao pode ser vendido.")
			end
		else
			if (buy[1] == "yes") then
				if (doPlayerRemoveMoney(cid, buy[2])) then
					doPlayerAddItem(cid, item.id)
					doSendMagicEffect(getPlayerPosition(cid), 28)
					return doPlayerSendTextMessage(cid,29,"Here are, you bought "..param.." for "..buy[2].." gold coins.")
				else
					doSendMagicEffect(getPlayerPosition(cid), 2)
					return doPlayerSendTextMessage(cid,29,"You don't have enough money.")
				end
			else
				doSendMagicEffect(getPlayerPosition(cid), 2)
				return doPlayerSendTextMessage(cid,29,"Sorry, "..param.." cannot be bought.")
			end
		end

	else
		doSendMagicEffect(getPlayerPosition(cid), 2)
		if (words == "!sell") then
			return doPlayerSendTextMessage(cid,29,"Desculpe, este item não pode ser vendido ou não existe.")	
		else
			return doPlayerSendTextMessage(cid,29,"Desculpe, este item não pode ser comprado ou não existe.")	
		end
	end
end	