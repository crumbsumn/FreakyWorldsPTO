if obj_player1.character == "N"
	sprite_index = spr_halloweensmallblock
else if obj_player1.character == "SP"
	sprite_index = spr_destroyable2_ss
else if obj_player1.character == "PP"
	sprite_index = spr_destroyable2_PP
else if !scr_stylecheck(0, 2)
	sprite_index = spr_destroyable2_NEW

if string_startswith(room_get_name(room), "strongcold")
	sprite_index = spr_xmasblock

depth = 1;
image_speed = 0.35;
image_index = random(image_number);
hsp2 = 0;
