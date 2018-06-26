local config = {
health = 8000,
mana = 25000
}


function onCastSpell(cid, var)

if getCreatureMaster(cid) then
local master = getCreatureMaster(cid)
	if isInParty(master) then
		local members = getPartyMembers(getPlayerParty(master))
		local health = math.ceil( config.health / #members )
		local mana = math.ceil( config.mana / #members )
		for i = 1, #members do
		doCreatureAddHealth(members[i], health)
		doCreatureAddMana(members[i], mana)
		doSendAnimatedText(getCreaturePosition(members[i]), "+"..health, 240)	
		doSendMagicEffect(getCreaturePosition(members[i]), 36)		
		end
	else
		doCreatureAddHealth(master, config.health)
		doCreatureAddMana(master, config.mana)
		doSendAnimatedText(getCreaturePosition(master), "+"..config.health, 240)		
		doSendMagicEffect(getCreaturePosition(master), 36)	
	end

	end

return true
end