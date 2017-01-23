private ["_cfgArray","_xPos","_yPos","_veh","_names"];
 
_cfgArray = "
( 
    (getNumber (_x >> 'Type') isEqualTo 1) && (getText (_x >> 'author') isEqualTo 'Red Hammer Studios')

)" configClasses (configFile >> "CfgWeapons");

_xPos = 0;
_yPos = 0;

_names = [];

{
    _names pushBack (configName _x);

} forEach _cfgArray;

copyToClipBoard str _names;

/**

private ["_cfgArray","_xPos","_yPos","_veh","_names"];
 
_cfgArray = "(getText (_x >> 'author') isEqualTo 'Red Hammer Studios')" configClasses (configFile >> "CfgVehicles");

_names = [];

{
	_className = configName _x;
	_find = _className find "FRITH";

	if !(_find isEqualTo -1) then
	{
		if (([_className] call BIS_fnc_itemType select 1) isEqualTo "Backpack") then
		{		
			_names PushBack _className;
		};	
	};


} forEach _cfgArray;

copyToClipBoard str _names;


/**

private ["_cfgArray","_xPos","_yPos","_veh","_names"];
 
_cfgArray = "(getText (_x >> 'author') isEqualTo 'Red Hammer Studios')" configClasses (configFile >> "CfgVehicles");

_names = [];

{
	_className = configName _x;
	if (([_className] call BIS_fnc_itemType select 1) isEqualTo "Backpack") then
	{		
		_names PushBack _className;
	};

} forEach _cfgArray;

copyToClipBoard str _names;