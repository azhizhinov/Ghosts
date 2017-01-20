private ["_player","_container","_item"];

_player = _this select 0;
_container = _this select 1;
_item = _this select 2;

if (_container getVariable ["Ghosts_server_playerStash",-1] isEqualTo true) then
{
	_currentStash = player getVariable ["Ghosts_playerStash",[]];

	_type = [_item] call BIS_fnc_itemType;

	_catagory = _type select 0;
	_itemType = _type select 1;

	switch (_itemType) do
	{
		case "Uniform":
		{
			titleText ["Ensure you remove all items from uniforms and vests and store them seperately.","PLAIN"];
		};
		case "Vest":
		{
			titleText ["Ensure you remove all items from uniforms and vests and store them seperately.","PLAIN"];
		};
	};

	_currentStash pushBack _item;

	player setVariable ["Ghosts_playerStash",_currentStash];

	[false] call Ghosts_fnc_savePlayerData;
};