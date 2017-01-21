
private ["_playerData","_callingPlayerUID","_foundExistingPlayer","_dataSelection"];

_playerData = _this select 0;
_callingPlayerUID = _this select 1;
_isNew = _this select 2;

_foundExistingPlayer = false;

{
	if ((_x select 1) isEqualTo _callingPlayerUID) exitWith
	{
		_num = _forEachIndex;
		_dataSelection = _num;

		_foundExistingPlayer = true;
	};	
} forEach Ghosts_server_allSavedPlayerData;

if (_foundExistingPlayer) then
{	
	if !(_isNew) then
	{	
		Ghosts_server_allSavedPlayerData set [_dataSelection,[_playerData,_callingPlayerUID]];
	}
	else
	{
		_stash = _playerData select 7;
		Ghosts_server_allSavedPlayerData set [_dataSelection,[[[],_stash],_callingPlayerUID]];
	};	
}
else
{
	Ghosts_server_allSavedPlayerData pushBack [[],_callingPlayerUID];

	//hint "Inserted new player into server data base";
};	

profileNamespace setVariable ["Ghosts_server_allSavedPlayerData",Ghosts_server_allSavedPlayerData];
saveProfileNamespace;

//hint str (profileNamespace getVariable ["Ghosts_server_allSavedPlayerData",[]]);
//Ghosts_server_allSavedPlayerData pushBack [[],11111];
//profileNamespace setVariable ["Ghosts_server_allSavedPlayerData",Ghosts_server_allSavedPlayerData];
//hint str (profileNamespace getVariable ["Ghosts_server_allSavedPlayerData",[]]);