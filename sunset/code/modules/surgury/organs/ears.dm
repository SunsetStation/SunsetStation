/obj/item/organ/ears/vox
	icon = 'sunset/icons/obj/surgery.dmi'
	name = "vox ears"
	icon_state = "ears-vox"
	desc = "The internal parts of the vox ear. Corporate scientists hypothesize that the synthetic components take the piercing edge off their own shrieking."
	status = ORGAN_ROBOTIC

/obj/item/organ/ears/vox/emp_act()
	deaf = 10

/obj/item/organ/ears/robot
	name = "auditory sensors"
	icon_state = "robotic_ears"
	desc = "A pair of microphones intended to be installed in an IPC head, that grant the ability to hear."
	zone = "head"
	slot = "ears"
	gender = PLURAL
	status = ORGAN_ROBOTIC

/obj/item/organ/ears/robot/emp_act(severity)
	switch(severity)
		if(1)
			owner.Jitter(30)
			owner.Dizzy(30)
			owner.Knockdown(200)
			deaf = 30
			to_chat(owner, "<span class='warning'>Your robotic ears are ringing, uselessly.</span>")
		if(2)
			owner.Jitter(15)
			owner.Dizzy(15)
			owner.Knockdown(100)
			to_chat(owner, "<span class='warning'>Your robotic ears buzz.</span>")
