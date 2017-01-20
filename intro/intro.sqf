/*
_text = 
"<t size='1'>" + "Presented by" + "<br />" + 
"<t size='1.5'>" + "JohnO" + "</t>"; 
//"<br />" + "<t size='1.5'>" + "EXAMPLE #3" + 
//"</t>" + "<br />" + "<img size='4' image='images\OPTIONAL #1.paa'/>" + 
//"<br />" + "<t size='1'>" + "www.website #1.com" + "</t>" + 
//"<br />" + "<t size='0.5'>" + "www.website #2.com" + "</t>";
_1 =[_text,0.01,0.01,10,-1,0,90]spawn bis_fnc_dynamicText;

sleep 5;
*/
private ["_dots"];

_dots = ".";
for "_i" from 0 to 5 do
{
	titleText[format["Loading character%1",_dots],"PLAIN"];
	_dots = _dots + ".";
	sleep 2;
};

titleText ["","PLAIN"];

cutText ["","BLACK IN",10];

