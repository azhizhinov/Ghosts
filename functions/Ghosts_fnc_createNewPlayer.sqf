/*

	Pull player from debug, give random loadout / spawn location etc etc.. or base? mabe..

	To do -

	1. setPos the new player (spawn location)
	2. new player loadout

*/

//hint "Respawwwwwwwwning";

private ["_uniforms","_weapons","_startingLoadout"];

_uniforms = [""];
_weapons = [""];
_startingLoadout = 
[
	["rhsusf_weap_MP7A2","","","",["rhsusf_mag_40Rnd_46x30_FMJ",40],[],""],[],[],["U_I_G_resistanceLeader_F",[["rhsusf_mag_40Rnd_46x30_FMJ",3,40]]],[],["B_AssaultPack_blk",[["rhsusf_mag_40Rnd_46x30_FMJ",4,40]]],"","",[],["","","","","",""]
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

Ghosts_bloodLevel = 12000;
Ghosts_playerKills = 0;

player removeAllEventHandlers "HandleDamage";
player removeAllEventHandlers "Respawn";
player removeAllEventHandlers "Put";
player removeAllEventHandlers "Take";

player addEventHandler ["HandleDamage", { _this call Ghosts_fnc_handleDamage;}];
player addEventHandler ["Respawn", { _this call Ghosts_fnc_handleRespawn; }];
player addEventHandler ["Put",{ _this call Ghosts_fnc_onPut; }];
player addEventHandler ["Take",{ _this call Ghosts_fnc_onTakeFromStash; }];

Ghosts_playerLoaded = true;
player setVariable ["Ghosts_playerData",1];

/** set position and loadout **/

player setPos ([(getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition")), 0, 10000, 10, 0,1,0] call BIS_fnc_findSafePos);
player setUnitLoadout _startingLoadout;

[true] call Ghosts_fnc_savePlayerData;