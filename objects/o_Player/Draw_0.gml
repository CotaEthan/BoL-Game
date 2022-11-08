//More expensive than the "Step" event
//when there is no explicit "Draw" event, there is an implicit "draw_self()" event
//--> must now exist explicitly due to creation of the draw event

//Draw weapon first if aiming up
if(aimDir >= 0 && aimDir < 180)
	draw_Player_Weapon();
	
//Will be after weapon draw when aiming up, to order layers/order of items drawn
draw_self();

//Drawing weapon as normal when side/below player
if(aimDir >= 180 && aimDir < 360)
	draw_Player_Weapon(); 

