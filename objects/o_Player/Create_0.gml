//First global variables for player movement
//no var,let,or const keyword creates a GLOBAL variable
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
//Variables Moved to struct
////////////////bullet = oBloodBullet;
//Size offset for bullets to originate from
//weaponLength = sprite_get_bbox_right(sDefaultWeapon) - sprite_get_xoffset(sDefaultWeapon);
//weaponLength = 10; //simpler manual control for tweaks

//Shoot Timer
//Times in frames, 1:1
shootTmr = 0;

//_______________Weapons and aiming______________
#region
//create ofset for weapon in comparison to origin of sprite
centerYOffset = -3;
centerY = y + centerYOffset; //To be set within the Step Event

wepOffsetDist = 3;
aimDir = 0;
#endregion

//_______________Weapon Structs__________________


babyHead = new weapon_Spawn(sDefaultWeapon, oBloodBullet, 10, 8);


//Maybe rename from weaponDefault -> WeaponInUse or something along those lines in future
weaponDefault = babyHead;





