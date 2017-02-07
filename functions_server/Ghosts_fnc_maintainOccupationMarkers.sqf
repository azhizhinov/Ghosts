private ["_marker","_ai","_aiCount","_markerText"];

{
	_marker = _x;
	_ai = [];
	{

		if ((alive _x) && !(isPlayer _x) && (_x distance (getMarkerPos _marker) < 200)) then
		{
			_ai pushBack _x;
		};
	} forEach allUnits;

	_aiCount = count _ai;
	_markerText = format ["Estimated hostiles - %1",_aiCount];
	_marker setMarkerText _markerText;

} forEach Ghosts_map_currentMarkers;