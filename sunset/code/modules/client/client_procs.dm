/client/proc/sunsetClientTopic(href, href_list, hsrc)
	if(href_list["mentor_msg"])
		if(CONFIG_GET(flag/mentors_mobname_only))
			var/mob/M = locate(href_list["mentor_msg"])
			cmd_mentor_pm(M,null)
		else
			cmd_mentor_pm(href_list["mentor_msg"],null)
		return
 	// Mentor Follow
	if(href_list["mentor_follow"])
		var/mob/living/M = locate(href_list["mentor_follow"])
		if(istype(M))
			mentor_follow(M)
		return