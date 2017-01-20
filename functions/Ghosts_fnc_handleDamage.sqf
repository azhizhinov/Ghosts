/*

	Damage handler

*/

private ["_unit","_incomingDamage","_currentDamage","_damageRequired","_bloodLoss"];

_unit = _this select 0;
_incomingDamage = _this select 2;
_sourceOfDamage = _this select 3;
_typeOfProjectile = _this select 4;

player setVariable ["Ghosts_lastSourceOfDamage",_sourceOfDamage,true];
player setVariable ["Ghosts_playerIsBleeding",[true,60],true];

_currentDamage = damage _unit;
_damageRequired = 0.9;

_bloodLoss = [_typeOfProjectile] call Ghosts_fnc_getBulletRating;

Ghosts_bloodLevel = Ghosts_bloodLevel - _bloodLoss;

if ((_currentDamage + _incomingDamage) > _damageRequired) then
{		
	if (player getVariable ["Ghosts_PlayerIsUnconcious",false] isEqualTo false) then
	{
		player allowDamage false;
		player setVariable ["Ghosts_PlayerIsUnconcious",true,true];
		player setUnconscious true;
		/*
		[] spawn
		{
			while {true} do
			{
				[60] call BIS_fnc_bloodEffect;
				
				if (player getVariable ["Ghosts_PlayerIsUnconcious",false] isEqualTo false) exitWith 
				{
					player setVariable ["Ghosts_lastSourceOfDamage",nil,true];
				};
				
				if (Ghosts_bloodLevel <= 0) exitWith
				{	
					player setDamage 1;
					player allowDamage true;
					player setUnconscious false;

					player setVariable ["Ghosts_lastSourceOfDamage",nil,true];
				};		

				uiSleep 5;
			};	
		};
		*/	
	};
};