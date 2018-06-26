////////////////////////////////////////////////////////////////////////
// OpenTibia - an opensource roleplaying game
////////////////////////////////////////////////////////////////////////
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
////////////////////////////////////////////////////////////////////////
#include "otpch.h"
#include <iostream>

#include "configmanager.h"
#include "tools.h"

#if LUA_VERSION_NUM >= 502
#undef lua_strlen
#define lua_strlen lua_rawlen
#endif
namespace {

std::string getGlobalString(lua_State* L, const char* identifier, const char* defaultValue)
{
	lua_getglobal(L, identifier);
	if (!lua_isstring(L, -1)) {
		lua_pop(L, 1);
		return defaultValue;
	}

	size_t len = lua_strlen(L, -1);
	std::string ret(lua_tostring(L, -1), len);
	lua_pop(L, 1);
	return ret;
}

int32_t getGlobalNumber(lua_State* L, const char* identifier, const int32_t defaultValue = 0)
{
	lua_getglobal(L, identifier);
	if (!lua_isnumber(L, -1)) {
		lua_pop(L, 1);
		return defaultValue;
	}

	int32_t val = lua_tonumber(L, -1);
	lua_pop(L, 1);
	return val;
}

bool getGlobalNumber(lua_State* L, const char* identifier, const bool defaultValue)
{
	lua_getglobal(L, identifier);
	if (!lua_isboolean(L, -1)) {
		if (!lua_isstring(L, -1)) {
			lua_pop(L, 1);
			return defaultValue;
		}

		size_t len = lua_strlen(L, -1);
		std::string ret(lua_tostring(L, -1), len);
		lua_pop(L, 1);
		return booleanString(ret);
	}

	int val = lua_toboolean(L, -1);
	lua_pop(L, 1);
	return val != 0;
}

}

ConfigManager::ConfigManager()
{
	//L = NULL;
	m_loaded = false;
	m_startup = true;

	m_confString[CONFIG_FILE] = getFilePath(FILE_TYPE_CONFIG, "config.lua");
	m_confBool[LOGIN_ONLY_LOGINSERVER] = false;

	m_confNumber[LOGIN_PORT] = m_confNumber[GAME_PORT] = m_confNumber[ADMIN_PORT] = m_confNumber[STATUS_PORT] = 0;
	m_confString[DATA_DIRECTORY] = m_confString[IP] = m_confString[RUNFILE] = m_confString[ERROR_LOG] = m_confString[OUT_LOG] = "";
}

bool ConfigManager::load()
{

	//lua_State* L = luaL_newstate();
	L = luaL_newstate();
	if (!L) {
		throw std::runtime_error("Failed to allocate memory");
	}

	luaL_openlibs(L);	
	if (luaL_dofile(L, m_confString[CONFIG_FILE].c_str())) {
		//if (luaL_dofile(L, "config.lua")) {
		std::cout << "[Error - ConfigManager::load] " << lua_tostring(L, -1) << std::endl;
		lua_close(L);
		return false;
	}		
	/*
	if(L)
		lua_close(L);

	L = lua_open();
	if(!L)
		return false;

	if(luaL_dofile(L, m_confString[CONFIG_FILE].c_str()))
	{
		lua_close(L);
		L = NULL;
		return false;
	}
	*/

	//parse config
	if(!m_loaded) //info that must be loaded one time (unless we reset the modules involved)
	{
		if(m_confString[DATA_DIRECTORY] == "")
			m_confString[DATA_DIRECTORY] = getGlobalString(L, "dataDirectory", "data/");

		if(m_confString[IP] == "")
			m_confString[IP] = getGlobalString(L, "ip", "127.0.0.1");

		if(m_confNumber[LOGIN_PORT] == 0)
			m_confNumber[LOGIN_PORT] = getGlobalNumber(L, "loginPort", 7171);

		if(m_confNumber[GAME_PORT] == 0)
			m_confNumber[GAME_PORT] = getGlobalNumber(L, "gamePort", 7172);

		if(m_confNumber[ADMIN_PORT] == 0)
			m_confNumber[ADMIN_PORT] = getGlobalNumber(L, "adminPort", 7171);

		if(m_confNumber[STATUS_PORT] == 0)
			m_confNumber[STATUS_PORT] = getGlobalNumber(L, "statusPort", 7171);

		if(m_confString[RUNFILE] == "")
			m_confString[RUNFILE] = getGlobalString(L, "runFile", "");

		if(m_confString[OUT_LOG] == "")
			m_confString[OUT_LOG] = getGlobalString(L, "outLogName", "");

		if(m_confString[ERROR_LOG] == "")
			m_confString[ERROR_LOG] = getGlobalString(L, "errorLogName", "");

		m_confBool[BIND_IP_ONLY] = getGlobalNumber(L, "bindOnlyConfiguredIpAddress", false);
		m_confBool[TRUNCATE_LOGS] = getGlobalNumber(L, "truncateLogsOnStartup", true);
		#ifdef MULTI_SQL_DRIVERS
		m_confString[SQL_TYPE] = getGlobalString(L, "sqlType", "sqlite");
		#endif
		m_confString[SQL_HOST] = getGlobalString(L, "sqlHost", "localhost");
		m_confNumber[SQL_PORT] = getGlobalNumber(L, "sqlPort", 3306);
		m_confString[SQL_DB] = getGlobalString(L, "sqlDatabase", "theforgottenserver");
		m_confString[SQL_USER] = getGlobalString(L, "sqlUser", "root");
		m_confString[SQL_PASS] = getGlobalString(L, "sqlPass", "");
		m_confString[SQL_FILE] = getGlobalString(L, "sqlFile", "forgottenserver.s3db");
		m_confNumber[SQL_KEEPALIVE] = getGlobalNumber(L, "sqlKeepAlive", 0);
		m_confNumber[MYSQL_READ_TIMEOUT] = getGlobalNumber(L, "mysqlReadTimeout", 10);
		m_confNumber[MYSQL_WRITE_TIMEOUT] = getGlobalNumber(L, "mysqlWriteTimeout", 10);
		m_confBool[OPTIMIZE_DB_AT_STARTUP] = getGlobalNumber(L, "optimizeDatabaseAtStartup", true);
		m_confString[MAP_NAME] = getGlobalString(L, "mapName", "forgotten");
		m_confBool[GLOBALSAVE_ENABLED] = getGlobalNumber(L, "globalSaveEnabled", true);
		m_confNumber[GLOBALSAVE_H] = getGlobalNumber(L, "globalSaveHour", 8);
		m_confString[HOUSE_RENT_PERIOD] = getGlobalString(L, "houseRentPeriod", "monthly");
		m_confNumber[WORLD_ID] = getGlobalNumber(L, "worldId", 0);
		m_confBool[RANDOMIZE_TILES] = getGlobalNumber(L, "randomizeTiles", true);
		m_confBool[STORE_TRASH] = getGlobalNumber(L, "storeTrash", true);
		m_confBool[EXPERIENCE_STAGES] = getGlobalNumber(L, "experienceStages", false);
		m_confString[DEFAULT_PRIORITY] = getGlobalString(L, "defaultPriority", "high");
		m_confBool[GUILD_HALLS] = getGlobalNumber(L, "guildHalls", false);
		#ifndef __LOGIN_SERVER__
		m_confBool[LOGIN_ONLY_LOGINSERVER] = getGlobalNumber(L, "loginOnlyWithLoginServer", false);
		#endif
		m_confString[ENCRYPTION_TYPE] = getGlobalString(L, "encryptionType", "plain");
		m_confNumber[ENCRYPTION] = ENCRYPTION_PLAIN;
	}

	m_confString[MAP_AUTHOR] = getGlobalString(L, "mapAuthor", "Unknown");
	m_confNumber[LOGIN_TRIES] = getGlobalNumber(L, "loginTries", 3);
	m_confNumber[RETRY_TIMEOUT] = getGlobalNumber(L, "retryTimeout", 30 * 1000);
	m_confNumber[LOGIN_TIMEOUT] = getGlobalNumber(L, "loginTimeout", 5 * 1000);
	m_confNumber[MAX_MESSAGEBUFFER] = getGlobalNumber(L, "maxMessageBuffer", 4);
	m_confNumber[MAX_PLAYERS] = getGlobalNumber(L, "maxPlayers");
	m_confNumber[DEFAULT_DESPAWNRANGE] = getGlobalNumber(L, "deSpawnRange", 2);
	m_confNumber[DEFAULT_DESPAWNRADIUS] = getGlobalNumber(L, "deSpawnRadius", 50);
	m_confNumber[PZ_LOCKED] = getGlobalNumber(L, "pzLocked", 60 * 1000);
	m_confNumber[HUNTING_DURATION] = getGlobalNumber(L, "huntingDuration", 60 * 1000);
	m_confString[SERVER_NAME] = getGlobalString(L, "serverName", "");
	m_confString[OWNER_NAME] = getGlobalString(L, "ownerName", "");
	m_confString[OWNER_EMAIL] = getGlobalString(L, "ownerEmail", "");
	m_confString[URL] = getGlobalString(L, "url", "");
	m_confString[LOCATION] = getGlobalString(L, "location", "");
	m_confString[MOTD] = getGlobalString(L, "motd", "");
	m_confNumber[ALLOW_CLONES] = getGlobalNumber(L, "allowClones", 0);
	m_confDouble[RATE_EXPERIENCE] = getGlobalNumber(L, "rateExperience", 1);
	m_confDouble[RATE_SKILL] = getGlobalNumber(L, "rateSkill", 1);
	m_confDouble[RATE_MAGIC] = getGlobalNumber(L, "rateMagic", 1);
	m_confDouble[RATE_LOOT] = getGlobalNumber(L, "rateLoot", 1);
	m_confNumber[RATE_SPAWN] = getGlobalNumber(L, "rateSpawn", 1);
	m_confNumber[PARTY_RADIUS_X] = getGlobalNumber(L, "experienceShareRadiusX", 30);
	m_confNumber[PARTY_RADIUS_Y] = getGlobalNumber(L, "experienceShareRadiusY", 30);
	m_confNumber[PARTY_RADIUS_Z] = getGlobalNumber(L, "experienceShareRadiusZ", 1);
	m_confDouble[PARTY_DIFFERENCE] = getGlobalNumber(L, "experienceShareLevelDifference", (2 / 3));
	m_confNumber[SPAWNPOS_X] = getGlobalNumber(L, "newPlayerSpawnPosX", 100);
	m_confNumber[SPAWNPOS_Y] = getGlobalNumber(L, "newPlayerSpawnPosY", 100);
	m_confNumber[SPAWNPOS_Z] = getGlobalNumber(L, "newPlayerSpawnPosZ", 7);
	m_confNumber[SPAWNTOWN_ID] = getGlobalNumber(L, "newPlayerTownId", 1);
	m_confString[WORLD_TYPE] = getGlobalString(L, "worldType", "pvp");
	m_confBool[ACCOUNT_MANAGER] = getGlobalNumber(L, "accountManager", true);
	m_confBool[NAMELOCK_MANAGER] = getGlobalNumber(L, "namelockManager", false);
	m_confNumber[START_LEVEL] = getGlobalNumber(L, "newPlayerLevel", 1);
	m_confNumber[START_MAGICLEVEL] = getGlobalNumber(L, "newPlayerMagicLevel", 0);
	m_confBool[START_CHOOSEVOC] = getGlobalNumber(L, "newPlayerChooseVoc", false);
	m_confNumber[HOUSE_PRICE] = getGlobalNumber(L, "housePriceEachSquare", 1000);
	m_confNumber[WHITE_SKULL_TIME] = getGlobalNumber(L, "whiteSkullTime", 15 * 60 * 1000);
	m_confNumber[HIGHSCORES_TOP] = getGlobalNumber(L, "highscoreDisplayPlayers", 10);
	m_confNumber[HIGHSCORES_UPDATETIME] = getGlobalNumber(L, "updateHighscoresAfterMinutes", 60);
	m_confBool[ON_OR_OFF_CHARLIST] = getGlobalNumber(L, "displayOnOrOffAtCharlist", false);
	m_confBool[ALLOW_CHANGEOUTFIT] = getGlobalNumber(L, "allowChangeOutfit", true);
	m_confBool[ONE_PLAYER_ON_ACCOUNT] = getGlobalNumber(L, "onePlayerOnlinePerAccount", true);
	m_confBool[CANNOT_ATTACK_SAME_LOOKFEET] = getGlobalNumber(L, "noDamageToSameLookfeet", false);
	m_confBool[AIMBOT_HOTKEY_ENABLED] = getGlobalNumber(L, "hotkeyAimbotEnabled", true);
	m_confNumber[ACTIONS_DELAY_INTERVAL] = getGlobalNumber(L, "timeBetweenActions", 200);
	m_confNumber[EX_ACTIONS_DELAY_INTERVAL] = getGlobalNumber(L, "timeBetweenExActions", 1000);
	m_confNumber[CRITICAL_HIT_CHANCE] = getGlobalNumber(L, "criticalHitChance", 5);
	m_confBool[REMOVE_WEAPON_AMMO] = getGlobalNumber(L, "removeWeaponAmmunition", true);
	m_confBool[REMOVE_WEAPON_CHARGES] = getGlobalNumber(L, "removeWeaponCharges", true);
	m_confBool[REMOVE_RUNE_CHARGES] = getGlobalNumber(L, "removeRuneCharges", true);
	m_confDouble[RATE_PVP_EXPERIENCE] = getGlobalNumber(L, "rateExperienceFromPlayers", 0);
	m_confDouble[EFP_MIN_THRESHOLD] = getGlobalNumber(L, "minLevelThresholdForKilledPlayer", 1);
	m_confDouble[EFP_MAX_THRESHOLD] = getGlobalNumber(L, "maxLevelThresholdForKilledPlayer", 1);
	m_confBool[SHUTDOWN_AT_GLOBALSAVE] = getGlobalNumber(L, "shutdownAtGlobalSave", false);
	m_confBool[CLEAN_MAP_AT_GLOBALSAVE] = getGlobalNumber(L, "cleanMapAtGlobalSave", true);
	m_confBool[FREE_PREMIUM] = getGlobalNumber(L, "freePremium", false);
	m_confNumber[PROTECTION_LEVEL] = getGlobalNumber(L, "protectionLevel", 1);
	m_confBool[ADMIN_LOGS_ENABLED] = getGlobalNumber(L, "adminLogsEnabled", false);
	m_confNumber[STATUSQUERY_TIMEOUT] = getGlobalNumber(L, "statusTimeout", 5 * 60 * 1000);
	m_confBool[BROADCAST_BANISHMENTS] = getGlobalNumber(L, "broadcastBanishments", true);
	m_confBool[GENERATE_ACCOUNT_NUMBER] = getGlobalNumber(L, "generateAccountNumber", true);
	m_confBool[INGAME_GUILD_MANAGEMENT] = getGlobalNumber(L, "ingameGuildManagement", true);
	m_confNumber[LEVEL_TO_FORM_GUILD] = getGlobalNumber(L, "levelToFormGuild", 8);
	m_confNumber[MIN_GUILDNAME] = getGlobalNumber(L, "guildNameMinLength", 4);
	m_confNumber[MAX_GUILDNAME] = getGlobalNumber(L, "guildNameMaxLength", 20);
	m_confNumber[LEVEL_TO_BUY_HOUSE] = getGlobalNumber(L, "levelToBuyHouse", 1);
	m_confNumber[HOUSES_PER_ACCOUNT] = getGlobalNumber(L, "housesPerAccount", 0);
	m_confBool[HOUSE_BUY_AND_SELL] = getGlobalNumber(L, "buyableAndSellableHouses", true);
	m_confBool[REPLACE_KICK_ON_LOGIN] = getGlobalNumber(L, "replaceKickOnLogin", true);
	m_confBool[HOUSE_NEED_PREMIUM] = getGlobalNumber(L, "houseNeedPremium", true);
	m_confBool[HOUSE_RENTASPRICE] = getGlobalNumber(L, "houseRentAsPrice", false);
	m_confBool[HOUSE_PRICEASRENT] = getGlobalNumber(L, "housePriceAsRent", false);
	m_confNumber[RED_SKULL_LENGTH] = getGlobalNumber(L, "redSkullLength", 30 * 24 * 60 * 60);
	m_confNumber[BLACK_SKULL_LENGTH] = getGlobalNumber(L, "blackSkullLength", 45 * 24 * 60 * 60);
	m_confNumber[MAX_VIOLATIONCOMMENT_SIZE] = getGlobalNumber(L, "maxViolationCommentSize", 60);
	m_confNumber[NOTATIONS_TO_BAN] = getGlobalNumber(L, "notationsToBan", 3);
	m_confNumber[WARNINGS_TO_FINALBAN] = getGlobalNumber(L, "warningsToFinalBan", 4);
	m_confNumber[WARNINGS_TO_DELETION] = getGlobalNumber(L, "warningsToDeletion", 5);
	m_confNumber[BAN_LENGTH] = getGlobalNumber(L, "banLength", 7 * 24 * 60 * 60);
	m_confNumber[KILLS_BAN_LENGTH] = getGlobalNumber(L, "killsBanLength", 7 * 24 * 60 * 60);
	m_confNumber[FINALBAN_LENGTH] = getGlobalNumber(L, "finalBanLength", 30 * 24 * 60 * 60);
	m_confNumber[IPBANISHMENT_LENGTH] = getGlobalNumber(L, "ipBanishmentLength", 1 * 24 * 60 * 60);
	m_confBool[BANK_SYSTEM] = getGlobalNumber(L, "bankSystem", true);
	m_confBool[PREMIUM_FOR_PROMOTION] = getGlobalNumber(L, "premiumForPromotion", true);
	m_confBool[REMOVE_PREMIUM_ON_INIT] = getGlobalNumber(L, "removePremiumOnInit", true);
	m_confBool[SHOW_HEALING_DAMAGE] = getGlobalNumber(L, "showHealingDamage", false);
	m_confBool[TELEPORT_SUMMONS] = getGlobalNumber(L, "teleportAllSummons", false);
	m_confBool[TELEPORT_PLAYER_SUMMONS] = getGlobalNumber(L, "teleportPlayerSummons", false);
	m_confBool[PVP_TILE_IGNORE_PROTECTION] = getGlobalNumber(L, "pvpTileIgnoreLevelAndVocationProtection", true);
	m_confBool[DISPLAY_CRITICAL_HIT] = getGlobalNumber(L, "displayCriticalHitNotify", false);
	m_confBool[ADVANCING_SKILL_LEVEL] = getGlobalNumber(L, "displaySkillLevelOnAdvance", false);
	m_confBool[CLEAN_PROTECTED_ZONES] = getGlobalNumber(L, "cleanProtectedZones", true);
	m_confBool[SPELL_NAME_INSTEAD_WORDS] = getGlobalNumber(L, "spellNameInsteadOfWords", false);
	m_confBool[EMOTE_SPELLS] = getGlobalNumber(L, "emoteSpells", false);
	m_confNumber[MAX_PLAYER_SUMMONS] = getGlobalNumber(L, "maxPlayerSummons", 2);
	m_confBool[SAVE_GLOBAL_STORAGE] = getGlobalNumber(L, "saveGlobalStorage", true);
	m_confBool[FORCE_CLOSE_SLOW_CONNECTION] = getGlobalNumber(L, "forceSlowConnectionsToDisconnect", false);
	m_confBool[BLESSING_ONLY_PREMIUM] = getGlobalNumber(L, "blessingOnlyPremium", true);
	m_confBool[BED_REQUIRE_PREMIUM] = getGlobalNumber(L, "bedsRequirePremium", true);
	m_confNumber[FIELD_OWNERSHIP] = getGlobalNumber(L, "fieldOwnershipDuration", 5 * 1000);
	m_confBool[ALLOW_CHANGECOLORS] = getGlobalNumber(L, "allowChangeColors", true);
	m_confBool[STOP_ATTACK_AT_EXIT] = getGlobalNumber(L, "stopAttackingAtExit", false);
	m_confNumber[EXTRA_PARTY_PERCENT] = getGlobalNumber(L, "extraPartyExperiencePercent", 5);
	m_confNumber[EXTRA_PARTY_LIMIT] = getGlobalNumber(L, "extraPartyExperienceLimit", 20);
	m_confBool[DISABLE_OUTFITS_PRIVILEGED] = getGlobalNumber(L, "disableOutfitsForPrivilegedPlayers", false);
	m_confBool[OLD_CONDITION_ACCURACY] = getGlobalNumber(L, "oldConditionAccuracy", false);
	m_confBool[HOUSE_STORAGE] = getGlobalNumber(L, "useHouseDataStorage", false);
	m_confBool[TRACER_BOX] = getGlobalNumber(L, "promptExceptionTracerErrorBox", true);
	m_confNumber[LOGIN_PROTECTION] = getGlobalNumber(L, "loginProtectionPeriod", 10 * 1000);
	m_confBool[STORE_DIRECTION] = getGlobalNumber(L, "storePlayerDirection", false);
	m_confNumber[PLAYER_DEEPNESS] = getGlobalNumber(L, "playerQueryDeepness", 1);
	m_confDouble[CRITICAL_HIT_MUL] = getGlobalNumber(L, "criticalHitMultiplier", 1);
	m_confNumber[STAIRHOP_DELAY] = getGlobalNumber(L, "stairhopDelay", 2 * 1000);
	m_confNumber[RATE_STAMINA_LOSS] = getGlobalNumber(L, "rateStaminaLoss", 1);
	m_confDouble[RATE_STAMINA_GAIN] = getGlobalNumber(L, "rateStaminaGain", 3);
	m_confDouble[RATE_STAMINA_THRESHOLD] = getGlobalNumber(L, "rateStaminaThresholdGain", 12);
	m_confDouble[RATE_STAMINA_ABOVE] = getGlobalNumber(L, "rateStaminaAboveNormal", 1);
	m_confDouble[RATE_STAMINA_UNDER] = getGlobalNumber(L, "rateStaminaUnderNormal", 1);
	m_confNumber[STAMINA_LIMIT_TOP] = getGlobalNumber(L, "staminaRatingLimitTop", 41 * 60);
	m_confNumber[STAMINA_LIMIT_BOTTOM] = getGlobalNumber(L, "staminaRatingLimitBottom", 14 * 60);
	m_confBool[DISPLAY_LOGGING] = getGlobalNumber(L, "displayPlayersLogging", true);
	m_confBool[STAMINA_BONUS_PREMIUM] = getGlobalNumber(L, "staminaThresholdOnlyPremium", true);
	m_confBool[BAN_UNKNOWN_BYTES] = getGlobalNumber(L, "autoBanishUnknownBytes", false);
	m_confNumber[BLESS_REDUCTION_BASE] = getGlobalNumber(L, "blessingReductionBase", 30);
	m_confNumber[BLESS_REDUCTION_DECREAMENT] = getGlobalNumber(L, "blessingReductionDecreament", 5);
	m_confBool[ALLOW_CHANGEADDONS] = getGlobalNumber(L, "allowChangeAddons", true);
	m_confNumber[BLESS_REDUCTION] = getGlobalNumber(L, "eachBlessReduction", 8);
	m_confDouble[FORMULA_LEVEL] = getGlobalNumber(L, "formulaLevel", 5);
	m_confDouble[FORMULA_MAGIC] = getGlobalNumber(L, "formulaMagic", 1);
	m_confString[PREFIX_CHANNEL_LOGS] = getGlobalString(L, "prefixChannelLogs", "");
	m_confBool[GHOST_INVISIBLE_EFFECT] = getGlobalNumber(L, "ghostModeInvisibleEffect", false);
	m_confString[CORES_USED] = getGlobalString(L, "coresUsed", "-1");
	m_confNumber[NICE_LEVEL] = getGlobalNumber(L, "niceLevel", 5);
	m_confNumber[EXPERIENCE_COLOR] = getGlobalNumber(L, "gainExperienceColor", TEXTCOLOR_WHITE);
	m_confBool[SHOW_HEALING_DAMAGE_MONSTER] = getGlobalNumber(L, "showHealingDamageForMonsters", false);
	m_confBool[CHECK_CORPSE_OWNER] = getGlobalNumber(L, "checkCorpseOwner ", true);
	m_confBool[BUFFER_SPELL_FAILURE] = getGlobalNumber(L, "bufferMutedOnSpellFailure", false);
	m_confBool[CONFIM_OUTDATED_VERSION] = getGlobalNumber(L, "confirmOutdatedVersion", true);
	m_confNumber[GUILD_PREMIUM_DAYS] = getGlobalNumber(L, "premiumDaysToFormGuild", 0);
	m_confNumber[PUSH_CREATURE_DELAY] = getGlobalNumber(L, "pushCreatureDelay", 2 * 1000);
	m_confNumber[DEATH_CONTAINER] = getGlobalNumber(L, "deathContainerId", 1987);
	m_confBool[PREMIUM_SKIP_WAIT] = getGlobalNumber(L, "premiumPlayerSkipWaitList", false);
	m_confNumber[MAXIMUM_DOOR_LEVEL] = getGlobalNumber(L, "maximumDoorLevel", 500);
	m_confBool[DEATH_LIST] = getGlobalNumber(L, "deathListEnabled", true);
	m_confNumber[DEATH_ASSISTS] = getGlobalNumber(L, "deathAssistCount", 1);
	m_confNumber[RED_DAILY_LIMIT] = getGlobalNumber(L, "dailyFragsToRedSkull", 3);
	m_confNumber[RED_WEEKLY_LIMIT] = getGlobalNumber(L, "weeklyFragsToRedSkull", 5);
	m_confNumber[RED_MONTHLY_LIMIT] = getGlobalNumber(L, "monthlyFragsToRedSkull", 10);
	m_confNumber[BLACK_DAILY_LIMIT] = getGlobalNumber(L, "dailyFragsToBlackSkull", m_confNumber[RED_DAILY_LIMIT]);
	m_confNumber[BLACK_WEEKLY_LIMIT] = getGlobalNumber(L, "weeklyFragsToBlackSkull", m_confNumber[RED_WEEKLY_LIMIT]);
	m_confNumber[BLACK_MONTHLY_LIMIT] = getGlobalNumber(L, "monthlyFragsToBlackSkull", m_confNumber[RED_MONTHLY_LIMIT]);
	m_confNumber[BAN_DAILY_LIMIT] = getGlobalNumber(L, "dailyFragsToBanishment", m_confNumber[RED_DAILY_LIMIT]);
	m_confNumber[BAN_WEEKLY_LIMIT] = getGlobalNumber(L, "weeklyFragsToBanishment", m_confNumber[RED_WEEKLY_LIMIT]);
	m_confNumber[BAN_MONTHLY_LIMIT] = getGlobalNumber(L, "monthlyFragsToBanishment", m_confNumber[RED_MONTHLY_LIMIT]);
	m_confNumber[BLACK_SKULL_DEATH_HEALTH] = getGlobalNumber(L, "blackSkulledDeathHealth", 40);
	m_confNumber[BLACK_SKULL_DEATH_MANA] = getGlobalNumber(L, "blackSkulledDeathMana", 0);
	m_confNumber[DEATHLIST_REQUIRED_TIME] = getGlobalNumber(L, "deathListRequiredTime", 1 * 60 * 1000);
	m_confNumber[EXPERIENCE_SHARE_ACTIVITY] = getGlobalNumber(L, "experienceShareActivity", 2 * 60 * 1000);
	m_confBool[GHOST_SPELL_EFFECTS] = getGlobalNumber(L, "ghostModeSpellEffects", true);
	m_confBool[PVPZONE_ADDMANASPENT] = getGlobalNumber(L, "addManaSpentInPvPZone", true);
	m_confNumber[ITEMLIMIT_PROTECTIONZONE] = getGlobalNumber(L, "maxItemsPerPZTile", 0);
	m_confNumber[ITEMLIMIT_HOUSETILE] = getGlobalNumber(L, "maxItemsPerHouseTile", 0);
	m_confString[MAILBOX_DISABLED_TOWNS] = getGlobalString(L, "mailboxDisabledTowns", "-1");
	m_confNumber[SQUARE_COLOR] = getGlobalNumber(L, "squareColor", 0);
	m_confBool[USE_BLACK_SKULL] = getGlobalNumber(L, "useBlackSkull", false);
	m_confBool[USE_FRAG_HANDLER] = getGlobalNumber(L, "useFragHandler", true);
	m_confNumber[LOOT_MESSAGE] = getGlobalNumber(L, "monsterLootMessage", 3);
	m_confNumber[LOOT_MESSAGE_TYPE] = getGlobalNumber(L, "monsterLootMessageType", 25);
	m_confNumber[NAME_REPORT_TYPE] = getGlobalNumber(L, "violationNameReportActionType", 2);
	m_confBool[ALLOW_FIGHTBACK] = getGlobalNumber(L, "allowFightback", true);
	m_confNumber[HOUSE_CLEAN_OLD] = getGlobalNumber(L, "houseCleanOld", 0);
	m_confBool[VIPLIST_PER_PLAYER] = getGlobalNumber(L, "separateViplistPerCharacter", false);
	m_confDouble[RATE_MONSTER_HEALTH] = getGlobalNumber(L, "rateMonsterHealth", 1);
	m_confDouble[RATE_MONSTER_MANA] = getGlobalNumber(L, "rateMonsterMana", 1);
	m_confDouble[RATE_MONSTER_ATTACK] = getGlobalNumber(L, "rateMonsterAttack", 1);
	m_confDouble[RATE_MONSTER_DEFENSE] = getGlobalNumber(L, "rateMonsterDefense", 1);
	m_confBool[ADDONS_PREMIUM] = getGlobalNumber(L, "addonsOnlyPremium", true);

	m_loaded = true;
	return true;
}

bool ConfigManager::reload()
{
	if(!m_loaded)
		return false;

	return load();
}

const std::string& ConfigManager::getString(uint32_t _what) const
{
	if((m_loaded && _what < LAST_STRING_CONFIG) || _what <= CONFIG_FILE)
		return m_confString[_what];

	if(!m_startup)
		std::cout << "[Warning - ConfigManager::getString] " << _what << std::endl;

	return m_confString[DUMMY_STR];
}

bool ConfigManager::getBool(uint32_t _what) const
{
	if(m_loaded && _what < LAST_BOOL_CONFIG)
		return m_confBool[_what];

	if(!m_startup)
		std::cout << "[Warning - ConfigManager::getBool] " << _what << std::endl;

	return false;
}

int32_t ConfigManager::getNumber(uint32_t _what) const
{
	if(m_loaded && _what < LAST_NUMBER_CONFIG)
		return m_confNumber[_what];

	if(!m_startup)
		std::cout << "[Warning - ConfigManager::getNumber] " << _what << std::endl;

	return 0;
}

double ConfigManager::getDouble(uint32_t _what) const
{
	if(m_loaded && _what < LAST_DOUBLE_CONFIG)
		return m_confDouble[_what];

	if(!m_startup)
		std::cout << "[Warning - ConfigManager::getDouble] " << _what << std::endl;

	return 0;
}

bool ConfigManager::setString(uint32_t _what, const std::string& _value)
{
	if(_what < LAST_STRING_CONFIG)
	{
		m_confString[_what] = _value;
		return true;
	}

	std::cout << "[Warning - ConfigManager::setString] " << _what << std::endl;
	return false;
}

bool ConfigManager::setNumber(uint32_t _what, int32_t _value)
{
	if(_what < LAST_NUMBER_CONFIG)
	{
		m_confNumber[_what] = _value;
		return true;
	}

	std::cout << "[Warning - ConfigManager::setNumber] " << _what << std::endl;
	return false;
}
