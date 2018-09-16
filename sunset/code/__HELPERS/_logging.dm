/proc/log_looc(text)
	if (CONFIG_GET(flag/log_looc))
		WRITE_LOG(GLOB.world_game_log, "LOOC: [text]")

/proc/log_mentor(text)
	GLOB.mentorlog.Add(text)
	if (CONFIG_GET(flag/log_admin))
		WRITE_FILE(GLOB.world_game_log, "\[[time_stamp()]]MENTOR: [text]")
