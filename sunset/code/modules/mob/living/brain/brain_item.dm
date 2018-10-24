/obj/item/organ/brain/cybernetic/vox
	name = "vox brain"
	slot = "brain"
	desc = "A vox brain. A truly alien organ made up of both organic and synthetic parts. I bet you thought there was going to be a bird-brain joke here, didn't you?"
	zone = "head"
	icon_state = "brain-vox"
	status = ORGAN_ROBOTIC
/obj/item/organ/brain/cybernetic/vox/emp_act(severity)
	to_chat(owner, "<span class='warning'>Your head hurts.</span>")
	switch(severity)
		if(1)
			owner.adjustBrainLoss(rand(25, 50))
		if(2)
			owner.adjustBrainLoss(rand(0, 25))
