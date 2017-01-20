private ["_player","_container","_item"];

_player = _this select 0;
_container = _this select 1;
_item = _this select 2;

if (_container getVariable ["Ghosts_server_playerStash",-1] isEqualTo true) then
{
	_currentStash = player getVariable ["Ghosts_playerStash",[]];
	_stashIndex = _currentStash find _item;
	_currentStash deleteAt _stashIndex;

	player setVariable ["Ghosts_playerStash",_currentStash];

	[false] call Ghosts_fnc_savePlayerData;
};