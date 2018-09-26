/obj/item/organ/eyes/vox
	name = "vox eyes"
	desc = "Vox perceive the universe through these strange, circuitry-embedded eyes."
	icon_state = "eyes-vox"
	status = ORGAN_ROBOTIC

/obj/item/organ/eyes/vox/emp_act()
	owner.hallucination += 10
