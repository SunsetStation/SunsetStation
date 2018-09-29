/datum/game_mode
	var/list/protected_species = list() // Species that can't be traitors

/datum/game_mode/proc/removes_protected_sunset(candidates)
	if(protected_species)
		for(var/mob/dead/new_player/player in candidates)
			if(player.client.prefs.pref_species in protected_species)
				candidates -= player
	return candidates
