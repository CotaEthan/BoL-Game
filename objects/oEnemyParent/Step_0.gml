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

/*******************OLD SYSTEM****************************************************
if(place_meeting(x, y, oDamageNPC))
{
	//"instance_place" returns bool w/ object's instance ID - Like "instance_create_depth"
	//Require this in order to determine WHICH bullet has collided
	//This can only check 1 bullet at a time, causing bullets to phase through enemy
	// Each frame will be checking for 1, and only 1 bullet instance to impact the enemy
	var instance = instance_place(x, y, oDamageNPC);
	
	//Damage is being pulled from parent object (oDamageNPC) of specific bullet instance
	hp -= instance.damage;
	
	//Destroy bool found in parent bullet object (oBloodBullet)
	instance.destroy = true;
}
******************************************UPDATED SYSTEM BELOW*********************/
if(place_meeting(x, y, oDamage))
{		
	//DS = Data Structure -> Stored within its own memory blocks 
	// -> Very hungry if not used correctly
	// ---> DS destroy methods should be used to prevent leaks and for garbage cleanup
	var listance = ds_list_create();
	
	//Place any instances IDs of any oDamageNPC into the list
	instance_place_list(x, y, oDamageNPC, listance, false ); //Ordered -> Bool -> Order objects by dist
	
	//No noticeable difference in performance when swapping out line:67 with line:70
	//listSize = ds_list_size(listance);
	
	//Will compute damage for all instances per/frame
	for(var i = 0; i<ds_list_size(listance); i++)
	{
		//Get instance of NPC damage and assign to variable
		//OLD -> var instance = instance_place(x, y, oDamageNPC);
		//Get instance from the DS list
		var instance = ds_list_find_value(listance, i);
		
		//Subtract damage from HP
		hp -= instance.damage;
		 
		//Remove damage instance
		instance.destroy = true;
	}
	//Clear up memory!
	ds_list_destroy(listance);
}



//Events on death
if(hp <= 0) 
{
	instance_destroy();
}
#endregion