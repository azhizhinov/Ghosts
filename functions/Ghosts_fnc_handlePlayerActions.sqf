private ["_canAdd"];
{
	_action = (_x select 0) select 0;
	_condition = (_x select 0) select 3;
		
	_compile = compile _condition;
	_canAdd = call _compile;
	
	if (_canAdd) then
	{
		if (isNil ((_x select 0) select 2)) then
		{		
			_currentAction = player addAction _action;

			missionNamespace setVariable [(_x select 0) select 1,true];
			missionNamespace setVariable [(_x select 0) select 2,_currentAction];
			Ghosts_userActionArray pushBack _currentAction;
		};	
	};
} forEach Ghosts_userActions;


if ((time - Ghosts_userActionTimeout_lastCheck >= 30) || !(alive player)) then
{
	Ghosts_userActionTimeout_lastCheck = time;
	
	{
		player removeAction _x;
	} forEach Ghosts_userActionArray;

	Ghosts_userActionArray = [];	

	{
		missionNamespace setVariable [(_x select 0) select 1,false];
		missionNamespace setVariable [(_x select 0) select 2,nil];
	} forEach Ghosts_userActions;
};