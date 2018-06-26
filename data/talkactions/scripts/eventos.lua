-- Start Config --
local quiz1 = 11469
local quiz2 = 2160

-- Start Config --
local pvp1 = 11462
local bag1 = 2000
local bag2 = 11403



function onSay(cid, words, param, channel)

		if (words == "!eventoquiz" or words == "/eventoquiz") then
			doPlayerAddItem(cid, quiz1, 1)
			doPlayerAddItem(cid, quiz2, 25)
		end

		if (words == "!eventopvp" or words == "/eventopvp") then
			doPlayerAddItem(cid, pvp1, 1)
		end

		if (words == "!eventobag" or words == "/eventobag") then
			doPlayerAddItem(cid, bag1, 1)
			doPlayerAddItem(cid, bag2, 1)
		end
end