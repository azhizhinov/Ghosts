
private ["_side","_soldier","_vehicle","_group","_patrolVehicle","_gunner1","_gunner2","_i","_wp"];

_side = WEST;
_soldier ="B_Survivor_F";
_vehicle = (selectRandom ["RHS_UH60M"]);

if (random 1 > 0.5) then
{
	_side = EAST;
	_soldier = "O_G_Survivor_F";
	_vehicle = (selectRandom ["RHS_Mi8mt_vvs"]);
};	

_group = createGroup _side;
_group setCombatMode "RED";

_patrolVehicle = createvehicle [_vehicle,[0,0,0],[],0,"NONE"];

_pilot = _group createUnit [_soldier,[0,0,0],[],0,"NONE"];
_pilot moveInDriver _patrolVehicle;

_gunner1 = _group createUnit [_soldier,[0,0,0],[],0,"NONE"];
_gunner1 moveInTurret [_patrolVehicle,[1]];

_gunner2 = _group createUnit [_soldier,[0,0,0],[],0,"NONE"];
_gunner2 moveInTurret [_patrolVehicle,[2]];

_patrolVehicle flyInHeight 100;
_patrolVehicle limitSpeed 30;

for "_i" from 0 to 5 do
{
	_wp = _group addWaypoint [([(getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition")), 0, 10000, 10, 0,1,0] call BIS_fnc_findSafePos),50];
	_wp setWaypointType "MOVE";
	_wp setWaypointBehaviour "COMBAT";
	_wp setWaypointSpeed "LIMITED";
	_wp setWaypointStatements ["true","(vehicle this) setFuel 1"];
	if (_i isEqualTo 5) then
	{
		_wp setWaypointType "CYCLE";
	};	
};

{

	_x setskill ["aimingAccuracy",0.15];
	_x setskill ["aimingShake",0.05];
	_x setskill ["aimingSpeed",0.05];
	_x setskill ["spotDistance",0.50];
	_x setskill ["spotTime",0.25];
	_x setskill ["courage",0.50];
	_x setskill ["reloadSpeed",0.20];
	_x setskill ["commanding",0.50];

	
	_x addMPEventHandler 
	["MPKilled",
		{

			private ["_killed","_killer","_oldKills","_newKills"];

			_killed = _this select 0;
			_killer = _this select 1;

			_oldKills = _killer getVariable ["Ghosts_playerKills",0];
			_newKills = _oldKills + 1;

			_killer setVariable ["Ghosts_playerKills",_newKills,true];

			[_killed] joinSilent Ghosts_server_graveYardGroup;

			Ghosts_server_currentAI = Ghosts_server_currentAI - 1;
		}
	];

} forEach [_pilot,_gunner1,_gunner2];

Ghosts_server_currentAI = Ghosts_server_currentAI + 3;