/*

	Damage handler

*/

private ["_unit","_incomingDamage","_currentDamage","_damageRequired"];

_unit = _this select 0;
_incomingDamage = _this select 2;

_currentDamage = damage _unit;
_damageRequired = 0.9;

if ((_currentDamage + _incomingDamage) > _damageRequired) then
{		
	if (player getVariable ["Ghosts_PlayerIsUnconcious",false] isEqualTo false) then
	{
		player allowDamage false;
		player setVariable ["Ghosts_PlayerIsUnconcious",true,true];
		player setUnconscious true;

		for "_i" from 0 to 1 + floor (random 5) do
		{	

			_pos = [getPosWorld player,2] call Ghosts_fnc_findRandomPositionInCircle;
			if (random 1 > 0.3) then
			{	
				_smallSplash = createSimpleObject ["a3\characters_f\data\slop_00.p3d", _pos]; 
				_smallSplash setDir random 360; 
				_smallSplash setVectorUp surfaceNormal getPosWorld _smallSplash;
			}
			else
			{
				_largeSplash = createSimpleObject ["a3\characters_f\blood_splash.p3d", _pos]; 
				_largeSplash setDir random 360;
			};	
		};

		[] spawn
		{
			while {true} do
			{
				[60] call BIS_fnc_bloodEffect;	

				if (player getVariable ["Ghosts_PlayerIsUnconcious",false] isEqualTo false) exitWith {};
				private ["_validMen"];

				_validMen = [] call Ghosts_fnc_findValidMedics;
				if (isNil "_validMen") then
				{
					_validMen = [];
				};

				if (((count _validMen) <= 0) && ((count AllPlayers -1) <= 0)) exitWith
				{
					titleText ["There are no medics to revive you - You have failed","PLAIN DOWN"];
					cutText ["","BLACK OUT",10];
					uiSleep 10;
					player setDamage 1;
				};	

				uiSleep 5;
			};	
		};	
	};
};