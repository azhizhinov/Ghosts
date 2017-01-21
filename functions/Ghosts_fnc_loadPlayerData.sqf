private ["_playerLoaded","_playerData"];

_playerData = profileNamespace getVariable ["Ghosts_playerData",-1];

if (_playerData isEqualTo -1) exitWith
{
	[] call Ghosts_fnc_createNewPlayer;
};

/** Side check **/

[_playerData] spawn
{
	private ["_timelimit","_timer","_playerData","_serverKey","_allData","_playerID"];

	_allData = _this select 0;

	_playerData = _allData select 0;
	_playerID = _allData select 1;

	[_allData,_playerID,(player call BIS_fnc_netID)] remoteExecCall ["Ghosts_server_fnc_checkPlayerIntegrity", 2, false];
	//[_allData,_playerID, netID player] remoteExecCall ["Ghosts_server_fnc_checkPlayerIntegrity", 2, false];

	uiSleep 2;

	if (player getVariable ["Ghosts_playerIsAccepted",-1] isEqualTo true) then
	{
		if !(side player isEqualTo (_playerData select 6)) then
		{
			Ghosts_spawnSuicideAction = player addAction ["Suicide",
			{
				_caller = _this select 0;
		       	_action = _this select 2;
		        _caller removeAction _action;

				player setDamage 1;

				player setVariable ["Ghosts_playerData",-1];
				profileNameSpace setVariable ["Ghosts_playerData",-1];
				saveProfileNamespace;
			}];

			_timer = 0;
			_timelimit = 30;

			while {true} do
			{
				titleText [format["Your current side is different to your characters saved side -- You have %1 seconds to respawn or be removed to the lobby",(_timelimit - _timer)],"PLAIN"];
				_timer = _timer + 1;

				uiSleep 1;

				if !(alive player) exitWith 
				{
					Ghosts_playerLoaded = true;
				};

				if (_timer > _timelimit) exitWith
				{
					profileNameSpace setVariable ["Ghosts_playerData",-1,true];
					saveProfileNamespace;

					uiSleep 1;

					endMission "LOSER";
				};
			};	
		}
		else
		{
			Ghosts_bloodLevel = player getVariable ["Ghosts_bloodLevel",(_playerData select 0)];
			player setDamage (_playerData select 1);
			player setPosATL (_playerData select 2);
			player setUnitLoadout [(_playerData select 3),false];
			Ghosts_playerKills = player getVariable ["Ghosts_playerKills",(_playerData select 4)];
			player setVariable ["Ghosts_playerIsBleeding",(_playerData select 5),true];
			player setVariable ["Ghosts_playerSide",(_playerData select 6),true];
			player setVariable ["Ghosts_playerStash",(_playerData select 7 select 0),true];

			Ghosts_playerLoaded = true;
			player setVariable ["Ghosts_playerData",1];

			player addEventHandler ["HandleDamage", { _this call Ghosts_fnc_handleDamage;}];
			player addEventHandler ["Respawn", { _this call Ghosts_fnc_handleRespawn; }];
			player addMPEventHandler ["MPKilled", { _this call Ghosts_fnc_onMPKilled; }];
			player addEventHandler ["Put",{ _this call Ghosts_fnc_onPut; }];
			player addEventHandler ["Take",{ _this call Ghosts_fnc_onTakeFromStash; }];
		};	
	}
	else
	{

		Ghosts_spawnSuicideAction = player addAction ["Suicide",
		{
			_caller = _this select 0;
	       	_action = _this select 2;
	        _caller removeAction _action;

			player setDamage 1;

			player setVariable ["Ghosts_playerData",-1];
			profileNameSpace setVariable ["Ghosts_playerData",-1];
			saveProfileNamespace;
		}];

		_timer = 0;
		_timelimit = 30;

		while {true} do
		{
			titleText [format["Data saved on the server does not match your profie - Did you try and hack it? Naughty.. If you did not, contact your server admin -- Suicide or be kicked in %1",(_timelimit - _timer)],"PLAIN"];
			_timer = _timer + 1;

			uiSleep 1;

			if !(alive player) exitWith 
			{
				Ghosts_playerLoaded = true;
			};

			if (_timer > _timelimit) exitWith
			{
				profileNameSpace setVariable ["Ghosts_playerData",-1,true];
				saveProfileNamespace;

				uiSleep 1;

				endMission "LOSER";
			};
		};	
	};	
};

