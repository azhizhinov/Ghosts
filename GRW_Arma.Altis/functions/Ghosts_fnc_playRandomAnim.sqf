private ["_unit","_anim","_timer"];

if (random 1 > 0.2) exitWith {};

_unit = _this select 0;

_anim = (selectRandom ["Acts_AidlPercMstpSlowWrflDnon_pissing","AidlPercMstpSrasWrflDnon_G02","AidlPercMstpSrasWrflDnon_G04","Acts_Briefing_SA_Loop","Acts_AidlPercMstpSlowWrflDnon_warmup05","Acts_AidlPercMstpSlowWrflDnon_warmup04","Acts_AidlPercMstpSlowWrflDnon_warmup03"]);

_unit playMoveNow _anim;

_timer = 0;
while {true} do
{
	_timer = _timer + 1;
	if ((behaviour _unit isEqualTo "COMBAT") || (_timer > 30)) exitWith
	{
		_unit playMoveNow "AmovPercMstpSrasWrflDnon";
	};
	uiSleep 1;	
};	
