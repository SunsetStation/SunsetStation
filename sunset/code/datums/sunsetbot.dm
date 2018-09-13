/datum/world_topic/pr_announce
	keyword = "pr_announce"

/datum/world_topic/Manifest
	keyword = "manifest"
	
/datum/world_topic/manifest/Run(list/input)
	var/list/set_names = list(
		"heads" = GLOB.command_positions,
		"sec" = GLOB.security_positions,
		"eng" = GLOB.engineering_positions,
		"med" = GLOB.medical_positions,
		"sci" = GLOB.science_positions,
		"car" = GLOB.supply_positions,
		"srv" = GLOB.service_positions,
		"civ" = GLOB.civilian_positions,
		"bot" = GLOB.nonhuman_positions
	)
	var/list/positions = list()
	for(var/datum/data/record/t in GLOB.data_core.general)
		var/name = t.fields["name"]
		var/rank = t.fields["rank"]
		var/real_rank = t.fields["real_rank"]
 		var/department = 0
		for(var/k in set_names)
			if(real_rank in set_names[k])
				if(!positions[k])
					positions[k] = list()
				positions[k][name] = rank
				department = 1
		if(!department)
			if(!positions["misc"])
				positions["misc"] = list()
			positions["misc"][name] = rank
		return list2json(positions)

/datum/world_topic/announce
	keyword = "announce"
	require_comms_key = TRUE

/datum/world_topic/announce/Run(list/input)
	for(var/client/C in clients)
		to_chat(C, "<span class='announce'>PR: [input["msg"]]</span>")

/datum/world_topic/ircrestart
	keyword = "ircrestart"
	require_comms_key = TRUE

 /datum/world_topic/ircrestart/Run(list/input)
 	return Reboot(input[keyword], input["reason"])
