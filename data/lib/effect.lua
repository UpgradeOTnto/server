local effsTortos = {
   --[eff] = {valores para corrigi-los},
   [175] = {x= 1, y= 0}, --naruto
   [148] = {x= 1, y= 0}, --sasuke
   [151] = {x= 1, y= 1}, --lee
   [124] = {x= 1, y= 1}, --neji
   [184] = {x= 1, y= 0}, --tenten
   [183] = {x= 1, y= 0}, --itachi
   [57] = {x= 1, y= 1}, --kisame
   [11] = {x= 1, y= 1}, --hidan
   [20] = {x= 1, y= 1}, --bee
   [185] = {x= 1, y= 0}, --madara
   [18] = {x= 0, y= 0}, --kankuro
   [141] = {x= 1, y= 1}, --gaara
   [23] = {x= 0, y= -1},
}
function repeatEff(cid, eff, tempo)
   if not isCreature(cid) or tempo == 0 then return end
   local p = getThingPos(cid)
   if effsTortos[eff] then
      p = {x= p.x+(effsTortos[eff].x), y= p.y+(effsTortos[eff].y), z= p.z}
   end
   doSendMagicEffect(p, eff)
   addEvent(repeatEff, 500, cid, eff, tempo-1)
end
