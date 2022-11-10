//Get inputs
//keyboard_check returns 1 or 0, essentially int version of bool values
rightKey = keyboard_check(ord("D")); 
leftKey = keyboard_check(ord("A")); 
upKey = keyboard_check(ord("W")); 
downKey = keyboard_check(ord("S")); 
weaponActivate = mouse_check_button(mb_left);
//Look at rebinding to 1-5 keys on keyboard in future
swapKey = mouse_check_button_pressed(mb_middle);

//___________________________________Player Movement__________________________________
#region
//step 1: get the direction - var keyword creates a local variable
var horizKey = rightKey - leftKey;  //x directions
var vertKey = downKey - upKey;		//y directions

//moveDir value equal to function that compares two points in relation to each other.
//Requries both points xy val
//Uses 0, 0 as a "center" 
moveDir = point_direction(0,0,horizKey,vertKey); 

//Get x and y speeeeeds
//spd var has default of 0, no move
var spd = 0;
//right now, with kb+m this will essentially be a max of 0 to 1.
//But finding center point distance is good for something like a joystick...?
var inputLevel = point_distance(0,0,horizKey,vertKey);
//clamp var at 0 or 1, prevent added 1s when moving diagnal 
inputLevel = clamp(inputLevel, 0, 1);

//Final speed for player movement
spd = moveSpd * inputLevel;
//Takes a length (our speed) and the direction, 
//returns the x or y coords in relation to central point
xSpeed = lengthdir_x(spd, moveDir);
ySpeed = lengthdir_y(spd, moveDir);
#endregion
//______________________________Collision System___________________________________
#region
//x - where player is, xSpeed - where player WILL be
if(place_meeting(x+xSpeed, y, oPitWall))
{
	xSpeed = 0;
}
if(place_meeting(x, y+ySpeed, oPitWall))
{
	ySpeed = 0;
}

//Now to move the player if not meeting wall
x += xSpeed;
y += ySpeed;

//depth coordination for layers like walls, in this case controlling our sprite
depth = -bbox_bottom;
#endregion
//____________________________Player Aiming______________________________________
#region
centerY = y + centerYOffset;
//Aiming
aimDir = point_direction(x, centerY, mouse_x, mouse_y);
#endregion
//___________________________Sprite Controller________________________________
#region
//Calculate face using degrees of a circle, keeping to whole integers (using the round function)
//face = round(moveDir/90); --> original that would default to a sprite facing right
face = round(aimDir/90);
//moveDir can go up to 360 degrees of a circle, so need to manage instance of when a 4 is calculated
if(face == 4) {face = 0;}

//Set Sprite and collision box to use (latter is permanent)
mask_index = sprite[3];
sprite_index = sprite[face];

//animation setting for not moving 
if(xSpeed == 0 && ySpeed == 0)
{
	image_index = 0;
}


#endregion
//__________________________Weapon Swapping_________________________________
#region
//Good practice, if you will be referencing a global variable multiple times within an event
// -> Save this to a local variable, to prevent more calls than needed and limit scope
var playerWeapons = global.playerWep;

//Cycling through
if(swapKey)
{
	wepSelector++;
	
	if(array_length(global.playerWep) <= wepSelector)
	{
		wepSelector = 0;
	}
	
	weaponInUse = playerWeapons[wepSelector];
}
#endregion
//________________________Weapon Shooting_______________________________
#region
if(shootTmr > 0) 
{
	shootTmr--;
}
if(weaponActivate && shootTmr <=0)
{
	//Reset timer first
	shootTmr = weaponInUse.shtCooldwn;
	//Add bullet offset to be spawned at. Make bullet apear near end of weapon
	//Personal addition of the "weaponInUse.yMove" variable to more direct tweaks
	// -> Inclusion of this variable may warrent removal/change of "weaponInUse.wLength+wepOffsetDist"
	var xOffset = lengthdir_x(weaponInUse.wLength+wepOffsetDist, aimDir);
	var yOffset = lengthdir_y(weaponInUse.wLength+wepOffsetDist, aimDir) + weaponInUse.yMove; 
	//Spawn a bullet via new instance key
	var bulletInstance = instance_create_depth(x+xOffset, centerY+yOffset, depth-100, weaponInUse.bullet);
	
	//Bullet Direction determination
	with(bulletInstance)
	{
		//dir value of the bullet Object - default 0
		//other keyword is usable when working with an object within another object
		// -> in this case the bullet object within the player object
		// --> Without the other, it will look for aimDir variable within the bullet object, bad
		dir = other.aimDir;
	}
}
#endregion

