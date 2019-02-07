/proc/sunset_get_atc_to_fuck_off(level)
	if(level >= SEC_LEVEL_RED)
		GLOB.atc.reroute_traffic(yes = TRUE)
	else
		GLOB.atc.reroute_traffic(yes = FALSE)
