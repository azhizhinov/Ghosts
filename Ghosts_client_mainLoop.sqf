/*

	Main loop to handle player effects / changes / required function calls

*/

private ["_timeRemaining"];

waitUntil 
{
	Ghosts_playerLoaded
};

while {true} do
{
	if !(player getVariable ["Ghosts_playerData",-1] isEqualTo -1) then
	{	
		if (time - Ghosts_userAction_checkTime >= Ghosts_userAction_checkTime_stamp) then
		{
			[] call Ghosts_fnc_handlePlayerActions;
			Ghosts_userAction_checkTime_stamp = time;
		};

		/** Blood Regen **/

		if ((time - Ghosts_bloodRegenCoolDown >= Ghosts_lastBloodRegen)	&& (player getVariable ["Ghosts_playerIsBleeding",-1] isEqualTo -1) && (Ghosts_bloodLevel < 1200)) then
		{
			Ghosts_bloodLevel = Ghosts_bloodLevel + Ghosts_bloodRegenPerTick;

			if (Ghosts_bloodRegenPerTick >= 12000) then
			{
				player setDamage (damage player) - 0.01;
			};
			Ghosts_lastBloodRegen = time;
		};

		/** Blood Loss **/

		_isBleeding = player getVariable ["Ghosts_playerIsBleeding",-1];
		_timeRemaining = _isBleeding select 1;

		if (!(_isBleeding isEqualTo -1) && (time - Ghosts_bloodlossCoolDown >= Ghosts_lastBloodLossTick)) then
		{
			[30] call BIS_fnc_bloodEffect;

			Ghosts_lastBloodLossTick = time;
			Ghosts_bloodLevel = Ghosts_bloodLevel - floor (random 300);

			_timeRemaining = _timeRemaining - 1;

			if (_timeRemaining > 0) then
			{	
				player setVariable ["Ghosts_playerIsBleeding",[true,_timeRemaining],true];
			}
			else
			{
				player setVariable ["Ghosts_playerIsBleeding",-1,true];
			};

			if (Ghosts_bloodLevel <= 0) then
			{
				player setDamage 1;
				player setVariable ["Ghosts_playerIsBleeding",-1,true];
				player setVariable ["Ghosts_PlayerIsUnconcious",false,false];
				player allowDamage true;
				Ghosts_bloodLevel = 0;
			};	
		};

		/** Display stats **/
		
		_currentDamage = damage player;
		_health = 100 - (damage player * 100);
		
		hint parseText format 
		["
			<t align='center' size='2'>Debug Monitor</t><br/>
			<t align='left'>Blood:</t><t align='right'>%1<br/>
			<t align='left'>Health:</t><t align='right'>%2</t><br/>
			<t align='left'>Kills:</t><t align='right'>%3</t><br/>
			",
			Ghosts_bloodLevel,
			round _health,
			player getVariable ["Ghosts_playerKills",0]	
		];

		/** Save Player Data **/

		if (time - Ghosts_playerSaveInterval >= Ghosts_lastPlayerSaveTick) then
		{
			Ghosts_lastPlayerSaveTick = time;
			[false] call Ghosts_fnc_savePlayerData;
			systemChat "Your player data has been synced with the server";
		};
	};

	player addRating -100000;

	uiSleep 2;	
};