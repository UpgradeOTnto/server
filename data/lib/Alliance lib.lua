function removeHealth(cid, percent, time, storage)
	if not isCreature(cid) then
	local remove = percent
		return true
	end

	if (getPlayerStorageValue(cid, storage) < 1) then
		doCreatureAddHealth(cid, percent)
		addEvent(removeHealth, time*1000, cid, percent, time, storage)
		doSendAnimatedText(getCreaturePosition(cid), remove, COLOR_RED)
	end
end

function removerHealth(cid, percent, time, storage)
	if not isCreature(cid) then
	local remove = percent
		return true
	end

	if (getPlayerStorageValue(cid, storage) < 1) then
		doCreatureAddHealth(cid, -percent)
		addEvent(removerHealth, time*1000, cid, -percent, time, storage)
		doSendAnimatedText(getCreaturePosition(cid), -remove, COLOR_RED)
	end
end

function removeChakra(cid, percent, time, storage, type)
 local remove = percent
 if not isCreature(cid) then
  return true
 end

 if (getCreatureStorage(cid, storage) < 1) then
  if type == "none" then
   doCreatureAddMana(cid, remove)
  elseif type == "add" then
   doCreatureAddMana(cid, remove)
   doSendMagicEffect(getCreaturePosition(cid),7)
  elseif type == "remover" then
   if getCreatureMana(cid) > remove then
    doCreatureAddMana(cid, -remove)
   else
    doCreatureAddMana(cid, -remove)
    doCreatureAddHealth(cid, -remove)
    doSendAnimatedText(getCreaturePosition(cid), remove, COLOR_RED)
   end
  else
   doCreatureAddMana(cid, remove)
  end
  addEvent(removeChakra, time*1000, cid, remove, time, storage, type)
 end
end