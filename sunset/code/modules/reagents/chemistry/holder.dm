/datum/reagents/proc/sunset_process_reagent(mob/living/carbon/C, var/datum/reagent/R)
	if(ishuman(C))
		var/mob/living/carbon/human/H = C
		//Check if this mob's species is set and can process this type of reagent
		var/can_process = FALSE
		//If we somehow avoided getting a species or reagent_tag set, we'll assume we aren't meant to process ANY reagents (CODERS: SET YOUR SPECIES AND TAG!)
		if(H.dna && H.dna.species.reagent_tag)
			if((R.process_flags & SYNTHETIC) && (H.dna.species.reagent_tag & PROCESS_SYNTHETIC))		//SYNTHETIC-oriented reagents require PROCESS_SYNTHETIC
				can_process = TRUE
			if((R.process_flags & ORGANIC) && (H.dna.species.reagent_tag & PROCESS_ORGANIC))		//ORGANIC-oriented reagents require PROCESS_ORGANIC
				can_process = TRUE

	//If handle_reagents returns 0, it's doing the reagent removal on its own
		var/species_handled = !(H.dna.species.handle_chemicals(H, R))
		can_process = can_process && !species_handled
	//If the mob can't process it, remove the reagent at it's normal rate without doing any addictions, overdoses, or on_mob_life() for the reagent
		if(!can_process)
			if(!species_handled)
				R.holder.remove_reagent(R.id, R.metabolization_rate)
//We'll assume that non-human mobs lack the ability to process synthetic-oriented reagents (adjust this if we need to change that assumption)
	else
		if(R.process_flags == SYNTHETIC)
			R.holder.remove_reagent(R.id, R.metabolization_rate)
	//If you got this far, that means we can process whatever reagent this iteration is for. Handle things normally from here.
/datum/reagents/proc/reaction_check(mob/living/M, datum/reagent/R)
	var/can_process = FALSE
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		//Check if this mob's species is set and can process this type of reagent
		if(H.dna && H.dna.species.reagent_tag)
			if((R.process_flags & SYNTHETIC) && (H.dna.species.reagent_tag & PROCESS_SYNTHETIC))		//SYNTHETIC-oriented reagents require PROCESS_SYNTHETIC
				can_process = TRUE
			if((R.process_flags & ORGANIC) && (H.dna.species.reagent_tag & PROCESS_ORGANIC))		//ORGANIC-oriented reagents require PROCESS_ORGANIC
				can_process = TRUE
	//We'll assume that non-human mobs lack the ability to process synthetic-oriented reagents (adjust this if we need to change that assumption)
	else
		if(R.process_flags != SYNTHETIC)
			can_process = TRUE
	return can_process
