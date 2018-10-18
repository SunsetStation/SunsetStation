/obj/item/gps
	var/turf/locked_location

/obj/item/gps/ui_data(mob/user)
	var/list/data = list()
	data["power"] = tracking
	data["tag"] = gpstag
	data["updating"] = updating
	data["globalmode"] = global_mode
	if(!tracking || emped) //Do not bother scanning if the GPS is off or EMPed
		return data

	locked_location = get_turf(src)
	data["current"] = "[get_area_name(locked_location)] ([locked_location.x], [locked_location.y], [locked_location.z])"

	var/list/signals = list()
	data["signals"] = list()

	for(var/gps in GLOB.GPS_list)
		var/obj/item/gps/G = gps
		if(G.emped || !G.tracking || G == src)
			continue
		var/turf/pos = get_turf(G)
		if(!global_mode && pos.z != locked_location.z)
			continue
		var/area/gps_area = get_area_name(G)
		var/list/signal = list()
		signal["entrytag"] = G.gpstag //Name or 'tag' of the GPS
		signal["area"] = format_text(gps_area)
		signal["coord"] = "[pos.x], [pos.y], [pos.z]"
		if(pos.z == locked_location.z) //Distance/Direction calculations for same z-level only
			signal["dist"] = max(get_dist(locked_location, pos), 0) //Distance between the src and remote GPS turfs
			signal["degrees"] = round(Get_Angle(locked_location, pos)) //0-360 degree directional bearing, for more precision.
			var/direction = uppertext(dir2text(get_dir(locked_location, pos))) //Direction text (East, etc). Not as precise, but still helpful.
			if(!direction)
				direction = "CENTER"
				signal["degrees"] = "N/A"
			signal["direction"] = direction

		signals += list(signal) //Add this signal to the list of signals
	data["signals"] = signals
	return data
