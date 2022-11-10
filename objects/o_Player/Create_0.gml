//First variables for player movement - Not Local, or FULLY global
//no var,let,or const keyword creates a variable accessable between events
moveDir = 0;
moveSpd = 3;
//left and right
xSpeed = 0;
//Up and down
ySpeed = 0;

//_______________For Sprite Control______________
//Global array - Start right face and counter clockwise allotment
face = 3; //default facing direction number
sprite[0] = sHoodFaceRight;
sprite[1] = sHoodUp;
sprite[2] = sHoodFaceLeft;
sprite[3] = sHoodDown;

//_______________Weapon - Swap - Shoot___________
#region
//Variables Moved to struct
////////////////bullet = oBloodBullet;
//Size offset for bullets to originate from
//weaponLength = sprite_get_bbox_right(sDefaultWeapon) - sprite_get_xoffset(sDefaultWeapon);
//weaponLength = 10; //simpler manual control for tweaks

//Shoot Timer
//Times in frames, 1:1
shootTmr = 0;

//_________________Weapon aiming_________________
#region
//create ofset for weapon in comparison to origin of sprite
centerYOffset = -3;
centerY = y + centerYOffset; //To be set within the Step Event

wepOffsetDist = 3;
aimDir = 0;
#endregion

//_______________Weapon Structs__________________
#region
//Moved to weapon_structs script
/*
	defaultWeapon = new weapon_Spawn(sDefaultWeapon, oBloodBullet, 10, 25, -3);
	sqGun = new weapon_Spawn(sWepSpray, oBloodBullet, 16, 15, -1);
	manGun = new weapon_Spawn(sManGun, oBloodBullet, 15, 10, 0 );
	bigGun = new weapon_Spawn(sBigOlGun, oBrightBullet, 17, 4, 4);

	weaponInUse = bigGun;
	Call still requires the "global." notation
	weaponInUse = global.weaponList.WEAPON NAME HERE;
*/

//Pushing weapon to weapon inventory array
array_push(global.playerWep, global.weaponList.defaultWeapon);
array_push(global.playerWep, global.weaponList.sqGun);
array_push(global.playerWep, global.weaponList.manGun);
array_push(global.playerWep, global.weaponList.bigGun);

weaponInUse = global.weaponList.defaultWeapon;
wepSelector = 0;


#endregion

#endregion


