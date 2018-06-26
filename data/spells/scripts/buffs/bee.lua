local tempo = 60 -- tempo em segundos.
     
local ml = 15 -- quantos ira aumentar o skill de ML
local skillfist = 0 -- quantos ira aumentar o skill de Fist
local skillsword = 15 -- quantos ira aumentar o skill de Sword
local skillaxe = 0 -- quantos ira aumentar o skill de Axe
local skillclub = 15 -- quantos ira aumentar o skill de Club
local skilldistance = 0 -- quantos ira aumentar o skill de Distance
local skillshield = 0 -- quantos ira aumentar o skill de Shield
local health = 25 -- A cada 1 segundo quantos aumentar de vida
local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, 0)
     
local condition = createConditionObject(CONDITION_ATTRIBUTES)
setConditionParam(condition, CONDITION_PARAM_TICKS, tempo*1000)
setConditionParam(condition, CONDITION_PARAM_STAT_MAGICLEVEL, ml)
setConditionParam(condition, CONDITION_PARAM_SKILL_FIST, skillfist)
setConditionParam(condition, CONDITION_PARAM_SKILL_SWORD, skillsword)
setConditionParam(condition, CONDITION_PARAM_SKILL_AXE, skillaxe)
setConditionParam(condition, CONDITION_PARAM_SKILL_CLUB, skillclub)
setConditionParam(condition, CONDITION_PARAM_SKILL_DISTANCE, skilldistance)
setConditionParam(condition, CONDITION_PARAM_SKILL_SHIELD, skillshield)
setConditionParam(condition, CONDITION_PARAM_OUTFIT, outfit)
setCombatCondition(combat, condition)
     
local condition = createConditionObject(CONDITION_HASTE)
setConditionParam(condition, CONDITION_PARAM_SPEED, 300)
setConditionParam(condition, CONDITION_PARAM_TICKS, tempo*1000)
setConditionParam(condition, CONDITION_PARAM_BUFF, TRUE)
setCombatCondition(combat, condition)
     
local condition = createConditionObject(CONDITION_REGENERATION)
setConditionParam(condition, CONDITION_PARAM_SUBID, 1)
setConditionParam(condition, CONDITION_PARAM_BUFF, TRUE)
setConditionParam(condition, CONDITION_PARAM_TICKS, tempo*1000)
setConditionParam(condition, CONDITION_PARAM_HEALTHGAIN, health)
setConditionParam(condition, CONDITION_PARAM_HEALTHTICKS, 1000)
setCombatCondition(combat, condition)
                  
function onCastSpell(cid, var)
if getPlayerStorageValue(cid, 102053) ~= 1 or getCreatureCondition(cid, CONDITION_REGENERATION, 1) == false then
    doCombat(cid, combat, var)
    setPlayerStorageValue(cid, 102053,1)
	repeatEff(cid, 13, 120)
    doCreatureSay(cid, "Raiton Yoroi", TALKTYPE_MONSTER)
else
    doPlayerSendCancel(cid, "Sorry, you are transformed.")
end
end