/obj/item/organ/lungs/vox
	name = "vox lungs"
	icon_state = "lungs-vox"
	desc = "A pair of very thin, very light lungs that the vox use to process nitrogen. There are small, silver circuits inlaid into the flesh."
	safe_oxygen_min = 0 //We don't breathe this
	safe_oxygen_max = 0.05 //This is toxic to us
	safe_nitro_min = 16 //We breathe THIS!
	oxy_damage_multiplier = 6 // BADLY.
	oxy_damage_type = TOX //And it poisons us

/obj/item/organ/lungs/vox/emp_act()
	owner.emote("gasp")
