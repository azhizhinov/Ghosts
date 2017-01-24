private["_stopPropagation","_caller","_keyCode","_shiftState","_controlState","_altState"];

_stopPropagation = false;
_caller = _this select 0;
_keyCode = _this select 1;
_shiftState = _this select 2;
_controlState = _this select 3;
_altState = _this select 4; 

switch (_keyCode) do  
{ 
	/*
	case 0x29:	{ _stopPropagation = true; }; 
	case 0x0B:	{ _stopPropagation = true; };
	case 0x06: 	{ _stopPropagation = true; };
	case 0x07: 	{ _stopPropagation = true; };
	case 0x08: 	{ _stopPropagation = true; };
	case 0x09: 	{ _stopPropagation = true; };
	case 0x0A: 	{ _stopPropagation = true; };
	*/

	// F1
	case 0x3B: 	
	{ 
		_stopPropagation = true; 
	};
	// F2
	case 0x3C: 	
	{ 
		_stopPropagation = true; 
	};
	// F3
	case 0x3D:	
	{ 
		_stopPropagation = true; 
	};
	// F4
	case 0x3E:	
	{ 
		player action ["sitDown", player];
		_stopPropagation = true; 
	};
	// F5
	case 0x3F:	
	{ 
		if (isNil "earPlugs") then
		{
			earPlugs = false;
		};
		if !(earPlugs) then
		{
			7 fadeSound 0.2;
			earPlugs = true;
			titleText ["Ear plugs ENABLED","PLAIN DOWN",0.2];
		}
		else
		{
			7 fadeSound 1;
			earPlugs = false;
			titleText ["Ear plugs DISABLED","PLAIN DOWN",0.2];
		};	

		_stopPropagation = true; 
	};
	// F6
	case 0x40: 	
	{	
		_stopPropagation = true; 
	};
	/*
	case 0x41: 	{ _stopPropagation = true; };
	case 0x42:	{ _stopPropagation = true; };
	case 0x43: 	{ _stopPropagation = true; };
	case 0x44:	{ _stopPropagation = true; };
	case 0x57: 	{ _stopPropagation = true; };
	case 0x58: 	{ _stopPropagation = true; };
	case 0x0E: 	{ _stopPropagation = true; };
	case 0xCF:	{ _stopPropagation = true; };
	case 0xC7:	{ _stopPropagation = true; };
	case 0x02: 	
	{ 
		_stopPropagation = true; 
	};
	case 0x03: 	
	{ 
		_stopPropagation = true; 
	};
	case 0x04: 	
	{ 
		_stopPropagation = true; 
	};
	case 0x05: 	
	{ 
		_stopPropagation = true;
	};
	case 0xD2:
	{
		_stopPropagation = true;
	};
	case 0x10:
	{
	
	};
	case 0x12:
	{
		
	};
	case 0xC9: 
	{
	
	};
	case 0xD1: 
	{
		
	};
	case 0x39:
	{
		
	};
	case 0x01:
	{
	
	};
	*/
};
_stopPropagation