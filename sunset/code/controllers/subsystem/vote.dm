/datum/controller/subsystem/vote/proc/sunset_votes(greatest_votes) //stolen from para
	if (mode == "crew_transfer")
		var/factor = 0.5
		switch(world.time / (10 * 60)) // minutes
			if(0 to 60)
				factor = 0.5
			if(61 to 120)
				factor = 0.8
			if(121 to 240)
				factor = 1
			if(241 to 300)
				factor = 1.2
			else
				factor = 1.4
		choices["Initiate Crew Transfer"] = round(choices["Initiate Crew Transfer"] * factor)
		to_chat(world, "<font color='purple'>Crew Transfer Factor: [factor]</font>")
		greatest_votes = max(choices["Initiate Crew Transfer"], choices["Continue The Round"])

/datum/controller/subsystem/vote/proc/sunset_results(result)
	if("crew_transfer")
		if(result == "Initiate Crew Transfer")
			SSshuttle.emergency.request(reason = "Automatic Crew Transfer")
			SSshuttle.emergencyNoRecall = TRUE

/datum/controller/subsystem/vote/proc/sunset_initiate_vote()
	if("crew_transfer")
		if(SSticker.current_state <= GAME_STATE_FINISHED)
			return FALSE
		question = "End the shift?"
		choices.Add("Initiate Crew Transfer", "Continue The Round")
		return TRUE
	return FALSE

/datum/controller/subsystem/vote/proc/sunset_vote_menu(trialmin)
	var/avt = CONFIG_GET(flag/allow_vote_transfer)
	if(avt || trialmin)
		. += "<a href='?src=[REF(src)];vote=crew_transfer'>Crew Transfer</a>"
	else
		. += "<font color='grey'>Crew Transfer (Disallowed)</font>"

/datum/controller/subsystem/vote/proc/sunset_vote_topic(option)
	if(option == "crew_transfer" && usr.client.holder)
		initiate_vote("crew_transfer", usr.key)
		return TRUE
	return FALSE