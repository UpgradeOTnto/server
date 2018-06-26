local tpId = 1387
local tps = {
    ["Kisame"] = {pos = {x=1296, y=984, z=6}, toPos = {x=1319, y=985, z=6}, time = 15},
}

function removeTp(tp)
    local t = getTileItemById(tp.pos, tpId)
    if t then
        doRemoveItem(t.uid, 1)
        doSendMagicEffect(tp.pos, CONST_ME_POFF)
    end
end

function onDeath(cid)
    local tp = tps[getCreatureName(cid)]
    if tp then
        doCreateTeleport(tpId, tp.toPos, tp.pos)
        doCreatureSay(cid, "O teleport irá sumir em "..tp.time.." segundos.", TALKTYPE_ORANGE_1)
        addEvent(removeTp, tp.time*1000, tp)
    end
    return TRUE
end