private ["_data","_isNew"];

_isNew = _this select 0;

_data =
[
	(player getVariable ["Ghosts_bloodLevel",Ghosts_bloodLevel]),
	(damage player),
	(getposATL player),
	(getUnitLoadout player),
	(player getVariable ["Ghosts_playerKills",Ghosts_playerKills]),
	(player getVariable ["Ghosts_playerIsBleeding",-1]),
	(player getVariable ["Ghosts_playerSide",-1]),
	
	[
		(player getVariable ["Ghosts_playerStash",[]])
	]	
];

profileNamespace setVariable ["Ghosts_playerData",[_data,(getPlayerUID player)]];
saveProfileNamespace;

[_data,(getPlayerUID player),_isNew] remoteExecCall ["Ghosts_server_fnc_savePlayerProfileToDB", 2, false];

if (_isNew) then
{	
	[] spawn
	{
		uiSleep 5;

		[false] call Ghosts_fnc_savePlayerData;
	};
};		
