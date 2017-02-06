private ['_code', '_function', '_file'];

{
    _code = '';
    _function = _x select 0;
    _file = _x select 1;

    _code = compileFinal (preprocessFileLineNumbers _file);

    missionNamespace setVariable [_function, _code];
}
forEach
[
	["Ghosts_fnc_findValidMedics","functions\Ghosts_fnc_findValidMedics.sqf"],
	["Ghosts_fnc_findRandomPositionInCircle","functions\Ghosts_fnc_findRandomPositionInCircle.sqf"],
	["Ghosts_fnc_createPlayerActions","functions\Ghosts_fnc_createPlayerActions.sqf"],
	["Ghosts_fnc_handlePlayerActions","functions\Ghosts_fnc_handlePlayerActions.sqf"],
	["Ghosts_fnc_handleDamage","functions\Ghosts_fnc_handleDamage.sqf"],
	["Ghosts_fnc_targetLifeState","functions\Ghosts_fnc_targetLifeState.sqf"],
	["Ghosts_fnc_randomPatrol","functions\Ghosts_fnc_randomPatrol.sqf"],
	["Ghosts_fnc_playRandomAnim","functions\Ghosts_fnc_playRandomAnim.sqf"]
];

true

