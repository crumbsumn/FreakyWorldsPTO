function scr_player_backbreaker()
{
	mach2 = 0
	if sprite_index != spr_player_machfreefall
	{
		hsp = 0
		movespeed = 0
	}
	else
		hsp = xscale * movespeed

	move = key_right2 + key_left2

	landAnim = false
	
	//Tower Intro
	if sprite_index == spr_machfreefall && grounded
	{
		state = states.machslide
		sprite_index = spr_crouchslide
	}
	
	if !visible
		vsp = 0;
	
	//Taunt
	if sprite_index = spr_taunt or sprite_index = spr_supertaunt1 or sprite_index = spr_supertaunt2
	or sprite_index = spr_supertaunt3 or sprite_index = spr_supertaunt4
	{
		if sprite_index == spr_taunt
		{
			image_speed = 0;
			image_index = floor(image_index);
		}
		else
			image_speed = 0.4;
		
		if character != "V" && character != "S" && character != "PP"
		{
			if !instance_exists(parry_inst) && taunttimer > parry_max
		    {
		        parry_inst = instance_create(x, y, obj_parryhitbox);
		        with parry_inst
		        {
		            player_id = 1;
		            image_xscale = other.xscale;
		        }
		    }
		    if taunttimer < taunt_to_parry_max
		    {
		        if instance_exists(parry_inst)
		        {
		            instance_destroy(parry_inst)
		            parry_inst = noone
		        }
		    }
		}
		
		if noisebombcooldown > 0
			noisebombcooldown -= 1;

		// change palette
		if debug
		{
			if key_taunt2 && taunttimer != 20 && !(instance_exists(obj_snicklevelend) && obj_snicklevelend.image_index > 0) && tauntstoredstate == states.normal
			{
				if instance_exists(obj_skinchoice) == false
					instance_create(0, 0, obj_skinchoice);
			}
		}

		// supertaunt kill
		if (supercharged or ((character == "S" or character == "PP") && global.combo >= 3)) && !instance_exists(obj_tauntaftereffectspawner)
		{
			vsp = 0
			with instance_create(x, y, obj_tauntaftereffectspawner)
			{
				if other.character == "S" or other.character == "PP"
					legacy = true;
			}
			
			if character != "S" && character != "PP"
			{
				supercharged = false;
				supercharge = 0;
			}
			
			scr_baddie_screenclear();
			
			with obj_camera
			{
			    shake_mag = 10;
			    shake_mag_acc = 30 / room_speed;
			}
		}
		
		taunttimer -= 1
		if global.gameplay == 0
			vsp = 0
	}
	else
		image_speed = 0.4;

	if floor(image_index) >= image_number - 1 && (sprite_index == spr_supertaunt1 or sprite_index == spr_supertaunt2
	or sprite_index == spr_supertaunt3 or sprite_index == spr_supertaunt4) && character != "S" && character != "PP"
	{
		if global.gameplay == 0
		&& global.combotime != 0 && global.combo > 0
		{
			global.combo = 0
			global.combotime = 0
		}
	
		movespeed = tauntstoredmovespeed 
		sprite_index = tauntstoredsprite 
		state = tauntstoredstate
		
		if instance_exists(parry_inst)
		{
			instance_destroy(parry_inst);
			parry_inst = noone;
		}
	}
	
	if sprite_index == spr_taunt && taunttimer <= 0
	{
		movespeed = tauntstoredmovespeed
		sprite_index = tauntstoredsprite 
		state = tauntstoredstate
		
		if instance_exists(parry_inst)
		{
			instance_destroy(parry_inst);
			parry_inst = noone;
		}
	}
	
	// noise dab
	if sprite_index == spr_playerN_dab
	{
		if global.cont <= -1 or gamepad_button_value(global.cont, gp_shoulderlb) == 0
			state = states.normal;
		else
			image_index = gamepad_button_value(global.cont, gp_shoulderlb) * 20;
	}
	
	//Eat spag
	if floor(image_index) >= image_number - 1 && sprite_index == spr_player_eatspaghetti
		state = states.normal
	
	//Throw bomb
	if floor(image_index) >= image_number - 1 && sprite_index == spr_player_throw
		state = states.normal
	
	//Level intro
	if floor(image_index) = image_number - 1 && sprite_index == spr_Timesup && place_meeting(x, y, obj_exitgate)
		state = states.normal

	//Ball goal
	if floor(image_index) = image_number - 1 && (sprite_index == spr_player_levelcomplete or sprite_index == spr_victory)
		state = states.normal
	
	//Phone
	if key_jump && sprite_index == spr_player_phoneidle
	{
		global.panic = true
		sprite_index = spr_bossintro
		image_index = 0
		with instance_create(x, y, obj_debris)
		{
			image_index = 0
			sprite_index = spr_phonedebris
		}
	}

	//Scream at boss
	if sprite_index == spr_bossintro && floor(image_index) >= image_number - 1
		state = states.normal
}
