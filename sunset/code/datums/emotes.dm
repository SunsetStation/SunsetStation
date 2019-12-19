/datum/emote
	var/message_vox = "" // Message to display if the user is a vox sunset
	var/message_ipc = "" // Message to display if the user is an IPC


/datum/emote/select_message_type(mob/user)
	. = ..()
	if(isvox(user) && message_vox)//sunset message vox
		. = message_vox
	else if(isipc(user) && message_ipc)
		. = message_ipc
