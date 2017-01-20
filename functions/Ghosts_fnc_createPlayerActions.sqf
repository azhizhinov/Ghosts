
Ghosts_has_reviveAction = false;
Ghosts_has_stashAction = false;

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
        "[cursorTarget] call Ghosts_fnc_targetLifeState && !Ghosts_has_reviveAction && player distance cursorObject < 2",
        false
    ] 
];



Ghosts_openStashAction = ["Access Stash",
{

    [] call Ghosts_fnc_accessPlayerStash;

},"",0,false,true,"","!Ghosts_player_isAccessingStash",15,true];

Ghosts_userActions pushBack 
[
    [
        Ghosts_openStashAction,
        "Ghosts_has_stashAction",
        "Ghosts_has_stashAction_current",
        "!Ghosts_player_isAccessingStash",
        false
    ] 
];