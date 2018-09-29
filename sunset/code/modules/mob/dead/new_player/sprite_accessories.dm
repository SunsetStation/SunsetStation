/datum/sprite_accessory
	var/limbs_id //sunset new species limbs

// Vox Accessories
/datum/sprite_accessory/vox_quills
	icon = 'sunset/icons/mob/vox_accessories.dmi'
	color_src = HAIR
/datum/sprite_accessory/vox_quills/none
	name = "None"
	icon_state = "none"
/datum/sprite_accessory/vox_quills/crestedquills
	name = "Crested Quills"
	icon_state = "crestedquills"
/datum/sprite_accessory/vox_quills/emperorquills
	name = "Emperor Quills"
	icon_state = "emperorquills"
/datum/sprite_accessory/vox_quills/keelquills
	name = "Keel Quills"
	icon_state = "keelquills"
/datum/sprite_accessory/vox_quills/keetquills
	name = "Keet Quills"
	icon_state = "keetquills"
/datum/sprite_accessory/vox_quills/shortquills
	name = "Short quills"
	icon_state = "shortquills"
/datum/sprite_accessory/vox_quills/tielquills
	name = "Tiel Quills"
	icon_state = "tielquills"
/datum/sprite_accessory/vox_quills/kingly
	name = "Kingly Quills"
	icon_state = "kingly"
/datum/sprite_accessory/vox_quills/afro
	name = "Afro Quills"
	icon_state = "afro"
/datum/sprite_accessory/vox_quills/yasu
	name = "Yasu Quills"
	icon_state = "yasu"
/datum/sprite_accessory/vox_quills/razor
	name = "Razor Quills"
	icon_state = "razor"
/datum/sprite_accessory/vox_quills/clipped
	name = "Clipped Quills"
	icon_state = "clipped"
/datum/sprite_accessory/vox_quills/mowhawk
	name = "Mohawk Quills"
	icon_state = "mohawk"
/datum/sprite_accessory/vox_quills/horns
	name = "Horns"
	icon_state = "horns"
/datum/sprite_accessory/vox_quills/nights
	name = "Nights"
	icon_state = "nights"
/datum/sprite_accessory/vox_facial_quills
	icon = 'sunset/icons/mob/vox_accessories.dmi'
	color_src = FACEHAIR
/datum/sprite_accessory/vox_facial_quills/none
	name = "None"
	icon_state = "none"
/datum/sprite_accessory/vox_facial_quills/colonel
	name = "Colonel Beard"
	icon_state = "colonel"
/datum/sprite_accessory/vox_facial_quills/fu
	name = "Fu Beard"
	icon_state = "fu"
/datum/sprite_accessory/vox_facial_quills/neck
	name = "Neck Quills"
	icon_state = "neck"
/datum/sprite_accessory/vox_facial_quills/beard
	name = "Beard"
	icon_state = "beard"
/datum/sprite_accessory/vox_bodies
	icon_state = "yaya" // In order to pull the body correctly, we need AN icon_state(see line 36-39). PROBABLY NEED TO REFACTOR THIS. SKREK.
	var/eye_type = "two_eyes"
/datum/sprite_accessory/vox_bodies/green
	name = "Green"
	limbs_id = "grnvox"
/datum/sprite_accessory/vox_bodies/darkgreen
	name = "Dark Green"
	limbs_id = "dgrvox"
/datum/sprite_accessory/vox_bodies/brown
	name = "Brown"
	limbs_id = "brnvox"
/datum/sprite_accessory/vox_bodies/grey
	name = "Grey"
	limbs_id = "gryvox"
/datum/sprite_accessory/vox_bodies/emerald
	name = "Emerald"
	limbs_id = "emdvox"
/datum/sprite_accessory/vox_bodies/azure
	name = "Azure"
	limbs_id = "azevox"
/datum/sprite_accessory/vox_bodies/auroras
	name = "Auroras"
	limbs_id = "aurvox"
	eye_type = "three_eyes"
/datum/sprite_accessory/vox_eyes
	icon = 'sunset/icons/mob/vox_accessories.dmi'
	color_src = EYECOLOR
/datum/sprite_accessory/vox_eyes/two_eyes
	name = "two_eyes"
	icon_state = "two_eyes"
/datum/sprite_accessory/vox_eyes/three_eyes
	name = "three_eyes"
	icon_state = "three_eyes"
/datum/sprite_accessory/vox_tails
	icon = 'sunset/icons/mob/vox_accessories.dmi'
	color_src = 0
/datum/sprite_accessory/vox_tails/grnvox
	name = "grnvox"
	icon_state = "grnvox"
/datum/sprite_accessory/vox_tails/dgrvox
	name = "dgrvox"
	icon_state = "dgrvox"
/datum/sprite_accessory/vox_tails/brnvox
	name = "brnvox"
	icon_state = "brnvox"
/datum/sprite_accessory/vox_tails/gryvox
	name = "gryvox"
	icon_state = "gryvox"
/datum/sprite_accessory/vox_tails/emdvox
	name = "emdvox"
	icon_state = "emdvox"
/datum/sprite_accessory/vox_tails/azevox
	name = "azevox"
	icon_state = "azevox"
/datum/sprite_accessory/vox_tails/aurvox
	name = "aurvox"
	icon_state = "aurvox"
/datum/sprite_accessory/vox_tails/voxhusk
	name = "voxhusk"
	icon_state = "voxhusk"
/datum/sprite_accessory/vox_body_markings
	icon = 'sunset/icons/mob/vox_accessories.dmi'
/datum/sprite_accessory/vox_body_markings/none
	name = "None"
	icon_state = "none"
/datum/sprite_accessory/vox_body_markings/heart
	name = "Heart"
	icon_state = "heart"
/datum/sprite_accessory/vox_body_markings/hive
	name = "Hive"
	icon_state = "hive"
/datum/sprite_accessory/vox_body_markings/nightling
	name = "Nightling"
	icon_state = "nightling"
/datum/sprite_accessory/vox_body_markings/tiger
	name = "Tiger"
	icon_state = "tiger"
/datum/sprite_accessory/vox_tail_markings
	icon = 'sunset/icons/mob/vox_accessories.dmi'
/datum/sprite_accessory/vox_tail_markings/none
	name = "None"
	icon_state = "none"
/datum/sprite_accessory/vox_tail_markings/bands
	name = "Bands"
	icon_state = "bands"
/datum/sprite_accessory/vox_tail_markings/fade
	name = "Fade"
	icon_state = "fade"
/datum/sprite_accessory/vox_tail_markings/stripe
	name = "Stripe"
	icon_state = "stripe"
