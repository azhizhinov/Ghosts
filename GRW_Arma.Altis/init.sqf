/*

	By Johno: 
	Usage -

	Medics require a variable - this setVariable ["Ghosts_isMedic",true];

*/

if (isServer) then
{
	//[] execVM "server\Ghosts_fnc_initServer.sqf";
};	

//[] execVM "intro\Ghosts_intro.sqf";

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

rescue_inbound = false;

player addEventHandler ["HandleDamage", { _this call Ghosts_fnc_handleDamage;}];

uiSleep 5;

[] call Ghosts_fnc_createPlayerActions;

[] execVM "Ghosts_client_mainLoop.sqf";

[west,"Rescue",["Track down and rescue the downed NATO pilot","Rescue"],(getMarkerPos "rescue"),true,1,false,"scout",true] call BIS_fnc_taskCreate;
[west,["task1","Rescue"],["Search the area for clues as to the whereabouts of the pilot","Breadcrumbs"],(getMarkerPos "task1_marker"),true,1,false,"default",true] call BIS_fnc_taskCreate;