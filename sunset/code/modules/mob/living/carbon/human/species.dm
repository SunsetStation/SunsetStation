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

/datum/species/proc/handle_sunset_bodyparts(mob/living/carbon/human/H)
	var/obj/item/bodypart/head/HD = H.get_bodypart(BODY_ZONE_HEAD)
	var/list/bodyparts_to_add = mutant_bodyparts.Copy()
	if("vox_quills" in mutant_bodyparts)
		if(!H.dna.features["vox_quills"] || H.dna.features["vox_quills"] == "None" || H.head && (H.head.flags_inv & HIDEHAIR) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEHAIR)) || !HD || HD.status == BODYPART_ROBOTIC)
			bodyparts_to_add -= "vox_quills"
			//vox sunsetstation
	if("vox_facial_quills" in mutant_bodyparts)
		if(!H.dna.features["vox_facial_quills"] || H.dna.features["vox_facial_quills"] == "None" || H.head && (H.head.flags_inv & HIDEFACE) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEEYES)) || !HD || HD.status == BODYPART_ROBOTIC)
			bodyparts_to_add -= "vox_facial_quills"
			//vox sunsetstation
	if("vox_eyes" in mutant_bodyparts)
		if(!H.dna.features["vox_eyes"] || (H.wear_mask && (H.wear_mask.flags_inv & HIDEEYES)) || !HD || HD.status == BODYPART_ROBOTIC)
			bodyparts_to_add -= "vox_eyes"
			//vox sunsetstation
	if("vox_tail" in mutant_bodyparts)
		if(H.wear_suit && (H.wear_suit.flags_inv & HIDEJUMPSUIT))
			bodyparts_to_add -= "vox_tail"
			//vox sunsetstation
	if("vox_tail_markings" in mutant_bodyparts)
		if(H.wear_suit && (H.wear_suit.flags_inv & HIDEJUMPSUIT))
			bodyparts_to_add -= "vox_tail_markings"
			//IPC parts
	if("ipc_screen" in mutant_bodyparts)
		if(!H.dna.features["ipc_screen"] || H.dna.features["ipc_screen"] == "None" || H.head && (H.head.flags_inv & HIDEFACE) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEEYES)) || !HD)
			bodyparts_to_add -= "ipc_screen"

	if("ipc_antenna" in mutant_bodyparts)
		if(!H.dna.features["ipc_antenna"] || H.dna.features["ipc_antenna"] == "None" || H.head && (H.head.flags_inv & HIDEHAIR) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEHAIR)) || !HD)
			bodyparts_to_add -= "ipc_antenna"

	return bodyparts_to_add

/datum/species/proc/handle_sunset_bodyparts_features(mob/living/carbon/human/H, S)
	if("vox_body") //sunset vox bodyparts
		S = GLOB.vox_bodies_list[H.dna.features["vox_body"]]
	if("vox_quills") //sunset vox bodyparts
		S = GLOB.vox_quills_list[H.dna.features["vox_quills"]]
	if("vox_facial_quills") //sunset vox bodyparts
		S = GLOB.vox_facial_quills_list[H.dna.features["vox_facial_quills"]]
	if("vox_eyes") //sunset vox bodyparts
		S = GLOB.vox_eyes_list[H.dna.features["vox_eyes"]]
	if("vox_tail") //sunset vox bodyparts
		S = GLOB.vox_tails_list[H.dna.features["vox_tail"]]
	if("vox_body_markings") //sunset vox bodyparts
		S = GLOB.vox_body_markings_list[H.dna.features["vox_body_markings"]]
	if("vox_tail_markings") //sunset vox bodyparts
		S = GLOB.vox_tail_markings_list[H.dna.features["vox_tail_markings"]]
		//sunset ipc
	if("ipc_screen")
		S = GLOB.ipc_screens_list[H.dna.features["ipc_screen"]]
	if("ipc_antenna")
		S = GLOB.ipc_antennas_list[H.dna.features["ipc_antenna"]]
	if("ipc_chassis")
		S = GLOB.ipc_chassis_list[H.dna.features["ipc_chassis"]]

		// Do species-specific reagent handling here
		// Return 1 if it should do normal processing too
		// Return 0 if it shouldn't deplete and do its normal effect
		// Other return values will cause weird badness
/datum/species/proc/handle_reagents(mob/living/carbon/human/H, datum/reagent/R)
	if(R.id == exotic_blood)
		H.blood_volume = min(H.blood_volume + round(R.volume, 0.1), BLOOD_VOLUME_NORMAL)
		H.reagents.del_reagent(R.id)
		return FALSE
	return TRUE
