function onThink(interval, lastExecution)
_Lib_Battle_Days = {
["Monday"] = {
["20:30"] = {players = 30}
},
["Wednesday"] = {
["20:30"] = {players = 30}
},
["Friday"] = {
["20:30"] = {players = 30}
},
["Saturday"] = {
["20:50"] = {players = 20}
}
}
if _Lib_Battle_Days[os.date("%A")] then
hours = tostring(os.date("%X")):sub(1, 5)
tb = _Lib_Battle_Days[os.date("%A")][hours]
if tb and (tb.players % 2 == 0) then
local tp = doCreateItem(1387, 1, _Lib_Battle_Info.tpPos)
doItemSetAttribute(tp, "aid", 45000)
CheckEvent(_Lib_Battle_Info.limit_Time)
doBroadcastMessage("The event BattleField was opened and We are waiting "..tb.players.." Players! Team divided into "..((tb.players)/2).." VS "..((tb.players)/2))
return setGlobalStorageValue(_Lib_Battle_Info.storage_count, tb.players)
end
end
return true
end