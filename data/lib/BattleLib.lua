_Lib_Battle_Info = {
Reward = {2160,50},
TeamOne = {name = "Madara Team", storage = 140120, pos = {x=1140,y=1511,z=7}},
TeamTwo = {name = "Hashirama Team",storage = 140121,pos = {x=1207,y=1511,z=7}},
storage_count = 180400,
tpPos = {x=1021, y=921, z=7},
limit_Time = 10 -- em minutos
}

function resetBattle()
return setGlobalStorageValue(_Lib_Battle_Info.TeamOne.storage, 0) and setGlobalStorageValue(_Lib_Battle_Info.TeamTwo.storage, 0)
end

function OpenWallBattle()
local B = {
{8538,{x=1174, y=1509, z=7, stackpos = 1}},
{8538,{x=1174, y=1510, z=7, stackpos = 1}},
{8538,{x=1174, y=1511, z=7, stackpos = 1}},
{8538,{x=1174, y=1512, z=7, stackpos = 1}}
}
for i = 1, #B do
if getTileItemById(B[i][2], B[i][1]).uid == 0 then
doCreateItem(B[i][1], 1, B[i][2])
else
doRemoveItem(getThingfromPos(B[i][2]).uid,1)
end
end
end

function doBroadCastBattle(type,msg)
local players = {}
for _, cid in pairs(getPlayersOnline()) do
if getPlayerStorageValue(cid, _Lib_Battle_Info.TeamOne.storage) == 1 or getPlayerStorageValue(cid, _Lib_Battle_Info.TeamTwo.storage) == 1 then
table.insert(players, cid)
end
end
for i = 1, #players do
doPlayerSendTextMessage(players[i],type,msg)
end
end

function removeBattleTp()
local t = getTileItemById(_Lib_Battle_Info.tpPos, 1387).uid
return t > 0 and doRemoveItem(t) and doSendMagicEffect(_Lib_Battle_Info.tpPos, CONST_ME_POFF)
end

function getWinnersBattle(storage)
local players,str = {},""
for _, cid in pairs(getPlayersOnline()) do
if getPlayerStorageValue(cid, storage) == 1 then
table.insert(players, cid)
end
end
str = str .. ""..#players.." Player"..(#players > 1 and "s" or "").." from team "..(getGlobalStorageValue(_Lib_Battle_Info.TeamOne.storage) == 0 and _Lib_Battle_Info.TeamTwo.name or _Lib_Battle_Info.TeamOne.name).." won the event battlefield, they received a ".._Lib_Battle_Info.Reward[2].." "..getItemNameById(_Lib_Battle_Info.Reward[1]).."!"
for i = 1, #players do
doPlayerAddItem(players[i], _Lib_Battle_Info.Reward[1], _Lib_Battle_Info.Reward[2])
doRemoveCondition(players[i], CONDITION_OUTFIT)
doTeleportThing(players[i], getTownTemplePosition(getPlayerTown(players[i])))
setPlayerStorageValue(players[i], storage, -1)
end
resetBattle()
OpenWallBattle()
return doBroadcastMessage(str)
end

function CheckEvent(delay)
if delay > 0 and getGlobalStorageValue(_Lib_Battle_Info.storage_count) > 0 then
doBroadcastMessage("[BattleField Event] We are waiting "..getGlobalStorageValue(_Lib_Battle_Info.storage_count).." players to Battlefield starts")
elseif delay == 0 and getGlobalStorageValue(_Lib_Battle_Info.storage_count) > 0 then
local players = {}
for _, cid in pairs(getPlayersOnline()) do
if getPlayerStorageValue(cid, _Lib_Battle_Info.TeamOne.storage) == 1 or getPlayerStorageValue(cid, _Lib_Battle_Info.TeamTwo.storage) == 1 then
table.insert(players, cid)
end
end
for i = 1, #players do
doRemoveCondition(players[i], CONDITION_OUTFIT)
doTeleportThing(players[i], getTownTemplePosition(getPlayerTown(players[i])))
setPlayerStorageValue(players[i], getPlayerStorageValue(players[i], _Lib_Battle_Info.TeamOne.storage) == 1 and _Lib_Battle_Info.TeamOne.storage or _Lib_Battle_Info.TeamTwo.storage, -1)
end
doBroadcastMessage("The event cannot be started because not had enough players.")
setGlobalStorageValue(_Lib_Battle_Info.storage_count, 0)
resetBattle()
removeBattleTp()
end
addEvent(CheckEvent, 60000, delay-1)
end