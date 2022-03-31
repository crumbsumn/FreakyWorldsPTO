// SAGE2019
if room == rm_editor
	exit;

if ds_list_find_index(global.baddieroom, id) == -1
{
	scr_failmod(mods.pacifist);
	scr_soundeffect(sfx_killenemy);
	
	with obj_camera
	{
		shake_mag = 3;
		shake_mag_acc = 3 / room_speed;
	}
	
	if variable_instance_exists(id, "custom_death_fnc") && is_method(custom_death_fnc)
		custom_death_fnc();
	else
	{
		if global.gameplay == 0
		{
			scr_sleep(50);
			repeat 3
				instance_create(x, y, obj_slapstar);
			repeat 3
				create_particle(x, y, particles.baddiegibs);
		}
		
		with instance_create(x, y, obj_sausageman_dead)
		{
			sprite_index = other.spr_dead;
			if global.gameplay != 0 && other.hsp != 0
				hsp = clamp(other.hsp, -12, 12);
			
			if variable_instance_exists(other, "haspalette") && other.haspalette
			{
				haspalette = other.haspalette;
				spr_palette = other.spr_palette;
				paletteselect = other.paletteselect;
			}
			if variable_instance_exists(other, "sugaryenemy")
				sugary = other.sugaryenemy;
		}
		
		if !important
		{
			if global.gameplay != 0
			{
				instance_create(x, y, obj_genericpoofeffect);
			    instance_create(x, y, obj_parryeffect);
			}
			instance_create(x, y, obj_bangeffect);
		}
	}
	
	if !important
	{
		if random_range(1, 100) >= 95 && global.gameplay == 0 // 5% chance
		{
			scr_soundeffect(sfx_scream1, sfx_scream2, sfx_scream3,
			sfx_scream4, sfx_scream5, sfx_scream6, sfx_scream7, sfx_scream8,
			sfx_scream9, sfx_scream10);
		}
		
		if object_index == obj_swedishmonkey && irandom_range(1, 100) == 5 // 1% chance
			scr_soundeffect(sfx_monkey);
		
		ds_list_add(global.baddieroom, id);

		// Combos
		if killreward
		{
			if global.gameplay == 0
			{
				global.combo += 1;
				global.combotime = 60;
			}
		
			if !global.snickchallenge
			{
				var num = 10;
				if scr_stylecheck(0, 2)
				{
					if global.combo <= 1
						num = 10;
					else num = min(power(2, global.combo - 1) * 10, 80);
				}
				else
					num = 10 * (global.stylethreshold + 1);
		
				global.collect += num;
				with instance_create(x, y, obj_smallnumber)
					number = string(num);
			}
		}
	}
}
