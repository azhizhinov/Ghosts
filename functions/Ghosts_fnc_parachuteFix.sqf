while {true} do
{
	if(typeOf (vehicle player) isEqualTo "Steerable_Parachute_F")then
	{
		if(
		count(lineIntersectsObjs [ATLToASL(player modelToWorld [0,0,0]), ATLToASL(player modelToWorld [0,0,-2])]) > 1
		||
		((getPosATL player) select 2) < 2
		)exitWith
		{
			deleteVehicle (vehicle player);
			player switchMove "";
			player setVelocity [0, 0, 0];
			[false] call Ghosts_fnc_savePlayerData;
		};
	};
	//if ((getPosATL player) select 2 <= 2) exitWith {};
	uiSleep 0.01;
};	