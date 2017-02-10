private ["_wrecks","_randWreck","_roadPosition","_position","_wreckVehicle","_invisibleSelections","_randomSmoke","_holder","_holders","_randomSelection","_selection","_item","_smoke","_tabsSpawned"];

Ghosts_allWorldPersistantObjects = profileNamespace getVariable "Ghosts_allWorldPersistantObjects";

if (isNil "Ghosts_allWorldPersistantObjects") then
{
	Ghosts_allWorldPersistantObjects = [];
};

if (Ghosts_allWorldPersistantObjects isEqualTo []) then
{
	for "_i" from 1 to 50 do 
	{
		_wrecks =
		[
			"a3\structures_f\wrecks\wreck_skodovka_f.p3d",
			"a3\structures_f\wrecks\wreck_Car_f.p3d",
			"a3\structures_f\wrecks\Wreck_Ural_F.p3d",
			"a3\structures_f\wrecks\Wreck_Truck_F.p3d",
			"a3\structures_f\wrecks\Wreck_UAZ_F.p3d",
			"a3\structures_f\wrecks\Wreck_BRDM2_F.p3d",
			"a3\structures_f\wrecks\Wreck_Hunter_F.p3d",
			"a3\structures_f\wrecks\Wreck_Offroad_F.p3d",
			"a3\structures_f\wrecks\Wreck_Car2_F.p3d",
			"a3\structures_f\wrecks\Wreck_Car3_F.p3d",
			"a3\structures_f\wrecks\Wreck_Offroad2_F.p3d",
			"a3\structures_f\wrecks\Wreck_Slammer_F.p3d",
			"a3\structures_f\wrecks\Wreck_Slammer_hull_F.p3d"
		];

		_randWreck = selectRandom _wrecks;
		_roadPosition = [(getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition")),30000] call Ghosts_server_fnc_findRoadPosition;
		_position = [_roadPosition,10] call Ghosts_fnc_findRandomPositionInCircle;

		_wreckVehicle = createSimpleObject [_randWreck,_position];

		_invisibleSelections = ["zasleh", "zasleh2", "box_nato_grenades_sign_f", "box_nato_ammoord_sign_f", "box_nato_support_sign_f"];
		{
	        if ((toLower _x) in _invisibleSelections) then 
	        {
	            _wreckVehicle hideSelection [_x, true];
	        };
	    }
	    forEach (selectionNames _wreckVehicle);

		_wreckVehicle setDir random 360;
	    _wreckVehicle setPosATL [position _wreckVehicle select 0,position _wreckVehicle select 1, 0];
	    _wreckVehicle setVectorUp surfaceNormal position _wreckVehicle;
	    _smoke = false;
	    if (random 1 > 0.95) then
	    {	
		    _randomSmoke = "test_EmptyObjectForSmoke" createVehicle _position;  
			_randomSmoke setPosATL (position _wreckVehicle);
			_smoke = true;
		};

		Ghosts_allWorldPersistantObjects pushBack [(getPosATL _wreckVehicle),(getDir _wreckVehicle),_randWreck,_smoke];

		uiSleep 0.1;
	};

	profileNamespace setVariable ["Ghosts_allWorldPersistantObjects",Ghosts_allWorldPersistantObjects];
	saveProfileNamespace;
}
else
{
	{
		_wreckVehicle = createSimpleObject [(_x select 2),(_x select 0)];

		_invisibleSelections = ["zasleh", "zasleh2", "box_nato_grenades_sign_f", "box_nato_ammoord_sign_f", "box_nato_support_sign_f"];
		{
			private "_x";
	        if ((toLower _x) in _invisibleSelections) then 
	        {
	            _wreckVehicle hideSelection [_x, true];
	        };
	    }
	    forEach (selectionNames _wreckVehicle);

		_wreckVehicle setDir (_x select 1);
	    _wreckVehicle setPosATL [position _wreckVehicle select 0,position _wreckVehicle select 1, 0];
	    _wreckVehicle setVectorUp surfaceNormal position _wreckVehicle;

	    if ((_x select 3) isEqualTo true) then
	    {
	    	if (random 1 > 0.5) then
	    	{	
	    		_randomSmoke = "test_EmptyObjectForSmoke" createVehicle (position _wreckVehicle);  
				_randomSmoke setPosATL (position _wreckVehicle);
			};	
	    };

	} forEach Ghosts_allWorldPersistantObjects;
};