/datum/surgery/implant_removal
	
	bodypart_types = BODYPART_ORGANIC

/datum/surgery/implant_removal/robotic
	steps = list(/datum/surgery_step/unscrew, /datum/surgery_step/pry_off, /datum/surgery_step/extract_implant, /datum/surgery_step/close_hatch)
	bodypart_types = BODYPART_ROBOTIC
