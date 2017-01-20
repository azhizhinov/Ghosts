/*

	Paramters:
	0 - Object

	Returns: Bool

*/

private ["_target","_unconcious"];

_target = _this select 0;
_unconcious = false;

if ((lifeState _target) isEqualTo "INCAPACITATED") then
{
	_unconcious = true;
};

_unconcious	