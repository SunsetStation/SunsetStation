/datum/world_topic/status/Run(list/input)
	var/list/mnt = get_mentor_counts()
	.["mentors"] = mnt["total"] // we don't have stealth mentors, so we can just use the total.
		. = ..()
