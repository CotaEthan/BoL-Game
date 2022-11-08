// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_Player_Weapon()
{
	//Displace weapon from center of sprite
	var xOffset = lengthdir_x(wepOffsetDist, aimDir);
	var yOffset = lengthdir_y(wepOffsetDist, aimDir);

	//Flip over Y axis
	var wepYscale = 1;
	if(aimDir > 90 && aimDir < 270)
	{
		wepYscale = -1;
	}

	//ext (Extended) has more options than draw_sprite (like rotation, scale and color)
	//draw_sprite_ext(sDefaultWeapon, 0, x + xOffset, centerY + yOffset, 1, wepYscale, aimDir, c_white, 1); 
	draw_sprite_ext(weaponDefault.sprite, 0, x + xOffset, centerY + yOffset, 1, wepYscale, aimDir, c_white, 1); 
}