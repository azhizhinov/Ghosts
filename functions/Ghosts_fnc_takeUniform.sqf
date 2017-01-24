private ["_corpse","_uniformCorpse","_uniformItemsCorpse","_unfiromMagazinesCorpse","_uniformPlayer","_unfiromMagazinesPlayer","_uniformItemsPlayer"];

_corpse = _this select 0;

player playActionNow "PutDown";

_uniformCorpse = uniform _corpse;
_uniformItemsCorpse = uniformItems _corpse;
_unfiromMagazinesCorpse = magazinesAmmoCargo uniformContainer _corpse;

_uniformPlayer = uniform player;
_uniformItemsPlayer = uniformItems player;
_unfiromMagazinesPlayer = magazinesAmmoCargo uniformContainer player;

player forceAddUniform _uniformCorpse;
_corpse forceAddUniform _uniformPlayer;

/** Player **/

{
	player addMagazine [(_x select 0),(_x select 1)];
} forEach _unfiromMagazinesCorpse;

{
	_type = [_x] call BIS_fnc_itemType;
	if ((_type select 0) isEqualTo "Item") then
	{	
		player addItemToUniform _x;
	};	
} forEach _uniformItemsCorpse;

/** Corpse **/

{
	_corpse addMagazine [(_x select 0),(_x select 1)];
} forEach _unfiromMagazinesPlayer;

{
	_type = [_x] call BIS_fnc_itemType;
	if ((_type select 0) isEqualTo "Item") then
	{	
		_corpse addItemToUniform _x;
	};	
} forEach _uniformItemsPlayer;