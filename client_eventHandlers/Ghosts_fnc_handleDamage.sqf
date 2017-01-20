/*

	Damage handler

*/

private ["_unit","_incomingDamage","_currentDamage","_damageRequired","_bloodLoss"];

_unit = _this select 0;
_incomingDamage = _this select 2;
_typeOfProjectile = _this select 4;

_currentDamage = damage _unit;
_damageRequired = 0.9;

player setVariable ["Ghosts_playerIsBleeding",60];

if ((_currentDamage + _incomingDamage) > _damageRequired) then
{		
	if (player getVariable ["Ghosts_PlayerIsUnconcious",false] isEqualTo false) then
	{
		player setDamage 0.99;
		player allowDamage false;
		player setVariable ["Ghosts_PlayerIsUnconcious",true,true];
		player setUnconscious true;
	};
};