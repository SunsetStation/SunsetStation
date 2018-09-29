/obj/item/organ/eyes/vox
	icon = 'sunset/icons/obj/surgery.dmi'
	name = "vox eyes"
	desc = "Vox perceive the universe through these strange, circuitry-embedded eyes."
	icon_state = "eyes-vox"
	status = ORGAN_ROBOTIC

/obj/item/organ/eyes/vox/emp_act()
	owner.hallucination += 10

/obj/item/organ/eyes/robotic
	desc = "A very basic set of optical sensors with no extra vision modes or functions."
