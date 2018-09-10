/obj/machinery/announcement_system/proc/announce(message_type, user, rank, list/channels)
	if(!is_operational())
		return

	var/message

	if(message_type == "ARRIVAL" && arrivalToggle)
		message = CompileText(arrival, user, rank)
	else if(message_type == "NEWHEAD" && newheadToggle)
		message = CompileText(newhead, user, rank)
	else if(message_type == "CRYOSTORAGE")
		message = CompileText("%PERSON, %RANK has been moved to cryo storage.", user, rank)
	else if(message_type == "ARRIVALS_BROKEN")
		message = "The arrivals shuttle has been damaged. Docking for repairs..."

	if(channels.len == 0)
		radio.talk_into(src, message, null, list(SPAN_ROBOT), get_default_language())
	else
		for(var/channel in channels)
			radio.talk_into(src, message, channel, list(SPAN_ROBOT), get_default_language())
