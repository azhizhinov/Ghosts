private ["_position","_foundPos"];

_position = _this select 0;

_foundPos = true;

{
	if (alive _x) then
	{	
		if ((_position distance _x) > 150) then
		{
			_foundPos = true;
		}
		else
		{
			_foundPos = false;
		};
	};	

} forEach allPlayers;

_foundPos