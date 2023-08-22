//Flipping sprite to face player
//*draw_sprite_ext(sprite_index, image_index, x, y, enemyFacing,image_yscale, image_angle, image_blend, image_alpha);*
// --> Line above does essentially same as below, just more straight forward implementation. image_alpha = 1 = opaque
draw_sprite_ext(sBlueMan, image_index, x, y, enemyFacing, 1, 0, c_white, 1);
//Note: draw_self() == draw_sprite_ext(sprite_index, image_index, x, y, imagexscale, image_yscale, image_angle, image_blend, image_alpha);*

//Creating sprite --> commented out as explained above
//draw_self()

//Test -> string() forces value to string
// draw_text(x, y, string(hp));

