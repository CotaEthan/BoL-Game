//Initial move speeds
xSpd = lengthdir_x(spd, dir);
ySpd = lengthdir_y(spd, dir);

x+= xSpd;
y+= ySpd;

//_________________________Bullet Collision System________________________
//Destroy bullet
//MUST come first, so that it will run past check on first pass
// -> Need to skip true flag on first pass to impact an object
// --> Otherwise, will dissapear before enacting on said object
if(destroy == true)
{
	instance_destroy();
}
//Detect hard wall collision
if(place_meeting(x, y, oWall))
{
	//instance_destroy(); - old method
	destroy = true;
}
//VERY important, calculate bullet out of range for culling
if(point_distance(xstart, ystart, x, y) >= maxDist)
{
	destroy = true;
}
