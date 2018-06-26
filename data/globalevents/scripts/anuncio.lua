-- [( Script created by Matheus for TibiaKing.com )] --
function onThink(interval, lastExecution)
MENSAGEM = {
"Voce pode ajudar o servidor efetuando uma doacao :), acesse: http://ntowhiteonline.weebly.com/donate.html",
"Voce pode ver o mapa do servidor acessando: http://ntowhiteonline.weebly.com/mapa.html",
"Voce pode ver quais missions voce fez usando o comando !missions",
"Voce pode compar um Amulet of loss usando o comando !jam ou !aol",
"Voce pode ajudar o servidor efetuando uma doacao :), acesse: http://ntowhiteonline.weebly.com/donate.html",
"Voce pode vender seu loot usando o comando !sell, ex !sell akatsuki robe",
"Voce pode ver quais missions voce fez usando o comando !missions",
"Voce pode descobrir aonde fica os Bosses usando as alavancas na sala de Quests",
"Voce pode viajar de ilha em ilha usando o npc Yoshi",
"Voce pode ver quais missions voce fez usando o comando !missions",
"Voce pode viajar de ilha em ilha usando o npc Yoshi",
"Voce pode ver quais missions voce fez usando o comando !missions",
}
doBroadcastMessage(MENSAGEM[math.random(1,#MENSAGEM)],22)
return TRUE
end