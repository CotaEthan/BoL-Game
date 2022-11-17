//Get inputs
//keyboard_check returns 1 or 0, essentially int version of bool values
rightKey = keyboard_check(ord("D")); 
leftKey = keyboard_check(ord("A")); 
upKey = keyboard_check(ord("W")); 
downKey = keyboard_check(ord("S")); 
weaponActivate = mouse_check_button(mb_left);
//Look at rebinding to 1-5 keys on keyboard in future
swapKey = mouse_check_button_pressed(mb_right);

//___________________________________Player Movement__________________________________
#region
//Get the direction - var keyword creates a local variable
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
	var localSpread = weaponInUse.spread;
	
	//Calculate degrees to spread bullets from starting point over every frame of movement
	//Calculations explanations: 90 deg. signifies straight line, 
	// -> Bullets shot away from 90 deg. center will require degrees from middle to outer bound
	// --> total spread Ex: 45 deg. will be split at the median 90 deg. to be the split 22.5 deg.
	// ---> Left of north median = add split deg. from median 90 deg.
	// ----> Right of north median = subtract split deg. to the median 90 deg.
	//var spreadCalc = localSpread / weaponInUse.bulletAmount; <- off center when shooting odd # of pellets
	//Max -> returns larger value, avoid div. by 0 err
	// --> -1 implemented to no longer calc by bullet amount, but space between each bullet
	// ---> Produce more accurate total deg. for total deg. of spread
	// ---->"Spread angle div. # of spaces"
	var spreadCalc = localSpread/max(1, weaponInUse.bulletAmount-1);
	
	//Loop to create bullets up to specified amount
	for(var i = 0; i<weaponInUse.bulletAmount; ++i)
	{
		//Spawn a bullet via new instance key
		var bulletInstance = instance_create_depth(x+xOffset, centerY+yOffset, depth-100, weaponInUse.bullet);
	
		//Bullet Direction determination
		//With keyword - address variables found within another object (object bullet instance)
		with(bulletInstance)
		{
			//dir value of the bullet Object - default 0
			//other keyword is usable when working with an object within another object
			// -> in this case the bullet object within the player object
			// --> Without the other, it will look for aimDir variable within the bullet object, bad
			// ----> required because of the "with" keyword/object statement 
			//Original line: dir = other.aimDir; <- before spread implementation
			
			//New line to calc spread
			// -> Start at aimDir-localSpread/2 -> Progress angle to next bullet by +spreadcalc*iteration
			dir = other.aimDir - localSpread/2 + spreadCalc*i;
			
			//Correct bullet orientation
			//Added nonCircle variable to bullet objects to determine when to apply fix
			if(nonCircle)
			{
				//Fixes angle by immediately applying the image angle to direction bullet
				image_angle = dir;
			}
		}
	}
}
#endregion

