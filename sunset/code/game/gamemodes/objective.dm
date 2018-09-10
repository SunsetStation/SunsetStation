GLOBAL_LIST_EMPTY(objectives)

/datum/objective/steal/check_completion()
	. = ..()
	var/list/ok_areas = list(/area/sunset/infiltrator_base, /area/syndicate_mothership, /area/shuttle/sunset/stealthcruiser)
	var/list/compiled_areas = list()
	for(var/A in ok_areas)
		compiled_areas += typesof(A)
	for(var/A in compiled_areas)
		for(var/obj/item/I in get_area_by_type(A)) //Check for items
			if(istype(I, steal_target))
				if(!targetinfo) //If there's no targetinfo, then that means it was a custom objective. At this point, we know you have the item, so return 1.
					return TRUE
				else if(targetinfo.check_special_completion(I))//Returns 1 by default. Items with special checks will return 1 if the conditions are fulfilled.
					return TRUE
			if(targetinfo && (I.type in targetinfo.altitems)) //Ok, so you don't have the item. Do you have an alternative, at least?
				if(targetinfo.check_special_completion(I))//Yeah, we do! Don't return 0 if we don't though - then you could fail if you had 1 item that didn't pass and got checked first!
					return TRUE
			CHECK_TICK
	CHECK_TICK

/datum/objective/give_special_equipment(special_equipment)
	if(istype(team, /datum/team/infiltrator))
		for(var/eq_path in special_equipment)
			if(eq_path)
				for(var/turf/T in GLOB.infiltrator_objective_items)
					if(!(eq_path in T.contents))
						new eq_path(T)
	else
		..()

/datum/objective/New(var/text)
	GLOB.objectives += src
	if(text)
		explanation_text = text

/datum/objective/proc/find_target()
	var/list/datum/mind/owners = get_owners()
	var/list/possible_targets = list()
	var/try_target_late_joiners = FALSE
	for(var/I in owners)
		var/datum/mind/O = I
		if(O.late_joiner)
			try_target_late_joiners = TRUE
	for(var/datum/mind/possible_target in get_crewmember_minds())
		if(!(possible_target in owners) && ishuman(possible_target.current) && (possible_target.current.stat != DEAD) && is_unique_objective(possible_target))
			possible_targets += possible_target
	if(try_target_late_joiners)
		var/list/all_possible_targets = possible_targets.Copy()
		for(var/I in all_possible_targets)
			var/datum/mind/PT = I
			if(!PT.late_joiner)
				possible_targets -= PT
		if(!possible_targets.len)
			possible_targets = all_possible_targets
	if(possible_targets.len > 0)
		target = pick(possible_targets)
	else
		target = null//we'd rather have no target than an invalid one
	update_explanation_text()
	return target