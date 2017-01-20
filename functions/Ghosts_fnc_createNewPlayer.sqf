/*

	Pull player from debug, give random loadout / spawn location etc etc.. or base? mabe..

	To do -

	1. setPos the new player (spawn location)
	2. new player loadout

*/

//hint "Respawwwwwwwwning";

player setCustomAimCoef 0.3;
player enableFatigue false;
player enableStamina false;
player allowSprint true;
player allowDamage true;

player setVariable ["Ghosts_playerIsBleeding",-1,true];
player setVariable ["Ghosts_lastSourceOfDamage",nil,true];
player setVariable ["Ghosts_PlayerIsUnconcious",false,true];
player setVariable ["Ghosts_playerSide",(side player),true];

Ghosts_bloodLevel = 12000;
Ghosts_playerKills = 0;

player removeAllEventHandlers "HandleDamage";
player removeAllEventHandlers "Respawn";
player removeAllMPEventHandlers "MPKilled";

player addEventHandler ["HandleDamage", { _this call Ghosts_fnc_handleDamage;}];
player addEventHandler ["Respawn", { [] call Ghosts_fnc_handleRespawn; }];
player addMPEventHandler ["MPKilled", { [] call Ghosts_fnc_onMPKilled; }];

Ghosts_playerLoaded = true;
player setVariable ["Ghosts_playerData",1];

/** set position and loadout **/

player setPos ([(getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition")), 0, 10000, 10, 0,1,0] call BIS_fnc_findSafePos);

[true] call Ghosts_fnc_savePlayerData;