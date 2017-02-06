cutText ["","BLACK FADED",10];

sleep 5;

cutText ["","BLACK IN",10];

_text = 
"<t size='1'>" + "Presented by" + "<br />" + 
"<t size='1.5'>" + "JohnO" + "</t>"; 

_1 = [_text,0.01,0.01,10,-1,0,90]spawn bis_fnc_dynamicText;

sleep 10;