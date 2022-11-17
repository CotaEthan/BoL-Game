//Had to add this post parent addition (oDamageNPC)
event_inherited()

//Basic global values
dir = 0;
spd = 5;
xSpd = 0;
ySpd = 0;

//Values for culling 
//maxDist is currently set to an arbitrary number
//find a way to match with current viewport centered on character -- one day
nonCircle = false;
maxDist = 250;
destroy = false;

