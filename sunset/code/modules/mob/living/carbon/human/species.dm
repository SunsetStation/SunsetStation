/datum/species
	var/reagent_tag = PROCESS_ORGANIC //Used for metabolizing reagents. We're going to assume you're a meatbag unless you say otherwise.
	var/species_gibs = "human"
	var/allow_numbers_in_name // Can this species use numbers in its name?

/datum/species/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	if(ROBOTIC_LIMBS in species_traits)
		for(var/obj/item/bodypart/B in C.bodyparts)
			B.change_bodypart_status(BODYPART_ROBOTIC) // Makes all Bodyparts robotic.
			B.render_like_organic = TRUE
	if(NOMOUTH in species_traits)
		for(var/obj/item/bodypart/head/head in C.bodyparts)
			head.mouth = FALSE
	. = .. ()

/datum/species/on_species_loss(mob/living/carbon/C)
	if(ROBOTIC_LIMBS in species_traits)
		for(var/obj/item/bodypart/B in C.bodyparts)
			B.change_bodypart_status(BODYPART_ORGANIC, FALSE, TRUE)
			B.render_like_organic = FALSE
	if(NOMOUTH in species_traits)
		for(var/obj/item/bodypart/head/head in C.bodyparts)
			head.mouth = TRUE
	. = .. ()

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
