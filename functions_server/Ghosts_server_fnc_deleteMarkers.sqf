/*

	Delete global markers

*/

{
	if (time - (_x select 1) >= _x select 2) then
	{
		deleteMarker (_x select 0);
		Ghosts_map_currentMarkers deleteAt _forEachIndex;
	};	
} forEach Ghosts_map_currentMarkers;