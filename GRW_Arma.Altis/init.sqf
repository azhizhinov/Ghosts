/*

	By Johno: 
	Usage -

	Medics require a variable - this setVariable ["Ghosts_isMedic",true];

*/

if (isServer) then
{
	//[] execVM "server\Ghosts_fnc_initServer.sqf";
};	

[] execVM "intro\Ghosts_intro.sqf";

player setCustomAimCoef 0.3;
player enableFatigue false;
player enableStamina false;
player allowSprint true;

Ghosts_medicIsOnTheWay = false;
Ghosts_FriendlySide = WEST;

Ghosts_userActions = [];
Ghosts_userActionArray = [];
Ghosts_userActionTimeout_lastCheck = time;
Ghosts_userAction_checkTime = 2;
Ghosts_userAction_checkTime_stamp = time;
Ghosts_healthRegenTimeStamp = time;

player addEventHandler ["HandleDamage", { _this call Ghosts_fnc_handleDamage;}];

uiSleep 5;

[] call Ghosts_fnc_createPlayerActions;

[] execVM "Ghosts_client_mainLoop.sqf";