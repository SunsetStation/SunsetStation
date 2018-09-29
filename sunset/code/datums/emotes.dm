/datum/emote
	var/message_vox = "" // Message to display if the user is a vox sunset


/datum/emote/select_message_type(mob/user)
	if(isvox(user) && message_vox)//sunset message vox
		. = message_vox
