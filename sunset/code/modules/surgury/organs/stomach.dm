/obj/item/organ/stomach/vox
	icon = 'sunset/icons/obj/surgery.dmi'
	name = "vox stomach"
	icon_state = "stomach-vox"
	desc = "A vox stomach. If the mere concept wasn't disgusting enough, it appears to have metal components grown into it."
	status = ORGAN_ROBOTIC

/obj/item/organ/stomach/vox/emp_act()
	owner.adjust_disgust(10)

/obj/item/organ/stomach/cell
	name = "micro-cell"
	icon_state = "microcell"
	w_class = WEIGHT_CLASS_NORMAL
	zone = "chest"
	slot = "stomach"
	attack_verb = list("assault and battery'd")
	desc = "A micro-cell, for IPC use only. Do not swallow."
	status = ORGAN_ROBOTIC

/obj/item/organ/stomach/cell/emp_act(severity)
	switch(severity)
		if(1)
			owner.nutrition = 50
			to_chat(owner, "<span class='warning'>Alert: Heavy EMP Detected. Rebooting power cell to prevent damage.</span>")
		if(2)
			owner.nutrition = 250
			to_chat(owner, "<span class='warning'>Alert: EMP Detected. Cycling battery.</span>")
