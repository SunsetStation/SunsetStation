/client/add_admin_verbs()
	var/rights = holder.rank.rights
	if(rights & R_MENTOR)//sunset adds mentor system
		verbs += GLOB.mentor_verbs
	. = ..()
