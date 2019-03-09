/obj/item/bodypart/var/should_draw_sunset = FALSE

/mob/living/carbon/proc/draw_sunset_parts(undo = FALSE)
	if(!undo)
		for(var/O in bodyparts)
			var/obj/item/bodypart/B = O
			B.should_draw_sunset = TRUE
	else
		for(var/O in bodyparts)
			var/obj/item/bodypart/B = O
			B.should_draw_sunset = FALSE

/datum/species
	// H for human because Voxies were setup with the non prefixed var names
	var/sound/Hfemale_scream_sound = 'sound/effects/mob_effects/goonstation/female_scream.ogg'
	var/sound/Hmale_scream_sound = 'sound/effects/mob_effects/goonstation/male_scream.ogg'
	var/sound/Hfemale_cough_sound = 'sound/effects/mob_effects/f_cough.ogg'
	var/sound/Hmale_cough_sound = 'sound/effects/mob_effects/m_cough.ogg'
	var/sound/Hfemale_sneeze_sound = 'sound/effects/mob_effects/f_sneeze.ogg'
	var/sound/Hmale_sneeze_sound = 'sound/effects/mob_effects/sneeze.ogg'

/datum/species/proc/get_age_frequency(var/age)
	return (1.0 + 0.5*(30 - age)/80)

///datum/species/proc/handle_vox_bodyparts(mob/living/carbon/human/H, var/list/bodyparts_to_add, var/obj/item/bodypart/head/HD)
//	return bodyparts_to_add

///datum/species/proc/handle_vox_bodyparts_features(mob/living/carbon/human/H, S)
