/obj/item/organ/stomach/vox
	icon = 'sunset/icons/obj/surgery.dmi'
	name = "vox stomach"
	icon_state = "stomach-vox"
	desc = "A vox stomach. If the mere concept wasn't disgusting enough, it appears to have metal components grown into it."
	status = ORGAN_ROBOTIC

/obj/item/organ/stomach/vox/emp_act()
	owner.adjust_disgust(10)
