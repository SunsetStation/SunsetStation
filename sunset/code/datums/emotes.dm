/datum/emote
	var/message_vox = "" // Message to display if the user is a vox sunset
	var/cooldown = 20 // deci-seconds of cooldown


/datum/emote/select_message_type(mob/user)
	. = ..()
	if(isvox(user) && message_vox)//sunset message vox
		. = message_vox
