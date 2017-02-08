/*

	Disable simulation of units not near players.

*/

private ["_nearPlayers"];

{
	_nearPlayers = _x nearEntities ["Man",500];	

	{
		if !(isPlayer _x) then
		{
			_nearPlayers deleteAt _forEachIndex;
		};
	} forEach _nearPlayers;

	if (count _nearPlayers > 0) then
	{
		_x enableSimulationGlobal true;
		_x hideObjectGlobal false;
	}
	else
	{
		_x enableSimulationGlobal false;
		_x hideObjectGlobal true;
	};	

} forEach (allUnits - playableUnits);