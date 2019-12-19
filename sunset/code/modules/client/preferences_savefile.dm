/datum/preferences/proc/load_character_stuff(S)
	S["feature_vox_body"]				>> features["vox_body"] //sunset vox body parts
	S["feature_vox_quills"]				>> features["vox_quills"]	//sunset vox body parts
	S["feature_vox_facial_quills"]		>> features["vox_facial_quills"]	//sunset vox body parts
	S["feature_vox_body_markings"]		>> features["vox_body_markings"]	//sunset vox body parts
	S["feature_vox_tail_markings"]		>> features["vox_tail_markings"]	//sunset vox body parts
	var/text_to_load
	S["loadout"] >> text_to_load
	var/list/saved_loadout_paths = splittext(text_to_load, "|")
	S["crew_objectives"]	>> crew_objectives // Sunset - Crew objectives
	crew_objectives		= sanitize_integer(crew_objectives, 0, 1, initial(crew_objectives)) // Sunset - Crew objectives
	for(var/i in saved_loadout_paths)
		var/datum/gear/path = text2path(i)
		if(path)
			LAZYADD(chosen_gear, path)
			gear_points -= initial(path.cost)

/datum/preferences/proc/load_character_features()
//sunset start
	features["vox_body"]	 = sanitize_inlist(features["vox_body"], GLOB.vox_bodies_list)
	features["vox_eyes"]	 = sanitize_inlist(features["vox_eyes"], GLOB.vox_eyes_list)
	features["vox_tail"]	 = sanitize_inlist(features["vox_tail"], GLOB.vox_tails_list)
	features["vox_quills"]	 = sanitize_inlist(features["vox_quills"], GLOB.vox_quills_list, "None")
	features["vox_facial_quills"]	 = sanitize_inlist(features["vox_facial_quills"], GLOB.vox_facial_quills_list, "None")
	features["vox_body_markings"]	 = sanitize_inlist(features["vox_body_markings"], GLOB.vox_body_markings_list, "None")
	features["vox_tail_markings"]	 = sanitize_inlist(features["vox_tail_markings"], GLOB.vox_tail_markings_list, "None")
	//sunset IPC parts
	features["ipc_screen"]	= sanitize_inlist(features["ipc_screen"], GLOB.ipc_screens_list)
	features["ipc_antenna"]	 = sanitize_inlist(features["ipc_antenna"], GLOB.ipc_antennas_list)
	features["ipc_chassis"]	 = sanitize_inlist(features["ipc_chassis"], GLOB.ipc_chassis_list)
//sunset stop

/datum/preferences/proc/save_character_stuff(S)
	WRITE_FILE(S["feature_vox_body"]				, features["vox_body"]) //sunset vox body parts
	WRITE_FILE(S["feature_vox_quills"]				, features["vox_quills"]) //sunset vox body parts
	WRITE_FILE(S["feature_vox_facial_quills"]		, features["vox_facial_quills"]) //sunset vox body parts
	WRITE_FILE(S["feature_vox_body_markings"]		, features["vox_body_markings"]) //sunset vox body parts
	WRITE_FILE(S["feature_vox_tail_markings"]		, features["vox_tail_markings"]) //sunset vox body parts
	//sunset IPC parts
	WRITE_FILE(S["feature_ipc_screen"]			, features["ipc_screen"])
	WRITE_FILE(S["feature_ipc_antenna"]			, features["ipc_antenna"])
	WRITE_FILE(S["feature_ipc_chassis"]			, features["ipc_chassis"])
	//sunset stop
	WRITE_FILE(S["crew_objectives"]					, crew_objectives) // Sunset - crew objectives
	if(islist(chosen_gear))
		if(chosen_gear.len)
			var/text_to_save = chosen_gear.Join("|")
			S["loadout"] << text_to_save
		else
			S["loadout"] << "" //empty string to reset the value
