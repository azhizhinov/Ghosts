
private ["_dataSelection"];

_playerData = _this select 0;
_callingPlayerUID = _this select 1;
//_playerObject = (_this select 2) call BIS_fnc_objectFromNetID;
_playerObject = objectFromNetId (_this select 2);

_accepted = false;

{
	if ((_x select 1) isEqualTo _callingPlayerUID) exitWith
	{
		_num = _forEachIndex;
		_dataSelection = _num;
	};	
} forEach Ghosts_server_allSavedPlayerData;

_serverSideData = Ghosts_server_allSavedPlayerData select _dataSelection;

if (_playerData isEqualTo _serverSideData) then
{
	_accepted = true;
};

_playerObject setVariable ["Ghosts_playerIsAccepted",_accepted,true];