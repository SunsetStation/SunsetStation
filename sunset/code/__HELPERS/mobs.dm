random_features()
	if(!GLOB.tails_list_human.len)
		init_sprite_accessory_subtypes(/datum/sprite_accessory/tails/human, GLOB.tails_list_human)
	if(!GLOB.tails_list_lizard.len)
		init_sprite_accessory_subtypes(/datum/sprite_accessory/tails/lizard, GLOB.tails_list_lizard)
	if(!GLOB.snouts_list.len)
		init_sprite_accessory_subtypes(/datum/sprite_accessory/snouts, GLOB.snouts_list)
	if(!GLOB.horns_list.len)
		init_sprite_accessory_subtypes(/datum/sprite_accessory/horns, GLOB.horns_list)
	if(!GLOB.ears_list.len)
		init_sprite_accessory_subtypes(/datum/sprite_accessory/ears, GLOB.horns_list)
	if(!GLOB.frills_list.len)
		init_sprite_accessory_subtypes(/datum/sprite_accessory/frills, GLOB.frills_list)
	if(!GLOB.spines_list.len)
		init_sprite_accessory_subtypes(/datum/sprite_accessory/spines, GLOB.spines_list)
	if(!GLOB.legs_list.len)
		init_sprite_accessory_subtypes(/datum/sprite_accessory/legs, GLOB.legs_list)
	if(!GLOB.body_markings_list.len)
		init_sprite_accessory_subtypes(/datum/sprite_accessory/body_markings, GLOB.body_markings_list)
	if(!GLOB.wings_list.len)
		init_sprite_accessory_subtypes(/datum/sprite_accessory/wings, GLOB.wings_list)
	if(!GLOB.moth_wings_list.len)
		init_sprite_accessory_subtypes(/datum/sprite_accessory/moth_wings, GLOB.moth_wings_list)
	if(!GLOB.vox_bodies_list.len)
		init_sprite_accessory_subtypes(/datum/sprite_accessory/vox_bodies, GLOB.vox_bodies_list)
	if(!GLOB.vox_quills_list.len)
		init_sprite_accessory_subtypes(/datum/sprite_accessory/vox_quills, GLOB.vox_quills_list)
	if(!GLOB.vox_facial_quills_list.len)
		init_sprite_accessory_subtypes(/datum/sprite_accessory/vox_facial_quills, GLOB.vox_facial_quills_list)
	if(!GLOB.vox_eyes_list.len)
		init_sprite_accessory_subtypes(/datum/sprite_accessory/vox_eyes, GLOB.vox_eyes_list)
	if(!GLOB.vox_tails_list.len)
		init_sprite_accessory_subtypes(/datum/sprite_accessory/vox_tails, GLOB.vox_tails_list)
	if(!GLOB.vox_body_markings_list.len)
		init_sprite_accessory_subtypes(/datum/sprite_accessory/vox_body_markings, GLOB.vox_body_markings_list)
	if(!GLOB.vox_tail_markings_list.len)
		init_sprite_accessory_subtypes(/datum/sprite_accessory/vox_tail_markings, GLOB.vox_tail_markings_list)
		//ipcs
	if(!GLOB.ipc_screens_list.len)
		init_sprite_accessory_subtypes(/datum/sprite_accessory/ipc_screens, GLOB.ipc_screens_list)
	if(!GLOB.ipc_antennas_list.len)
		init_sprite_accessory_subtypes(/datum/sprite_accessory/ipc_antennas, GLOB.ipc_antennas_list)
	if(!GLOB.ipc_chassis_list.len)
		init_sprite_accessory_subtypes(/datum/sprite_accessory/ipc_chassis, GLOB.ipc_chassis_list)
	return(list("mcolor" = pick("FFFFFF","7F7F7F", "7FFF7F", "7F7FFF", "FF7F7F", "7FFFFF", "FF7FFF", "FFFF7F"), "tail_lizard" = pick(GLOB.tails_list_lizard), "tail_human" = "None", "wings" = "None", "snout" = pick(GLOB.snouts_list), "horns" = pick(GLOB.horns_list), "ears" = "None", "frills" = pick(GLOB.frills_list), "spines" = pick(GLOB.spines_list), "body_markings" = pick(GLOB.body_markings_list), "legs" = "Normal Legs", "caps" = pick(GLOB.caps_list), "moth_wings" = pick(GLOB.moth_wings_list), "vox_body" = pick(GLOB.vox_bodies_list),"vox_quills" = pick(GLOB.vox_quills_list),"vox_facial_quills" = pick(GLOB.vox_facial_quills_list),"vox_body_markings" = pick(GLOB.vox_body_markings_list),"vox_tail_markings" = pick(GLOB.vox_tail_markings_list), "ipc_screen" = pick(GLOB.ipc_screens_list), "ipc_antenna" = pick(GLOB.ipc_antennas_list),"ipc_chassis" = pick(GLOB.ipc_chassis_list)))

/proc/slot_to_string(slot)
	switch(slot)
		if(SLOT_BACK)
			return "Backpack"
		if(SLOT_WEAR_MASK)
			return "Mask"
		if(SLOT_HANDS)
			return "Hands"
		if(SLOT_BELT)
			return "Belt"
		if(SLOT_EARS)
			return "Ears"
		if(SLOT_GLASSES)
			return "Glasses"
		if(SLOT_GLOVES)
			return "Gloves"
		if(SLOT_NECK)
			return "Neck"
		if(SLOT_HEAD)
			return "Head"
		if(SLOT_SHOES)
			return "Shoes"
		if(SLOT_WEAR_SUIT)
			return "Suit"
		if(SLOT_W_UNIFORM)
			return "Jumpsuit"
		if(SLOT_IN_BACKPACK)
			return "In backpack"
