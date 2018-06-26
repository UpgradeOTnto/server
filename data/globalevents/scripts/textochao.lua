local config = {
    positions = {
        ["Shop"] = { x = 1026, y = 908, z = 6 },
        ["Premium"] = { x = 1050, y = 843, z = 7 },	
        ["Vocations"] = { x = 1055, y = 843, z = 7 },	
        ["Armors"] = { x = 1053, y = 843, z = 6 },	
        ["Weapons"] = { x = 1053, y = 843, z = 5 },	
        ["ArenaPvP"] = { x = 1019, y = 912, z = 7 },
        ["Madara"] = { x = 1019, y = 909, z = 7 },
	
        ["Quests"] = { x = 1027, y = 908, z = 6 },
        ["Area Vip"] = { x = 1022, y = 908, z = 6 },	
        ["GuildZone"] = { x = 1031, y = 908, z = 6 },	
        ["RemovePZ"] = { x = 1027, y = 914, z = 7 },	
        ["Trainer"] = { x = 1013, y = 925, z = 6 },	

        ["Tsukuyomi"] = { x = 1081, y = 860, z = 7 },
        ["Deidara"] = { x = 1089, y = 861, z = 7 },
        ["Itachi"] = { x = 1091, y = 861, z = 7 },
        ["Sasori"] = { x = 1093, y = 861, z = 7 },
        ["Kisame"] = { x = 1095, y = 861, z = 7 },
        ["Nagato"] = { x = 1085, y = 866, z = 7 },

        ["Konoha"] = { x = 1466, y = 761, z = 7 },
    }
}

function onThink(cid, interval, lastExecution)
    for text, pos in pairs(config.positions) do
        doSendAnimatedText(pos, text, math.random(1, 255))
    end
    
    return TRUE
end  