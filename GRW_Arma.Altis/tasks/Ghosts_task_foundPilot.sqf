_caller = _this select 0;
_action = _this select 2;

_caller removeAction _action;

survivor_1 playMoveNow "AmovPercMstpSrasWrflDnon";
[survivor_1] join player;
survivor_1 call BIS_fnc_ambientAnim__terminate;

[west,["task2","Rescue"],["Get the pilot to the extraction point","Evac"],(getMarkerPos "task2_marker"),true,1,true,"run",true] call BIS_fnc_taskCreate;
rescue_inbound = true;

["task1", "SUCCEEDED",true] spawn BIS_fnc_taskSetState;

//["Rescue", "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
/*
["You have completed the mission",true,true,true] call BIS_fnc_endMission;

//[west,["task2","Rescue"],["The documents you found indicate more hostile activity to the north","Revenge"],(getMarkerPos "task2_marker"),true,1,false,"default",true] call BIS_fnc_taskCreate;