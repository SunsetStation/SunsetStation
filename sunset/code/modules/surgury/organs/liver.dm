/obj/item/organ/liver/vox
	icon = 'sunset/icons/obj/surgery.dmi'
	name = "vox liver"
	icon_state = "liver-vox"
	desc = "A mechanically-assisted vox liver."
	status = ORGAN_ROBOTIC

/obj/item/organ/liver/cybernetic/upgraded/ipc
	name = "substance processor"
	icon_state = "substance_processor"
	attack_verb = list("processed")
	desc = "A machine component, installed in the chest. This grants the Machine the ability to process chemicals that enter its systems."
	alcohol_tolerance = 0
	toxTolerance = -1
	toxLethality = 0
	status = ORGAN_ROBOTIC

/obj/item/organ/liver/cybernetic/upgraded/ipc/emp_act(severity)
	to_chat(owner, "<span class='warning'>Alert: Your Substance Processor has been damaged. An internal chemical leak is affecting performance.</span>")
	switch(severity)
		if(1)
			owner.toxloss += 15
		if(2)
			owner.toxloss += 5
