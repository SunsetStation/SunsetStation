/datum/world_topic/pr_announce
	keyword = "pr_announce"

/datum/world_topic/manifest
	keyword = "manifest"

/datum/world_topic/manifest/Run(list/input)
	var/list/heads = list()
	var/list/sec = list()
	var/list/eng = list()
	var/list/med = list()
	var/list/sci = list()
	var/list/sup = list()
	var/list/civ = list()
	var/list/bot = list()
	var/list/misc = list()
	var/list/dat = list()
	var/even = 0
	// sort mobs
	for(var/datum/data/record/t in GLOB.data_core.general)
		var/name = t.fields["name"]
		var/rank = t.fields["rank"]
		var/department = 0
		if(rank in GLOB.command_positions)
			heads[name] = rank
			department = 1
		if(rank in GLOB.security_positions)
			sec[name] = rank
			department = 1
		if(rank in GLOB.engineering_positions)
			eng[name] = rank
			department = 1
		if(rank in GLOB.medical_positions)
			med[name] = rank
			department = 1
		if(rank in GLOB.science_positions)
			sci[name] = rank
			department = 1
		if(rank in GLOB.supply_positions)
			sup[name] = rank
			department = 1
		if(rank in GLOB.civilian_positions)
			civ[name] = rank
			department = 1
		if(rank in GLOB.nonhuman_positions)
			bot[name] = rank
			department = 1
		if(!department && !(name in heads))
			misc[name] = rank
	if(heads.len > 0)
		LAZYINITLIST(dat["Heads"])
		for(var/name in heads)
			LAZYADD(dat["Heads"] , "[name] + [heads[name]]")
			even = !even
	if(sec.len > 0)
		LAZYINITLIST(sec["Security"])
		for(var/name in sec)
			LAZYADD(dat["Security"] , "[name] + [sec[name]]")
			even = !even
	if(eng.len > 0)
		LAZYINITLIST(dat["Engineering"])
		for(var/name in eng)
			LAZYADD(dat["Engineering"] , "[name] + [eng[name]]")
			even = !even
	if(med.len > 0)
		LAZYINITLIST(dat["Medical"])
		for(var/name in med)
			LAZYADD(dat["Medical"] , "[name] + [med[name]]")
			even = !even
	if(sci.len > 0)
		LAZYINITLIST(dat["Science"])
		for(var/name in sci)
			LAZYADD(dat["Science"] , "[name] + [sci[name]]")
			even = !even
	if(sup.len > 0)
		LAZYINITLIST(dat["Supply"])
		for(var/name in sup)
			LAZYADD(dat["Supply"] , "[name] + [sup[name]]")
			even = !even
	if(civ.len > 0)
		LAZYINITLIST(dat["Civilian"])
		for(var/name in civ)
			LAZYADD(dat["Civilian"] , "[name] + [civ[name]]")
			even = !even
	// in case somebody is insane and added them to the manifest, why not
	if(bot.len > 0)
		LAZYINITLIST(dat["Silicon"])
		for(var/name in bot)
			LAZYADD(dat["Silicon"] , "[name] + [bot[name]]")
			even = !even
	// misc guys
	if(misc.len > 0)
		LAZYINITLIST(dat["Miscellaneous"])
		for(var/name in misc)
			LAZYADD(dat["Miscellaneous"] , "[name] + [misc[name]]")
			even = !even
	return json_encode(dat)


/datum/world_topic/announce
	keyword = "announce"
	require_comms_key = TRUE

/datum/world_topic/announce/Run(list/input)
	for(var/client/C in GLOB.clients)
		to_chat(C, "<span class='announce'>PR: [input["msg"]]</span>")

/datum/world_topic/ircrestart
	keyword = "ircrestart"
	require_comms_key = TRUE

 /datum/world_topic/ircrestart/Run(list/input)
 	return world.Reboot(input[keyword], input["reason"])
