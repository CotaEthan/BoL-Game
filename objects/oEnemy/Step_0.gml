//____________________Damage check_____________________

//Check if x and y coord of oEnemy meets with an object inheriting from oDamageNPC
//place_meeting returns bool
if(place_meeting(x, y, oDamageNPC)
{
	//"instance_place" returns bool w/ object's instance ID - Like "instance_create_depth"
	//Require this in order to determine WHICH bullet has collided
	var instance = instance_place(x, y, oDamageNPC);
	
	hp -= instance.damage;
	
	//part5: 8min 30sec
	instance.destroy = true;
}

