private ["_stashList","_position"];

_intersectingObjectArray = lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0, 0, 0], AGLToASL positionCameraToWorld [0, 0, 50000], vehicle player, objNull, true, 1, "VIEW", "FIRE"];
_position = ASLtoAGL ((_intersectingObjectArray select 0) select 0);

if (player distance _position > 10) exitWith
{
	titleText ["Place your stash closer to where you are standing","PLAIN"];
};	

Ghosts_player_isAccessingStash = true;

Ghosts_player_stashBox = "BOX_NATO_AmmoVeh_F" createVehicleLocal _position;
Ghosts_player_stashBox setVariable ["Ghosts_server_playerStash",true];

clearWeaponCargo Ghosts_player_stashBox;
clearItemCargo Ghosts_player_stashBox;
clearMagazineCargo Ghosts_player_stashBox;
clearBackpackCargo Ghosts_player_stashBox;

Ghosts_player_stashBox addAction ["Dismiss stash",{deleteVehicle Ghosts_player_stashBox; Ghosts_player_isAccessingStash = false;}];

_stashList = player getVariable ["Ghosts_playerStash",[]];

{

	_type = [_x] call BIS_fnc_itemType;

	_catagory = _type select 0;
	_itemType = _type select 1;

	switch (_catagory) do
	{
		case "Weapon":
		{
			Ghosts_player_stashBox addWeaponCargo [_x,1];
		};
		case "Magazine":
		{
			Ghosts_player_stashBox addMagazineCargo [_x,1];
		};
		case "Item":
		{
			Ghosts_player_stashBox addItemCargo [_x,1];
		};
		case "Equipment":
		{	
			switch (_itemType) do
			{
				case "Backpack":
				{
					Ghosts_player_stashBox addBackpackCargo [_x,1];
				};
				case "Uniform":
				{
					Ghosts_player_stashBox addItemCargo [_x,1];
				};
				case "Headgear":
				{
					Ghosts_player_stashBox addItemCargo [_x,1];
				};
				case "Glasses":
				{
					Ghosts_player_stashBox addItemCargo [_x,1];
				};
				case "Vest":
				{
					Ghosts_player_stashBox addItemCargo [_x,1];
				};
			};		
		};
	};
} forEach _stashList;