private["_position","_radius","_roads","_numberOfRoads","_road"];
_position = _this select 0;
_radius = _this select 1;
_roads = _position nearRoads _radius;
_numberOfRoads = count _roads;
if (_numberOfRoads > 0) then
{
    _road = _roads select floor(random _numberOfRoads); 
    _position = getPos _road;
    _radius = 30;
};
_position = _position findEmptyPosition [0, _radius];
_position