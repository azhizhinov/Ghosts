_player = _this select 0;
//_corpse = _this select 1;

//deleteVehicle _corpse;

player setVariable ["Ghosts_playerData",-1];
profileNameSpace setVariable ["Ghosts_playerData",-1];
saveProfileNamespace;

[] call Ghosts_fnc_loadPlayerData;