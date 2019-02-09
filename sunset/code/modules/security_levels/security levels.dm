/proc/sunset_get_atc_to_fuck_off_if_its_red(level)
	if(level >= SEC_LEVEL_RED)
		GLOB.atc.reroute_traffic(yes = TRUE)
	else
		GLOB.atc.reroute_traffic(yes = FALSE)
