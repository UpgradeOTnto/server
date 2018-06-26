function onCastSpell(cid, var)
local cloth = getCreatureOutfit(cid)
local health = 350
local maxhealth = 350
local MaximoSummon = 4
 
local summons = getCreatureSummons(cid)
if(table.maxn(summons) < MaximoSummon) then 
 
 local pos = getPlayerPosition(cid)
 local bpos = {
 {x=pos.x+1, y = pos.y, z = pos.z},
 {x=pos.x-1, y = pos.y, z = pos.z},
 {x=pos.x+0, y = pos.y+1, z = pos.z}, 
 {x=pos.x+0, y = pos.y-1, z = pos.z} 
 } 
 
for i = 1, (#bpos - table.maxn(summons)) do 
local Bunshin = doCreateMonster("Mokuton Bunshin", bpos[i])
doConvinceCreature(cid, Bunshin)
setCreatureMaxHealth(Bunshin, maxhealth)
doCreatureAddHealth(Bunshin, health)
doSetCreatureOutfit(Bunshin, cloth, -1)
local pos = getCreaturePosition(cid)
addEvent(doSendMagicEffect, 1, {x = pos.x+1, y = pos.y+0, z = pos.z}, 111)
end
return true
end
end