if (isServer) then
{

	Ghosts_server_allSavedPlayerData = profileNamespace getVariable ["Ghosts_server_allSavedPlayerData",[]];
	Ghosts_server_allPlayerSavedCaches = profileNamespace getVariable ["Ghosts_server_allPlayerSavedCaches",[]];

	Ghosts_allTownLocations = nearestLocations [[0,0,0], ["NameVillage","NameCity","NameCityCapital"], 30000];

	Ghosts_townLocation_positions = [];

	{
		_index = _forEachIndex;
		_positionIndex = Ghosts_allTownLocations select _index;
		_position = position _positionIndex;
		Ghosts_townLocation_positions pushBack _position;
	} forEach Ghosts_allTownLocations;

	Ghosts_server_fnc_savePlayerProfileToDB = compileFinal preprocessFileLineNumbers "functions_server\Ghosts_server_fnc_savePlayerProfileToDB.sqf";
	Ghosts_server_fnc_checkPlayerIntegrity = compileFinal preprocessFileLineNumbers "functions_server\Ghosts_server_fnc_checkPlayerIntegrity.sqf";

	Ghosts_fnc_AIgear = compileFinal preprocessFileLineNumbers "functions_server\Ghosts_fnc_AIgear.sqf";
	Ghosts_fnc_taskPatrol = compileFinal preprocessFileLineNumbers "functions_server\Ghosts_fnc_taskPatrol.sqf";
	Ghosts_fnc_spawnAIGroup = compileFinal preprocessFileLineNumbers "functions_server\Ghosts_fnc_spawnAIGroup.sqf";

	Ghosts_server_graveYardGroup = createGroup EAST;

	Ghosts_server_maximumAllowedAI = 200;
	Ghosts_server_currentAI = 0;

	Ghosts_server_AI_town_spawnInterval = 600;
	Ghosts_server_AI_town_spawnInterval_timestamp = time;
	Ghosts_server_AI_random_spawnInterval = 900;
	Ghosts_server_AI_random_spawnInterval_timestamp = time;

	civilian setFriend [EAST,0];
	civilian setFriend [WEST,0];
	west setFriend [civilian,0];
	east setFriend [civilian,0];

	player addAction ["Remove SERVER data",
	{
		profileNamespace setVariable ["Ghosts_server_allSavedPlayerData",[]];
		Ghosts_server_allSavedPlayerData = [];
		saveProfileNamespace;
	}];
};	

//if !(isDedicated) then
//{	

	//cutText ["","BLACK FADED",10];
	//[] execVM "intro\intro.sqf";

	player setCustomAimCoef 0.3;
	player enableFatigue false;
	player enableStamina false;
	player allowSprint true;

	Ghosts_userActions = [];
	Ghosts_userActionArray = [];
	Ghosts_userActionTimeout_lastCheck = time;
	Ghosts_userAction_checkTime = 2;
	Ghosts_userAction_checkTime_stamp = time;

	Ghosts_bloodRegenPerTick = 5;
	Ghosts_bloodRegenCoolDown = 10;
	Ghosts_lastBloodRegen = time;
	Ghosts_bloodlossCoolDown = 3;
	Ghosts_lastBloodLossTick = time;

	Ghosts_lastPlayerSaveTick = time;
	Ghosts_playerSaveInterval = 120;

	Ghosts_player_isAccessingStash = false;

	Ghosts_playerLoaded = false;

	player addEventHandler ["HandleDamage", { _this call Ghosts_fnc_handleDamage;}];
	player addEventHandler ["Respawn", { [] call Ghosts_fnc_handleRespawn; }];
	player addMPEventHandler ["MPKilled", { [] call Ghosts_fnc_onMPKilled; }];
	player addEventHandler ["Put",{ _this call Ghosts_fnc_onPut; }];
	player addEventHandler ["Take",{ _this call Ghosts_fnc_onTakeFromStash; }];

	uiSleep 5;

	[] call Ghosts_fnc_createPlayerActions;
	[] call Ghosts_fnc_loadPlayerData;

	[] execVM "Ghosts_client_mainLoop.sqf";
//};

player addAction ["Save player data",
{
	[false] call Ghosts_fnc_savePlayerData;
}];

player addAction ["Remove PLAYER data",
{
	profileNamespace setVariable ["Ghosts_playerData",-1];
	saveProfileNamespace;
}];