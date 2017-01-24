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

	Ghosts_map_currentMarkers = [];
	[] spawn
	{
		{
			_marker = createMarker [ format["Notifcation%1", diag_tickTime],_x];
			_marker setMarkerType "o_inf";
			_marker setMarkerText "Estimated hostiles -";
			
			Ghosts_map_currentMarkers pushBack _marker;
			uiSleep 1;
		} forEach Ghosts_townLocation_positions;
	};	

	addMissionEventHandler ["HandleDisconnect", { _this call Ghosts_server_fnc_onHandleDisconnect; }];

	/*
	Ghosts_server_fnc_savePlayerProfileToDB = compileFinal preprocessFileLineNumbers "functions_server\Ghosts_server_fnc_savePlayerProfileToDB.sqf";
	Ghosts_server_fnc_checkPlayerIntegrity = compileFinal preprocessFileLineNumbers "functions_server\Ghosts_server_fnc_checkPlayerIntegrity.sqf";
	Ghosts_fnc_AIgear = compileFinal preprocessFileLineNumbers "functions_server\Ghosts_fnc_AIgear.sqf";
	Ghosts_fnc_taskPatrol = compileFinal preprocessFileLineNumbers "functions_server\Ghosts_fnc_taskPatrol.sqf";
	Ghosts_fnc_spawnAIGroup = compileFinal preprocessFileLineNumbers "functions_server\Ghosts_fnc_spawnAIGroup.sqf";
	Ghosts_server_fnc_spawnAirPatrol = compileFinal preprocessFileLineNumbers "functions_server\Ghosts_server_fnc_spawnAirPatrol.sqf";
	Ghosts_fnc_maintainOccupationMarkers = compileFinal preprocessFileLineNumbers "functions_server\Ghosts_fnc_maintainOccupationMarkers.sqf";
	*/

	Ghosts_server_graveYardGroup = createGroup EAST;

	Ghosts_server_maximumAllowedAI = 200;
	Ghosts_server_currentAI = 0;

	Ghosts_server_AI_town_spawnInterval = 600;
	Ghosts_server_AI_town_spawnInterval_timestamp = time;
	Ghosts_server_AI_random_spawnInterval = 900;
	Ghosts_server_AI_random_spawnInterval_timestamp = time;
	Ghosts_server_airPatrolInterval = 1100;
	Ghosts_server_airPatrol_timestamp = time;

	civilian setFriend [EAST,0];
	civilian setFriend [WEST,0];
	west setFriend [civilian,0];
	east setFriend [civilian,0];

	["Initialize"] call BIS_fnc_dynamicGroups;
	[] execVM "Ghosts_server_mainLoop.sqf";	
	/*
	player addAction ["Remove SERVER data",
	{
		profileNamespace setVariable ["Ghosts_server_allSavedPlayerData",[]];
		Ghosts_server_allSavedPlayerData = [];
		saveProfileNamespace;
	}];
	/*
	player addAction ["Spawn AI chunts",
	{
		[
			[false,[0,0,0]], 	// Force AI to move to specific position after spawning - Params - 0: Boolean, enable 1: Position to move to
			"TOWN",				// if "TOWN" AI will spawn at a random town other wise, "RANDOM"
			2,					// Amount of AI groups to spawn this call
			1,					// minimum soldiers per group
			3,					// Maximum soldiers per group
			150					// Roaming radius
		]

		call Ghosts_fnc_spawnAIGroup;

		[
			[false,[0,0,0]], 	// Force AI to move to specific position after spawning - Params - 0: Boolean, enable 1: Position to move to
			"RANDOM",			// if "TOWN" AI will spawn at a random town other wise, position 
			2,					// Amount of AI groups to spawn this call
			1,					// minimum soldiers per group
			3,					// Maximum soldiers per group
			150					// Roaming radius
		]

		call Ghosts_fnc_spawnAIGroup;
	}];
	*/
};	

if !(isDedicated) then
{	
	disableUserInput true;
	cutText ["","BLACK FADED",10];
	[] execVM "intro\intro.sqf";
	["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;

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
	
	uiSleep 5;

	[] call Ghosts_fnc_createPlayerActions;
	[] call Ghosts_fnc_loadPlayerData;

	[] execVM "Ghosts_client_mainLoop.sqf";

	disableUserInput false;
};
/*
player addAction ["Save player data",
{
	[false] call Ghosts_fnc_savePlayerData;
}];

player addAction ["Remove PLAYER data",
{
	profileNamespace setVariable ["Ghosts_playerData",-1];
	saveProfileNamespace;
}];