function onLogin(cid)
if getPlayerGroupId(cid) >= 3 then
doBroadcastMessage("Staff [".. getCreatureName(cid).."] Entrou no Servidor")
end
return true
end