/datum/controller/subsystem/ticker
	var/has_autotransfer_run = FALSE

/datum/controller/subsystem/ticker/proc/auto_transfer()
	var/initial_wait = CONFIG_GET(number/voter_autotransfer_initial)
	var/interval_wait = CONFIG_GET(number/voter_autotransfer_interval)

	if(!initial_wait || initial_wait <= 0)
		return
	if(has_autotransfer_run && (!interval_wait || interval_wait <= 0))
		return
	has_autotransfer_run = TRUE
	if(!(SSshuttle.emergency.mode in list(SHUTTLE_ENDGAME, SHUTTLE_ESCAPE)))
		return
	SSvote.initiate_vote("crew_transfer", "the server")
	addtimer(CALLBACK(src, .proc/auto_transfer), interval_wait*10)