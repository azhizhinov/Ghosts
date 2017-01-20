private ["_unit","_container"];

_unit = _this select 0;
_container = _this select 1;

if (_container getVariable ["Ghosts_server_playerStash",-1] isEqualTo true) then
{
	clearWeaponCargo 	_container;
	clearItemCargo 		_container;
	clearMagazineCargo 	_container;
	clearBackpackCargo 	_container;

	_stashList = player getVariable ["Ghosts_playerStash",[]];

	{

		_type = [_x] call BIS_fnc_itemType;

		_catagory = _type select 0;

		switch (_catagory) do
		{
			case "Weapon":
			{
				_container addWeaponCargo [_x,1];
			};
			case "Magazine":
			{
				_container addMagazineCargo [_x,1];
			};
			case "Item":
			{
				_container addItemCargo [_x,1];
			};
			case "Equipment":
			{

			};
		};
	} forEach _stashList;
};	