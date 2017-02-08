

/**	Initialize server starting params, objects and AI **/

setDate [2017, 2, 25, floor (random 23), 0];
[] call Ghosts_server_fnc_weatherUpdate;
forceWeatherChange;

[] call Ghosts_server_fnc_spawnAirPatrol;

for "_i" from 0 to 10 + floor (random 5) do
{
	
	[
		[false,[0,0,0]], 	// Force AI to move to specific position after spawning - Params - 0: Boolean, enable 1: Position to move to
		"TOWN",				// if "TOWN" AI will spawn at a random town other wise, "RANDOM"
		2,					// Amount of AI groups to spawn this call
		1,					// minimum soldiers per group
		3,					// Maximum soldiers per group
		150					// Roaming radius
	]

	call Ghosts_fnc_spawnAIGroup;

	[
		[false,[0,0,0]], 	// Force AI to move to specific position after spawning - Params - 0: Boolean, enable 1: Position to move to
		"RANDOM",			// if "TOWN" AI will spawn at a random town other wise, position 
		2,					// Amount of AI groups to spawn this call
		1,					// minimum soldiers per group
		3,					// Maximum soldiers per group
		150					// Roaming radius
	]

	call Ghosts_fnc_spawnAIGroup;
};

/** Start the main server thread **/

while {true} do
{

	if (time - Ghosts_server_AI_town_spawnInterval >= Ghosts_server_AI_town_spawnInterval_timestamp) then
	{	
		Ghosts_server_AI_town_spawnInterval_timestamp = time;
		[
			[false,[0,0,0]], 	// Force AI to move to specific position after spawning - Params - 0: Boolean, enable 1: Position to move to
			"TOWN",				// if "TOWN" AI will spawn at a random town other wise, "RANDOM"
			2,					// Amount of AI groups to spawn this call
			1,					// minimum soldiers per group
			3,					// Maximum soldiers per group
			150					// Roaming radius
		]

		call Ghosts_fnc_spawnAIGroup;
	};

	if (time - Ghosts_server_AI_random_spawnInterval >= Ghosts_server_AI_random_spawnInterval_timestamp) then
	{	
		Ghosts_server_AI_random_spawnInterval_timestamp = time;
		[
			[false,[0,0,0]], 	// Force AI to move to specific position after spawning - Params - 0: Boolean, enable 1: Position to move to
			"RANDOM",			// if "TOWN" AI will spawn at a random town other wise, position 
			2,					// Amount of AI groups to spawn this call
			1,					// minimum soldiers per group
			3,					// Maximum soldiers per group
			150					// Roaming radius
		]

		call Ghosts_fnc_spawnAIGroup;
	};
	
	if (time - Ghosts_server_airPatrolInterval >= Ghosts_server_airPatrol_timestamp) then
	{
		[] call Ghosts_server_fnc_spawnAirPatrol;
		Ghosts_server_airPatrol_timestamp = time;
	};

	/** Weather **/

	if (time - Ghosts_server_weatherChangeInterval >= Ghosts_server_weatherChangeInterval_timeStamp) then
	{
		[] call Ghosts_server_fnc_weatherUpdate;
		Ghosts_server_weatherChangeInterval_timeStamp = time;
	};	
	
	/** Call marker cleanup func **/
	
	[] call Ghosts_fnc_maintainOccupationMarkers;

	/** Time multiplyer **/

	if ((time > 17) && (time < 5)) then
	{
		setTimeMultiplier 10;
	}
	else
	{
		setTimeMultiplier 5;
	};	

	/** Simulation manager **/

	//[] call Ghosts_server_fnc_simulationManager;

	{
		_x removeAllMPEventHandlers "MPKilled";
		_x addMPEventHandler ["MPKilled", { _this call Ghosts_fnc_onMPKilled; }];
	} forEach playableUnits;

	uiSleep 15;
};	