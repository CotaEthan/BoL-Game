//_______________Weapon Structs__________________
//Structs to organize and call different weapons and their poperties
//Adding and = Value in the header creates a default value, helps avoid missing info errors
function weapon_Spawn(_sprite = sDefaultWeapon, _bullet = sBloodBullet, _wLength = 0, _shtCooldwn = 0, _yMove = 0) constructor
{
	sprite = _sprite;
	bullet = _bullet;
	wLength = _wLength;
	shtCooldwn = _shtCooldwn;
	yMove = _yMove;
}


//_______________Weapon List__________________
//Creating outter fully GLOBAL struct to encapsulate these values
//Cleaner than making ALL values GLOBAL
//use "global." - dot notation, as "globalvar" definition keyword is for other purpose...
global.weaponList =
{
	defaultWeapon : new weapon_Spawn(sDefaultWeapon, oBloodBullet, 10, 25, -3),
	sqGun : new weapon_Spawn(sWepSpray, oBloodBullet, 16, 15, -1),
	manGun : new weapon_Spawn(sManGun, oBloodBullet, 15, 10, 0 ),
	bigGun : new weapon_Spawn(sBigOlGun, oBrightBullet, 17, 4, 4)
}

//_______________Weapon array_______________
//Arrays work like an arraylist or vector - dynamic size change. 
// -> So it is okay to initialize at 0
//Also, global is defined outside of function to avoid needing to call functionName
// --> can avoid due to ability to directly call a global var
global.playerWep = array_create(0);

