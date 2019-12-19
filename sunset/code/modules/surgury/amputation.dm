/datum/surgery/amputation
	
	bodypart_types = BODYPART_ORGANIC
	
/datum/surgery/amputation/robotic
	name = "robotic amputation"
	steps = list(/datum/surgery_step/unscrew, /datum/surgery_step/pry_off, /datum/surgery_step/robotic_amputation)
	bodypart_types = BODYPART_ROBOTIC
