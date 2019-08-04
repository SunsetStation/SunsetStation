/datum/team/cult/proc/make_image(datum/objective/sacrifice/sac_objective)
	var/datum/job/sacjob = SSjob.GetJob(sac_objective.target.assigned_role)
	var/datum/preferences/sacface = sac_objective.target.current.client.prefs
	var/icon/reshape = get_flat_human_icon(null, sacjob, sacface, list(SOUTH))
	reshape.Shift(SOUTH, 4)
	reshape.Shift(EAST, 1)
	reshape.Crop(7,4,26,31)
	reshape.Crop(-5,-3,26,30)
	sac_objective.sac_image = reshape

/datum/objective/sacrifice/find_target()
	if(!istype(team, /datum/team/cult))
		return
	var/datum/team/cult/C = team
	var/list/target_candidates = list()
	for(var/mob/living/carbon/human/player in GLOB.player_list)
		if(player.mind && !player.mind.has_antag_datum(/datum/antagonist/cult) && !is_convertable_to_cult(player) && player.stat != DEAD)
			target_candidates += player.mind
	if(target_candidates.len == 0)
		message_admins("Cult Sacrifice: Could not find unconvertible target, checking for convertible target.")
		for(var/mob/living/carbon/human/player in GLOB.player_list)
			if(player.mind && !player.mind.has_antag_datum(/datum/antagonist/cult) && player.stat != DEAD)
				target_candidates += player.mind
	listclearnulls(target_candidates)
	if(LAZYLEN(target_candidates))
		target = pick(target_candidates)
		update_explanation_text()
	else
		message_admins("Cult Sacrifice: Could not find unconvertible or convertible target. WELP!")
	C.make_image(src)
	for(var/datum/mind/M in C.members)
		if(M.current)
			M.current.clear_alert("bloodsense")
			M.current.throw_alert("bloodsense", /obj/screen/alert/bloodsense)

/datum/team/cult/setup_objectives()
	var/datum/objective/sacrifice/sac_objective = new
	sac_objective.team = src
	sac_objective.find_target()
	objectives += sac_objective

	var/datum/objective/eldergod/summon_objective = new
	summon_objective.team = src
	objectives += summon_objective