private ["_unit","_killer","_oldKillerKills","_newKillerKills"];

_unit = _this select 0;

_killer = _unit getVariable ["Ghosts_lastSourceOfDamage",-1];

_unit setVariable ["Ghosts_playerData",-1,true];

if !(_killer isEqualTo -1) then
{	

	_oldKillerKills = _killer getVariable ["Ghosts_playerKills",-1];
	_newKillerKills = _oldKillerKills + 1;

	_killer setVariable ["Ghosts_playerKills",_newKillerKills,true];
};

if (_unit getVariable ["Ghosts_PlayerIsUnconcious",false] isEqualTo true) then
{
	_unit setUnconscious false;
};	