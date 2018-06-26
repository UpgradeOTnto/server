function onCastSpell(cid, var)
local cloth = getCreatureOutfit(cid)
local health = 150000
local maxhealth = 150000
local MaximoSummon = 1
 
local summons = getCreatureSummons(cid)
if(table.maxn(summons) < MaximoSummon) then 
 
 local pos = getPlayerPosition(cid)
 local bpos = {
 {x=pos.x+1, y = pos.y, z = pos.z}
 } 
 
for i = 1, (#bpos - table.maxn(summons)) do 
local Bunshin = doCreateMonster("Summon Sasori", bpos[i])
doConvinceCreature(cid, Bunshin)
setCreatureMaxHealth(Bunshin, maxhealth)
doCreatureAddHealth(Bunshin, health)
local pos = getCreaturePosition(cid)
addEvent(doSendMagicEffect, 1, {x = pos.x+1, y = pos.y+0, z = pos.z}, 111)
end
return true
end
end