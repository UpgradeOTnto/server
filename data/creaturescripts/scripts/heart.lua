function onDeath(cid, corpse, deathList)

function getHeartFromNivel(cid)

local t = {

[{350,800}] = 5943,

[{2001,3000}] = 2353,

[{3001,4000}] = 1685,

[{4001,5000}] = 11361,

[{5001,6000}] = 10552,

[{6001,math.huge}] = 10577

}

for var, ret in pairs(t) do

if getPlayerLevel(cid) >= var[1] and getPlayerLevel(cid) <= var[2] then

k  = ret

end

end

return k

end

if isPlayer(cid) and getPlayerLevel(cid) >= 350 and isPlayer(deathList[1]) then

local item = getHeartFromNivel(cid)

doItemSetAttribute(doPlayerAddItem(deathList[1],item, 1), "description", "This is the heart of "..getPlayerName(cid).." killed at Level "..getPlayerLevel(cid).." by "..getPlayerName(deathList[1])..".")

if getPlayerLevel(cid) >= 350 then

doBroadcastMessage("O Jogador ".. getCreatureName(deathList[1]) .. "[" .. getPlayerLevel(deathList[1]) .. "] Matou " .. getCreatureName(cid) .. "[" .. getPlayerLevel(cid) .. "] E retirou seu "..getItemNameById(item),18)

end

doSendMagicEffect(getPlayerPosition(deathList[1]), 12)

end

return true

end