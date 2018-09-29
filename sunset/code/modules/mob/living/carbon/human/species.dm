/datum/species/proc/handle_vox_bodyparts(mob/living/carbon/human/H)
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
	return bodyparts_to_add

/datum/species/proc/handle_vox_bodyparts_features(mob/living/carbon/human/H, S)
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
