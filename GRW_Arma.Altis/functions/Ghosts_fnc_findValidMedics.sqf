/*

	Params: Nothing
	Returns: Nearest available medic, defined by a variable setVariable ["Ghosts_isMedic",true];

*/

private ["_validMen","_nearMen","_medic"];

_validMen = [];

_nearMen = (getPos player nearEntities ["Man",300]);
{
	if (isPlayer _x) then
	{
		_nearMen deleteAt _forEachIndex;
	};
} forEach _nearMen;
		
if ((count _nearMen) > 0) then
{
	{
		if ((side _x isEqualTo Ghosts_FriendlySide) && (_x getVariable ["Ghosts_isMedic",false] isEqualTo true)) then
		{
			_validMen pushBack [_x,(_x distance player)];
		};
	} forEach _nearMen;
};
_validMen sort true;
_validMen