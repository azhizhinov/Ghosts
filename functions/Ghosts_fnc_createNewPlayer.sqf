/*

	Pull player from debug, give random loadout / spawn location etc etc.. or base? mabe..

	To do -

	1. setPos the new player (spawn location)
	2. new player loadout

*/

//hint "Respawwwwwwwwning";

private ["_uniforms","_weapons","_startingLoadout"];

_uniforms = ["rhsgref_uniform_reed","rhsgref_uniform_tigerstripe","rhsgref_uniform_flecktarn","rhsgref_uniform_ERDL","rhsgref_uniform_alpenflage","rhsgref_uniform_ttsko_urban","rhsgref_uniform_ttsko_mountain"];
_weapons = [""];
_startingLoadout = 
[
	["rhs_weap_akms","","","",["rhs_30Rnd_762x39mm",30],[],""],[],[],[(selectRandom _uniforms),[["FirstAidKit",1],["rhs_30Rnd_762x39mm",1,30]]],["rhs_6sh92",[["rhs_30Rnd_762x39mm",3,30]]],[],"","",[],["ItemMap","","","ItemCompass","ItemWatch",""]
];

player setCustomAimCoef 0.3;
player enableFatigue false;
player enableStamina false;
player allowSprint true;
player allowDamage true;

player setVariable ["Ghosts_playerIsBleeding",-1,true];
player setVariable ["Ghosts_lastSourceOfDamage",nil,true];
player setVariable ["Ghosts_PlayerIsUnconcious",false,true];
player setVariable ["Ghosts_playerSide",(side player),true];
player setVariable ["Ghosts_playerKills",0,true];
player setVariable ["Ghosts_bloodLevel",12000,true];

Ghosts_bloodLevel = 12000;
Ghosts_playerKills = 0;

player removeAllEventHandlers "HandleDamage";
player removeAllEventHandlers "Respawn";
player removeAllEventHandlers "Put";
player removeAllEventHandlers "Take";

uiSleep 0.1;

player addEventHandler ["HandleDamage", { _this call Ghosts_fnc_handleDamage;}];
player addEventHandler ["Respawn", { _this call Ghosts_fnc_handleRespawn; }];
player addEventHandler ["Put",{ _this call Ghosts_fnc_onPut; }];
player addEventHandler ["Take",{ _this call Ghosts_fnc_onTakeFromStash; }];
(findDisplay 46) displayAddEventHandler ["KeyDown", { _this call Ghosts_fnc_eventOnKeyDown; }];

Ghosts_playerLoaded = true;
Ghosts_player_isAccessingStash = false;

player setVariable ["Ghosts_playerData",1];

/** set position and loadout **/

_spawnPos = [(getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition")), 0, 10000, 10, 0,1,0] call BIS_fnc_findSafePos;
_spawnPos set [2,1500];

//player setPos ([(getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition")), 0, 10000, 10, 0,1,0] call BIS_fnc_findSafePos);
player setUnitLoadout _startingLoadout;+
removeBackpack player;
player addBackpackGlobal "B_Parachute";

player setPosATL _spawnPos;

player switchMove "";
player playMoveNow "HaloFreeFall_non"; 
player playMoveNow "HaloFreeFall_non";
player playMoveNow "HaloFreeFall_non";

player setVelocity [(sin (getDir player)) * 50, (cos (getDir player)) * 50, -5];

[] spawn Ghosts_fnc_parachuteFix;

player allowDamage false;

cutText ["","BLACK FADED",10];
disableUserInput true;
uiSleep 5;
cutText ["","BLACK IN",10];
disableUserInput false;

player allowDamage true;

[true] call Ghosts_fnc_savePlayerData;