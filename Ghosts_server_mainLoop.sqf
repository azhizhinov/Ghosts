/*

	Handle server side functions

*/

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

	uiSleep 60;
};	