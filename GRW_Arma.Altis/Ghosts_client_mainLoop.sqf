/*

	Main loop to handle player effects / changes / required function calls

*/

while {true} do
{
	if (time - Ghosts_userAction_checkTime >= Ghosts_userAction_checkTime_stamp) then
	{
		[] call Ghosts_fnc_handlePlayerActions;
		Ghosts_userAction_checkTime_stamp = time;
	};	

	_damage = 100 - (damage player * 100);
	hint str _damage;

	if ((_damage < 100) && (time - 30 >= Ghosts_healthRegenTimeStamp) && (player getVariable ["Ghosts_PlayerIsUnconcious",-1]) isEqualTo false) then
	{
		player setDamage (damage player - 0.01);
		titleText ["My wounds are healing..","PLAIN DOWN"];
		Ghosts_healthRegenTimeStamp = time;
	};
	uiSleep 1;
};	

