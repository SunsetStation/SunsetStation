/datum/admins/proc/sunsetSecretsTopic(item, href_list)
	switch(item)
		if("mentor_log") //adds mentor logs from sunsetstation
			var/dat = "<B>Mentor Log<HR></B>"
			for(var/l in GLOB.mentorlog)
				dat += "<li>[l]</li>"
			if(!GLOB.mentorlog.len)
				dat += "No mentors have done anything this round!"
			usr << browse(dat, "window=mentor_log")