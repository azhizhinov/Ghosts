/*

	
	[
		[false,position player],
		"NONE",
		2,
		1,
		3,
		100
	]

	call Ghosts_fnc_spawnAIGroup;


*/

private ["_spawnPosition","_groupAmount","_unitsPerGroupMin","_unitsPerGroupMax","_roamingRadius","_group","_unit","_moveToPos","_soldierType","_side"];

_isFrontLine = 				_this select 0;
_spawnPosition = 			_this select 1;
_groupAmount = 				_this select 2;
_unitsPerGroupMin = 		_this select 3;
_unitsPerGroupMax = 		_this select 4;
_roamingRadius = 			_this select 5;

if (Ghosts_server_currentAI >= Ghosts_server_maximumAllowedAI) exitWith {};

if (_spawnPosition isEqualTo "TOWN") then
{
	_spawnPosition = [(selectRandom Ghosts_townLocation_positions),50] call Ghosts_fnc_findRandomPositionInCircle;

	//_marker1 = createMarker [ format["HeliCrash%1", diag_tickTime], _spawnPosition];
	//_marker1 setMarkerType "mil_warning";
}
else
{
	_spawnPosition = [(getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition")), 0, 10000, 10, 0,1,0] call BIS_fnc_findSafePos;
};	

if (random 1 > 0.5) then
{
	_side = WEST;
	_soldierType = "B_Survivor_F";
}
else
{
	_side = EAST;
	_soldierType = "O_G_Survivor_F";
};	

for "_n" from 0 to _groupAmount do
{
	_group = createGroup _side;
	_group setCombatMode "RED";

	for "_i" from 1 to _unitsPerGroupMin + floor (random _unitsPerGroupMax) do
	{	
		_unit = _group createUnit [_soldierType,_spawnPosition,[],0,"NONE"];
		_unit allowFleeing 0;
		[_unit] joinSilent _group;
		
		_unit setskill ["aimingAccuracy",0.15];
		_unit setskill ["aimingShake",0.05];
		_unit setskill ["aimingSpeed",0.05];
		_unit setskill ["spotDistance",0.50];
		_unit setskill ["spotTime",0.25];
		_unit setskill ["courage",0.50];
		_unit setskill ["reloadSpeed",0.20];
		_unit setskill ["commanding",0.50];

		removeUniform _unit;
		removeVest _unit;
		removeGoggles _unit;
		removeBackpack _unit;
		removeAllWeapons _unit;
		removeHeadgear _unit;
		removeAllAssignedItems _unit;

		_gear = [] call Ghosts_fnc_AIgear;

		_weapon = _gear select 0;																																						
		_uniform = _gear select 2;
		_vest = _gear select 3;
		_backPack = _gear select 4;
		_item = _gear select 5;
		_headGear = _gear select 6;
		_nightVision = _gear select 7;
		_binos = _gear select 8;

		_magazines = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");							

		_unit forceAddUniform _uniform;
		if (random 1 > 0.5) then
		{	
			_unit addBackpack _backPack;
		};	
		_unit addVest _vest;
		[_unit,_weapon, 5] call BIS_fnc_addWeapon;
		if (random 1 > 0.8) then
		{	
			_unit addItem _item;
		};
		if (random 1 > 0.8) then
		{	
			_unit addHeadgear _headGear;
		};
		if (random 1 > 0.95) then
		{	
			_unit linkItem _nightVision;
		};	
		if (random 1 > 0.7) then
		{
			_unit addWeapon _binos;
		};	
		_unit addMPEventHandler 
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

		_unit addEventHandler ["HandleDamage",
		{
			_dmg = _this select 2;
			_source = _this select 3;
			_projectile = _this select 4;

			if ((_projectile isEqualTo "") && {isPlayer _source}) then
			{
				_dmg = 0;
			};

			_dmg
		}];

		Ghosts_server_currentAI = Ghosts_server_currentAI + 1;
	};

	if ((_isFrontLine select 0) isEqualTo true) then
	{
		_moveToPos = _isFrontLine select 1;

		_wp = _group addWaypoint [_moveToPos,30];
		_wp setWaypointType "MOVE";
		_wp setWaypointBehaviour "AWARE";
		_wp setWaypointStatements ["true","[group this,getPos this,100] call Ghosts_fnc_taskPatrol"];
	}
	else
	{
		[_group,_spawnPosition,300] call Ghosts_fnc_taskPatrol;
	};	

	_group setBehaviour "SAFE";
	_group setSpeedMode "LIMITED";
};