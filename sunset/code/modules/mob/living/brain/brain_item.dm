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

/obj/item/organ/brain/Insert(mob/living/carbon/C, special = 0, no_id_transfer = FALSE)
	..()

	name = "brain"

	if(brainmob)
		if(C.key)
			C.ghostize()

		if(brainmob.mind)
			brainmob.mind.transfer_to(C)
		else
			C.key = brainmob.key

		QDEL_NULL(brainmob)

	//Update the body's icon so it doesnt appear debrained anymore
	C.update_hair()

/obj/item/organ/brain/Remove(mob/living/carbon/C, special = 0, no_id_transfer = FALSE)
	..()
	if((!gc_destroyed || (owner && !owner.gc_destroyed)) && !no_id_transfer)
		transfer_identity(C)
	C.update_hair()

// IPC brain fuckery.
/obj/item/organ/brain/mmi_holder
	name = "brain"
	slot = "brain"
	zone = "chest"
	status = ORGAN_ROBOTIC
	remove_on_qdel = FALSE
	var/obj/item/mmi/stored_mmi
/obj/item/organ/brain/mmi_holder/Destroy()
	QDEL_NULL(stored_mmi)
	return ..()
/obj/item/organ/brain/mmi_holder/Insert(mob/living/carbon/C, special = 0, no_id_transfer = FALSE)
	owner = C
	C.internal_organs |= src
	C.internal_organs_slot[slot] = src
	loc = null
	//the above bits are copypaste from organ/proc/Insert, because I couldn't go through the parent here.

	if(stored_mmi.brainmob)
		if(C.key)
			C.ghostize()
		var/mob/living/brain/B = stored_mmi.brainmob
		if(stored_mmi.brainmob.mind)
			B.mind.transfer_to(C)
		else
			C.key = B.key

	if(ishuman(C))
		var/mob/living/carbon/human/H = C
		if(H.dna && H.dna.species && (REVIVESBYHEALING in H.dna.species.species_traits))
			if(H.health > 0 && !H.hellbound)
				H.revive(0)

	update_from_mmi()

/obj/item/organ/brain/mmi_holder/Remove(var/mob/living/user, special = 0)
	if(!special)
		if(stored_mmi)
			. = stored_mmi
	 	if(owner.mind)
	 		owner.mind.transfer_to(stored_mmi.brainmob)
	 	stored_mmi.loc = owner.loc
	 	if(stored_mmi.brainmob)
	 		var/mob/living/brain/B = stored_mmi.brainmob
	 		spawn(0)
	 			if(B)
	 				B.stat = 0
	 	stored_mmi = null

	..()
	spawn(0)//so it can properly keep surgery going
		qdel(src)

/obj/item/organ/brain/mmi_holder/proc/update_from_mmi()
	if(!stored_mmi)
		return
	name = stored_mmi.name
	desc = stored_mmi.desc
	icon = stored_mmi.icon
	icon_state = stored_mmi.icon_state

/obj/item/organ/brain/mmi_holder/posibrain/Initialize(var/obj/item/mmi/MMI)
	. = ..()
	if(MMI)
		stored_mmi = MMI
		MMI.forceMove(src)
	else
		stored_mmi = new /obj/item/mmi/posibrain/ipc(src)
	spawn(5)
		if(owner && stored_mmi)
			stored_mmi.name = "positronic brain ([owner.real_name])"
			stored_mmi.brainmob.real_name = owner.real_name
			stored_mmi.brainmob.name = stored_mmi.brainmob.real_name
			stored_mmi.icon_state = "posibrain-occupied"
			update_from_mmi()
