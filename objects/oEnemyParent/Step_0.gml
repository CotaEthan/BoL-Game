//____________________Chase Player_____________________

//Should only be ran if player is in room AND has instance/not destroyed
if(instance_exists(o_Player))
{
	enemyDir = point_direction(x, y, o_Player.x, o_Player.y);
}


//Get speed
enemyXspd = lengthdir_x(enemySpd, enemyDir);
enemyYspd = lengthdir_y(enemySpd, enemyDir);


//Get y-axis value for facing direction -> Flip method requires symmetrical hitbox
//Continued within the Draw event
if(enemyXspd < 0) {enemyFacing = -1;}
if(enemyXspd > 0) {enemyFacing = 1;}


//Collision Detection -> set add done in next step to 0 if detected
if(place_meeting(x+enemyXspd, y, oPitWall) || place_meeting(x+enemyXspd, y, oEnemyParent))
{
	enemyXspd = 0;
}
if(place_meeting(x, y+enemyYspd, oPitWall) || place_meeting(x, y+enemyYspd, oEnemyParent))
{
	enemyYspd = 0;
}


//Actively set speed to x and y
x += enemyXspd;
y += enemyYspd;
//____________________Damage check_____________________
#region
//Check if x and y coord of oEnemy meets with an object inheriting from oDamageNPC
//place_meeting returns bool
if(place_meeting(x, y, oDamageNPC))
{
	//"instance_place" returns bool w/ object's instance ID - Like "instance_create_depth"
	//Require this in order to determine WHICH bullet has collided
	var instance = instance_place(x, y, oDamageNPC);
	
	//Damage is being pulled from parent object (oDamageNPC) of specific bullet instance
	hp -= instance.damage;
	
	//Destroy bool found in parent bullet object (oBloodBullet)
	instance.destroy = true;
}

//Events on death
if(hp <= 0) 
{
	instance_destroy();
}
#endregion