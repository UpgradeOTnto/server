function onCastSpell(cid, var)
local from,to = {x=962, y=885, z=7},{x=973, y=892, z=7} -- come�o e final do mapa
local from2,to2 = {x=979, y=901, z=7},{x=991, y=905, z=7} -- come�o e final do mapa
local playerpos = getPlayerPosition(cid)
local cloth = getCreatureOutfit(cid)
local health = getCreatureHealth(cid)
local maxhealth = getCreatureMaxHealth(cid)
local MaximoSummon = 1 --- Maximo de Monstros Sumonados!! No Caso So Posso Sumonar 5 Clones

local summons = getCreatureSummons(cid)
if isInRange(getCreaturePosition(cid), from, to) or isInRange(getCreaturePosition(cid), from2, to2) then
doPlayerSendCancel(cid, "Voc� n�o pode usar esse jutsu aqui!") return true
end
if(table.maxn(summons) < MaximoSummon) then -- no summons
local Fuuton = doCreateMonster("Fuuton Mask", playerpos)
local Raiton = doCreateMonster("Raiton Mask", playerpos)
local Katon = doCreateMonster("Katon Mask", playerpos)
doConvinceCreature(cid, Fuuton)
doConvinceCreature(cid, Raiton)
doConvinceCreature(cid, Katon)
setCreatureMaxHealth(Fuuton, 500)
setCreatureMaxHealth(Raiton, 500)
setCreatureMaxHealth(Katon, 500)
doCreatureAddHealth(Fuuton, 500)
doCreatureAddHealth(Raiton, 500)
doCreatureAddHealth(Katon, 500)
return TRUE
end
end