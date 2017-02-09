private ['_code', '_function', '_file'];

if (hasInterface) then 
{
    //if (!isNumber (missionConfigFile >> "briefing")) exitWith {};
    //if (getNumber (missionConfigFile >> "briefing") == 1) exitWith {};
    [] spawn 
    {
        private ["_d"];
        _d = (getNumber (configfile >> "RscDisplayServerGetReady" >> "idd"));
        waitUntil
        {
            if (getClientState == "BRIEFING READ") exitWith {true};
            if (!isNull findDisplay _d) exitWith 
            {
                ctrlActivate (findDisplay _d displayCtrl 1);
                findDisplay _d closeDisplay 1;
                true
            };
            false
       };
    };
};

{
    _code = '';
    _function = _x select 0;
    _file = _x select 1;

    _code = compileFinal (preprocessFileLineNumbers _file);

    missionNamespace setVariable [_function, _code];
}
forEach
[
    /** Client Functions **/
	["Ghosts_fnc_findRandomPositionInCircle","functions\Ghosts_fnc_findRandomPositionInCircle.sqf"],
	["Ghosts_fnc_createPlayerActions","functions\Ghosts_fnc_createPlayerActions.sqf"],
	["Ghosts_fnc_handlePlayerActions","functions\Ghosts_fnc_handlePlayerActions.sqf"],
	["Ghosts_fnc_targetLifeState","functions\Ghosts_fnc_targetLifeState.sqf"],
	["Ghosts_fnc_accessPlayerStash","functions\Ghosts_fnc_accessPlayerStash.sqf"],
    ["Ghosts_fnc_takeUniform","functions\Ghosts_fnc_takeUniform.sqf"],
    ["Ghosts_fnc_parachuteFix","functions\Ghosts_fnc_parachuteFix.sqf"],
	//player saving
	["Ghosts_fnc_savePlayerData","functions\Ghosts_fnc_savePlayerData.sqf"],
	["Ghosts_fnc_loadPlayerData","functions\Ghosts_fnc_loadPlayerData.sqf"],
	["Ghosts_fnc_createNewPlayer","functions\Ghosts_fnc_createNewPlayer.sqf"],
	//Event handlers
	["Ghosts_fnc_handleDamage","client_eventHandlers\Ghosts_fnc_handleDamage.sqf"],
    ["Ghosts_fnc_getBulletRating","functions\Ghosts_fnc_getBulletRating.sqf"],
	["Ghosts_fnc_handleRespawn","client_eventHandlers\Ghosts_fnc_handleRespawn.sqf"],
	["Ghosts_fnc_onMPKilled","client_eventHandlers\Ghosts_fnc_onMPKilled.sqf"],
	["Ghosts_fnc_onPut","client_eventHandlers\Ghosts_fnc_onPut.sqf"],
	["Ghosts_fnc_onTakeFromStash","client_eventHandlers\Ghosts_fnc_onTakeFromStash.sqf"],
    ["Ghosts_fnc_eventOnKeyDown","client_eventHandlers\Ghosts_fnc_eventOnKeyDown.sqf"],

    /** Server Functions **/
    ["Ghosts_server_fnc_spawnAirPatrol","functions_server\Ghosts_server_fnc_spawnAirPatrol.sqf"],
    ["Ghosts_server_fnc_savePlayerProfileToDB","functions_server\Ghosts_server_fnc_savePlayerProfileToDB.sqf"],
    ["Ghosts_server_fnc_checkPlayerIntegrity","functions_server\Ghosts_server_fnc_checkPlayerIntegrity.sqf"],
    ["Ghosts_fnc_taskPatrol","functions_server\Ghosts_fnc_taskPatrol.sqf"],
    ["Ghosts_fnc_AIgear","functions_server\Ghosts_fnc_AIgear.sqf"],
    ["Ghosts_fnc_spawnAIGroup","functions_server\Ghosts_fnc_spawnAIGroup.sqf"],
    ["Ghosts_fnc_maintainOccupationMarkers","functions_server\Ghosts_fnc_maintainOccupationMarkers.sqf"],
    ["Ghosts_server_fnc_onHandleDisconnect","functions_server\Ghosts_server_fnc_onHandleDisconnect.sqf"],
    ["Ghosts_server_fnc_savePlayerProfileToDB","functions_server\Ghosts_server_fnc_savePlayerProfileToDB.sqf"],
    ["Ghosts_server_fnc_weatherUpdate","functions_server\Ghosts_server_fnc_weatherUpdate.sqf"],
    ["Ghosts_server_fnc_isPlayerNear","functions_server\Ghosts_server_fnc_isPlayerNear.sqf"],
    ["Ghosts_server_fnc_findRoadPosition","functions_server\Ghosts_server_fnc_findRoadPosition.sqf"],
    ["Ghosts_server_fnc_generateWrecks","functions_server\Ghosts_server_fnc_generateWrecks.sqf"]
    //["Ghosts_server_fnc_simulationManager","functions_server\Ghosts_server_fnc_simulationManager.sqf"]
];

true

