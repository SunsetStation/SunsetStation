/datum/round_event/spawn_swarmer/start()
	if(find_swarmer())
		return 0
	if(!GLOB.swarmerstart.len)
		return 0
	new /obj/effect/mob_spawn/swarmer(get_turf(pick(GLOB.swarmerstart)))
	if(prob(25)) //25% chance to announce it to the crew
		var/swarmer_report = "<span class='big bold'>[command_name()] Priority Update</span>"
		swarmer_report += "<br><br>Our long-range sensors have detected an odd signal emanating from a clump of space debris that recently crashed on to your station, we recommend you investigate the source."
		print_command_report(swarmer_report, announce=TRUE)
