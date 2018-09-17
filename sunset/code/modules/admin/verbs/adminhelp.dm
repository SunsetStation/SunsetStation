/client/proc/check_mentorhelp(msg)
	var/msg_lower = lowertext(msg)
	if((findtext(msg_lower, "how to") == 1 || findtext(msg_lower, "how do") == 1) && GLOB.mentors.len)
		if(alert("\"[msg]\" looks like a game mechanics question, would you like to ask in mentorhelp instead?", "Adminhelp?", "Yes, mentorhelp", "No, adminhelp") == "Yes, mentorhelp")
			mentorhelp(msg)
			return TRUE
	return FALSE