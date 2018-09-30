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

///datum/species/proc/handle_vox_bodyparts(mob/living/carbon/human/H, var/list/bodyparts_to_add, var/obj/item/bodypart/head/HD)
//	return bodyparts_to_add

///datum/species/proc/handle_vox_bodyparts_features(mob/living/carbon/human/H, S)
