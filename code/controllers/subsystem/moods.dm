PROCESSING_SUBSYSTEM_DEF(mood)
	name = "Mood"
	flags = SS_BACKGROUND
	runlevels = RUNLEVEL_GAME
	priority = 20


/datum/controller/subsystem/mood/Initialize(timeofday)
	for(var/A in subtypesof(/datum/brain_trauma/affliction))
		var/datum/brain_trauma/affliction/afflic = A
		if(initial(afflic.tier) == 1) //Only use base-level afflictions, they're progress through naturally otherwise.
			GLOB.possible_afflictions += afflic
	return ..()