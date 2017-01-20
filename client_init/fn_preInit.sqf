private ['_code', '_function', '_file'];

{
    _code = '';
    _function = _x select 0;
    _file = _x select 1;

    _code = compileFinal (preprocessFileLineNumbers _file);

    missionNamespace setVariable [_function, _code];
}
forEach
[
	["Ghosts_fnc_findRandomPositionInCircle","functions\Ghosts_fnc_findRandomPositionInCircle.sqf"],
	["Ghosts_fnc_createPlayerActions","functions\Ghosts_fnc_createPlayerActions.sqf"],
	["Ghosts_fnc_handlePlayerActions","functions\Ghosts_fnc_handlePlayerActions.sqf"],
	["Ghosts_fnc_targetLifeState","functions\Ghosts_fnc_targetLifeState.sqf"],
	["Ghosts_fnc_accessPlayerStash","functions\Ghosts_fnc_accessPlayerStash.sqf"],
	//player saving
	["Ghosts_fnc_savePlayerData","functions\Ghosts_fnc_savePlayerData.sqf"],
	["Ghosts_fnc_loadPlayerData","functions\Ghosts_fnc_loadPlayerData.sqf"],
	["Ghosts_fnc_createNewPlayer","functions\Ghosts_fnc_createNewPlayer.sqf"],
	//Event handlers
	["Ghosts_fnc_handleDamage","client_eventHandlers\Ghosts_fnc_handleDamage.sqf"],
	["Ghosts_fnc_handleRespawn","client_eventHandlers\Ghosts_fnc_handleRespawn.sqf"],
	["Ghosts_fnc_onMPKilled","client_eventHandlers\Ghosts_fnc_onMPKilled.sqf"],
	["Ghosts_fnc_onPut","client_eventHandlers\Ghosts_fnc_onPut.sqf"],
	["Ghosts_fnc_onTakeFromStash","client_eventHandlers\Ghosts_fnc_onTakeFromStash.sqf"],
	["Ghosts_fnc_onInventoryOpened","client_eventHandlers\Ghosts_fnc_onInventoryOpened.sqf"]
];

true 