private ["_groupLead","_group","_patrolRadius"];

_group = _this select 0;
_groupLead = leader _group;
_patrolRadius = _this select 1;

for "_i" from 0 to 3 do
{
	_randomPos = [(position _groupLead),_patrolRadius] call Ghosts_fnc_findRandomPositionInCircle;
	_wp = _group addWaypoint [_randomPos,5];
	_wp setWaypointSpeed "LIMITED";
	_wp setWaypointBehaviour "SAFE";
	_wp setWaypointType "MOVE";
	_wp setWaypointStatements["true","[this] spawn Ghosts_fnc_playRandomAnim"];

	if (_i isEqualTo 3) then
	{
		_wp setWaypointType "CYCLE";
	};	
};
true	