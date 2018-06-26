--###################################
--## Developed by: MaXwEllDeN ##
--## Contact:  ##
--##  maxwellmda@gmail.com ##
--###################################
 
local quests = {
   -- [" Nome da quest "] = Storageid,
   ["Akatsuki Sasori"] = 10000,
   ["Akatsuki Deidara"] = 10001,
   ["Akatsuki Kisame"] = 10002,
   ["Akatsuki Itachi"] = 10003,
   ["Akatsuki Hidan"] = 10004,
   ["Akatsuki Kakuzu"] = 10005,
   ["Akatsuki Konan"] = 10006,
   ["Akatsuki Nagato"] = 10007,
   ["Akatsuki Tobi"] = 10008,
   ["Rinnegan Obito"] = 10011,
   ["Madara"] = 10010,

}
 
function onSay(cid)
   local str = "#Mission(s) nao concluida(s):\n"
   local conc = {}
 
   for i, v in pairs(quests) do
      if getPlayerStorageValue(cid, v) > 0 then
         table.insert(conc, i)
      else
         str = str .. "\n".. i .. " - Nao concluida"
      end
   end
 
   str = str .. "\n\n#Mission(s) concluida(s):\n"
 
   for _, v in pairs(conc) do
      str = str .. "\n".. v .. " - Concluida"
   end
 
   return doShowTextDialog(cid, 1746, str)
end