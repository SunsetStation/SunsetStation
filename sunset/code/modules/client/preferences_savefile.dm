datum/preferences/proc/load_character_sunset(S)
	//sunset start
	S["feature_vox_body"]				>> features["vox_body"]
	S["feature_vox_quills"]				>> features["vox_quills"]
	S["feature_vox_facial_quills"]		>> features["vox_facial_quills"]
	S["feature_vox_body_markings"]		>> features["vox_body_markings"]
	S["feature_vox_tail_markings"]		>> features["vox_tail_markings"]
	//sunset ipc parts
	S["feature_ipc_screen"]			>> features["ipc_screen"]
	S["feature_ipc_antenna"]				>> features["ipc_antenna"]
	S["feature_ipc_chassis"]				>> features["ipc_chassis"]
	//sunset stop


datum/preferences/proc/load_character_sunset_features()
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

datum/preferences/proc/save_character_sunset(S)
	//sunset start
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
