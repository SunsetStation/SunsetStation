/obj/item/projectile/proc/on_hit_sunset(atom/target)
var/mob/living/L = target
	if(blocked != 100) // not completely blocked
		if(damage && L.blood_volume && damage_type == BRUTE)
			var/splatter_dir = dir
			if(starting)
				splatter_dir = get_dir(starting, target_loca)
			if(isalien(L))
				new /obj/effect/temp_visual/dir_setting/bloodsplatter/xenosplatter(target_loca, splatter_dir)
			var/obj/item/bodypart/B = L.get_bodypart(def_zone)
			if(B.status == BODYPART_ROBOTIC) // So if you hit a robotic, it sparks instead of bloodspatters
				do_sparks(2, FALSE, target.loc)
				if(prob(25))
					new /obj/effect/decal/cleanable/oil(target_loca)
				else
					new /obj/effect/temp_visual/dir_setting/bloodsplatter(target_loca, splatter_dir)
				if(prob(33))
					L.add_splatter_floor(target_loca)
			else if(impact_effect_type)
				new impact_effect_type(target_loca, target, src)
