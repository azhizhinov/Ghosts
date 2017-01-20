
/*

	paramters:
	
	_typeOfProjectile


*/

_bullet = _this select 0;

_bulletArrayLow = 
[

	//pistol
	"B_45ACP_Ball",
	"B_45ACP_Ball_Green",
	"B_45ACP_Ball_Yellow",
	"B_9x21_Ball",
	"B_9x21_Ball_Tracer_Green",
	"B_9x21_Ball_Tracer_Red",
	"B_9x21_Ball_Tracer_Yellow",
	
	
	"rhs_B_9x18_57N181S",
	"rhs_B_9x19_7N21",
	"rhs_B_9x19_7N31",
	"rhs_ammo_45ACP_MHP",
	"rhs_ammo_9x19_FMJ",
	"rhs_ammo_9x19_JHP",

	//explosive
	"IEDLandBig_Remote_Ammo",
	"IEDUrbanBig_Remote_Ammo",
	"DemoCharge_Remote_Ammo",
	"SatchelCharge_Remote_Ammo",
	"ClaymoreDirectionalMine_Remote_Ammo",
	"APERSTripMine_Wire_Ammo",
	"APERSBoundingMine_Range_Ammo",
	"APERSMine_Range_Ammo",
	"rhs_g_vg40tb",
	"rhs_g_vog25",
	"rhs_g_vog25p",
	"rhs_rpg7v2_og7v",
	"rhs_rshg2_rocket",
	"rhs_rpg7v2_tbg7v",
	"rhs_ammo_smaw_HEDP",
	"rhsusf_40mm_HE",
	
	//hand grenade
	"rhs_ammo_rgo",
	"rhs_ammo_rgd5",
	"rhs_ammo_rgn",
	"rhs_ammo_rgn_exp",
	"rhs_ammo_rgo_exp"

];

_bulletArrayMed = 
[
	//small arms
	
	//APEX
	"B_580x42_Ball_F",
	"B_762x39_Ball_F",
	"B_762x39_Ball_Green_F",
	"B_545x39_Ball_F",
	"B_545x39_Ball_Green_F",
	
	
	"B_556x45_Ball",
	"B_556x45_Ball_Tracer_Red",
	"B_556x45_Ball_Tracer_Green",
	"B_556x45_Ball_Tracer_Yellow",
	"rhs_ammo_556x45_M855A1_Ball",
	"rhs_ammo_556x45_M855A1_Ball_Green",
	"rhs_ammo_556x45_M855A1_Ball_Orange",
	"rhs_ammo_556x45_M855A1_Ball_Red",
	"rhs_ammo_556x45_M855A1_Ball_Yellow",
	"rhs_ammo_556x45_Mk262_Ball",
	"rhs_ammo_556x45_Mk318_Ball",
	"rhs_B_545x39_7N10_Ball",
	"rhs_B_545x39_7N22_Ball",
	"rhs_B_545x39_7N24_Ball",
	"rhs_B_545x39_7U1_Ball",
	"rhs_B_545x39_Ball",
	"rhs_B_545x39_Ball_Tracer_Green",
	"rhs_B_762x39_Ball",
	"rhs_B_762x39_Ball_89",
	"rhs_B_762x39_Tracer",
	"rhs_B_762x39_U_Ball",
	"B_65x39_Caseless",
	"B_65x39_Caseless_green",
	"B_65x39_Caseless_yellow",
	"B_65x39_Minigun_Caseless_Red_splash",
	"B_65x39_Case",
	"B_65x39_Case_Green",
	"B_65x39_Minigun_Caseless_Green_splash",
	"B_65x39_Case_Yellow",
	"B_65x39_Minigun_Caseless_Yellow_splash"
	

];

_bulletArrayHigh = 
[
	//small arms
	
	//APEX
	"B_50BW_Ball_F",
	
	"rhs_ammo_762x51_M118_Special_Ball",
	"rhs_ammo_762x51_M61_AP",
	"rhs_ammo_762x51_M62_tracer",
	"rhs_ammo_762x51_M80_Ball",
	"rhs_ammo_762x51_M80A1EPR_Ball",
	"rhs_ammo_762x51_M993_Ball",
	"rhs_B_762x54_7BZ3_Ball",
	"rhs_B_762x54_7N1_Ball",
	"rhs_B_762x54_7N13_Ball",
	"rhs_B_762x54_7N26_Ball",
	"rhs_B_762x54_Ball",
	"rhs_B_762x54_Ball_Tracer_Green",
	"rhs_B_9x39_SP5",
	"rhs_B_9x39_SP6",
	"rhsusf_B_300winmag",
	"B_762x51_Ball",
	"B_762x54_Ball",
	"B_762x51_Tracer_Red",
	"B_762x51_Tracer_Yellow",
	"B_762x51_Tracer_Green",
	"B_762x54_Tracer_Green",
	"B_762x51_Minigun_Tracer_Red_splash",
	"B_762x51_Minigun_Tracer_Yellow_splash"

];
_bulletArrayExtreme =
[	
	"rhs_ammo_127x107mm",
	"rhs_ammo_127x108mm",
	"rhs_ammo_127x108mm_1SLT_x5",
	"rhs_ammo_127x108mm_x5",
	
	"rhs_ammo_127x99_Ball",
	"rhs_ammo_127x99_Ball_Tracer_Green",
	"rhs_ammo_127x99_Ball_Tracer_Red",
	"rhs_ammo_127x99_Ball_Tracer_Yellow",
	"rhs_ammo_127x99_SLAP",
	"rhs_ammo_127x99_SLAP_Tracer_Green",
	"rhs_ammo_127x99_SLAP_Tracer_Red",
	"rhs_ammo_127x99_SLAP_Tracer_Yellow",
	"rhsusf_ammo_127x99_M33_Ball",
	"rhsusf_ammo_127x99_mk211",
	
	"B_127x54_Ball",
	"B_93x64_Ball",
	"B_338_Ball",
	"B_338_NM_Ball",
	"B_408_Ball",
	"B_127x108_Ball",
	"B_127x99_Ball",
	"B_127x99_Ball_Tracer_Red",
	"B_127x99_Ball_Tracer_Green",
	"B_127x99_Ball_Tracer_Yellow",
	"B_127x108_APDS"
];

//_bloodLoss = 500 + floor (random 1000);
_bloodLoss = 50 + floor (random 50);

if (_bullet in _bulletArrayLow) then
{
	_bloodLoss = 100 + floor (random 50);
};	

if (_bullet in _bulletArrayMed) then
{
	_bloodLoss = 125 + floor (random 50);
};	
	
if (_bullet in _bulletArrayHigh) then
{
	_bloodLoss = 135 + floor (random 50);
};
if (_bullet in _bulletArrayExtreme) then
{
	_bloodLoss = 145 + floor (random 50);
};

_bloodLoss
