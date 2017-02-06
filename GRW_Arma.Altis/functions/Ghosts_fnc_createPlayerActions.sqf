/*

*/

//private [""];

Ghosts_has_callMedic_action = false;
Ghosts_has_reviveAction = false;

Ghosts_callMedic_action =
["Call medic",
{

    private ["_validMen"];

    _validMen = [] call Ghosts_fnc_findValidMedics;
    if (isNil "_validMen") then
    {
        _validMen = [];
    };  
    if ((count _validMen) > 0) then
    {
        if !(Ghosts_medicIsOnTheWay) then
        {   
            Ghosts_medicIsOnTheWay = true;

            _medic = (_validMen select 0 select 0);
            _medic doMove position player;
            _medicName = name _medic;

            titleText [format["%1 is on his way to revive you",_medicName],"PLAIN DOWN"];

            [_medic] spawn
            {   
                private ["_medic"];

                _medic = _this select 0;

                while {true} do
                {
                    _playerPos = [position player,3] call Ghosts_fnc_findRandomPositionInCircle;
                    //_medic doMove _playerPos;
                    [_medic, _playerPos] remoteExec ["doMove",2,false];
                    if ((_medic distance player) < 5) exitWith
                    {
                        if (alive _medic) then
                        {   
                            _items = [];

                            _medic attachTo [player, [0.8, 0, 0], "Chest"];

                            _bandage = createVehicle ["Land_Bandage_F", position player, [], 0, "CAN_COLLIDE"];
                            _bandage1 = createVehicle ["Land_Bandage_F", position player, [], 0, "CAN_COLLIDE"];    
                            _defib = createVehicle ["Land_Defibrillator_F",position player, [], 0, "CAN_COLLIDE"];                          

                            _bandage attachTo [player, [0.9, 0, 0], "head"]; 
                            _bandage1 attachTo [player, [0.6, 0.2, 0], "head"]; 
                            _defib attachTo [player, [0.8, 0.4, 0], "pelvis"];

                            detach _bandage;
                            detach _bandage1;
                            detach _defib;
                            {
                                _items pushBack _x;
                            } forEach [_bandage,_bandage1,_defib];  

                            uiSleep 0.5;

                            _medic setDir 270;
                            _bandage setDir (random 360);
                            _bandage1 setDir (random 360);
                            _defib setDir (random 360);

                            //_medic playAction "MedicOther";
                            [_medic, "medicOther"] remoteExec ["playAction",2,false];
                            sleep 7;
                            detach _medic;                          
                            player setUnconscious false;
                            player setVariable ["Ghosts_PlayerIsUnconcious",false,true];
                            player allowDamage true;
                            Ghosts_medicIsOnTheWay = false;
                            
                            [_items] spawn
                            {
                                _items = _this select 0;
                                uiSleep 10;
                                {
                                    deleteVehicle _x;
                                } forEach _items;
                            };
                        };  
                    };
                    if !(alive _medic) exitWith 
                    {
                        titleText ["The medic has died while trying to reach you..","PLAIN DOWN"];
                        Ghosts_medicIsOnTheWay = false;
                    };
                    uiSleep 2;
                };  
            };
        }
        else
        {
            titleText ["A medic is already on his way to assist you..","PLAIN DOWN"];
        };  
    }
    else
    {
        titleText ["There are no medics nearby to help you..","PLAIN DOWN"];
    };  

},"",0,false,true,"","player getVariable ['Ghosts_PlayerIsUnconcious',false] isEqualTo true && !Ghosts_medicIsOnTheWay",15,true];

Ghosts_userActions pushBack 
[
    [
        Ghosts_callMedic_action,
        "Ghosts_has_callMedic_action",
        "Ghosts_has_callMedic_action_current",
        "player getVariable ['Ghosts_PlayerIsUnconcious',false] isEqualTo true && !Ghosts_medicIsOnTheWay",
        false
    ] 
];

Ghosts_reviveAction = ["Revive",
{

    private ["_target"];

    _target = cursorTarget;
    player playAction "Medic";

    sleep 4;

    [_target, false] remoteExec ["setUnconscious",2,false];
    _target setVariable ["Ghosts_PlayerIsUnconcious",false,true];


},"",0,false,true,"","[cursorTarget] call Ghosts_fnc_targetLifeState",15,true];

Ghosts_userActions pushBack 
[
    [
        Ghosts_reviveAction,
        "Ghosts_has_reviveAction",
        "Ghosts_has_reviveAction_current",
        "[cursorTarget] call Ghosts_fnc_targetLifeState",
        false
    ] 
];