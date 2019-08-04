#define DEFAULT_SLOT_AMT	1
#define HANDS_SLOT_AMT		2
#define BACKPACK_SLOT_AMT	3

/datum/preferences
	clientfps = 60
	var/gear_points = 5
	var/list/gear_categories
	var/list/chosen_gear
	var/gear_tab
	var/crew_objectives = TRUE // added to enable crew objectives

/datum/preferences/New(client/C)
	..()
	LAZYINITLIST(chosen_gear)

/datum/preferences/proc/sunset_do_dat(current_tab)
	switch(current_tab)
		if(3)
			if(!gear_tab)
				gear_tab = GLOB.loadout_items[1]
			. += "<table align='center' width='100%'>"
			. += "<tr><td colspan=4><center><b><font color='[gear_points == 0 ? "#E67300" : "#3366CC"]'>[gear_points]</font> loadout points remaining.</b> \[<a href='?_src_=prefs;preference=gear;clear_loadout=1'>Clear Loadout</a>\]</center></td></tr>"
			. += "<tr><td colspan=4><center>You can only choose one item per category, unless it's an item that spawns in your backpack or hands.</center></td></tr>"
			. += "<tr><td colspan=4><center><b>"
			var/firstcat = TRUE
			for(var/i in GLOB.loadout_items)
				if(firstcat)
					firstcat = FALSE
				else
					. += " |"
				if(i == gear_tab)
					. += " <span class='linkOn'>[i]</span> "
				else
					. += " <a href='?_src_=prefs;preference=gear;select_category=[i]'>[i]</a> "
			. += "</b></center></td></tr>"
			. += "<tr><td colspan=4><hr></td></tr>"
			. += "<tr><td colspan=4><b><center>[gear_tab]</center></b></td></tr>"
			. += "<tr><td colspan=4><hr></td></tr>"
			. += "<tr style='vertical-align:top;'><td width=15%><b>Name</b></td>"
			. += "<td width=5% style='vertical-align:top'><b>Cost</b></td>"
			. += "<td><font size=2><b>Restrictions</b></font></td>"
			. += "<td><font size=2><b>Description</b></font></td></tr>"
			for(var/j in GLOB.loadout_items[gear_tab])
				var/datum/gear/gear = GLOB.loadout_items[gear_tab][j]
				var/class_link = ""
				if(gear.type in chosen_gear)
					class_link = "class='linkOn' href='?_src_=prefs;preference=gear;toggle_gear_path=[j];toggle_gear=0'"
				else if(gear_points <= 0)
					class_link = "class='linkOff'"
				else
					class_link = "href='?_src_=prefs;preference=gear;toggle_gear_path=[j];toggle_gear=1'"
				. += "<tr style='vertical-align:top;'><td width=15%><a style='white-space:normal;' [class_link]>[j]</a></td>"
				. += "<td width = 5% style='vertical-align:top'>[gear.cost]</td><td>"
				if(islist(gear.restricted_roles))
					if(gear.restricted_roles.len)
						. += "<font size=2>"
						. += gear.restricted_roles.Join(";")
						. += "</font>"
				. += "</td><td><font size=2><i>[gear.description]</i></font></td></tr>"
			. += "</table>"


/datum/preferences/proc/is_loadout_slot_available(slot)
	var/list/L = list()
	for(var/i in chosen_gear)
		var/datum/gear/G = i
		var/occupied_slots = L[slot_to_string(initial(G.category))] ? L[slot_to_string(initial(G.category))] + 1 : 1
		LAZYSET(L, slot_to_string(initial(G.category)), occupied_slots)
	switch(slot)
		if(SLOT_IN_BACKPACK)
			if(L[slot_to_string(SLOT_IN_BACKPACK)] < BACKPACK_SLOT_AMT)
				return TRUE
		if(SLOT_HANDS)
			if(L[slot_to_string(SLOT_HANDS)] < HANDS_SLOT_AMT)
				return TRUE
		else
			if(L[slot_to_string(slot)] < DEFAULT_SLOT_AMT)
				return TRUE

/datum/preferences/proc/vox_preference_data(mob/user)
	var/list/dat = list()
	if("vox_body" in pref_species.mutant_bodyparts) //sunset vox bodyparts
		dat += "<td valign='top' width='14%'>"
		dat += "<h3>Body Color</h3>"
		dat += "<a href='?_src_=prefs;preference=vox_body;task=input'>[features["vox_body"]]</a><BR>"
		dat += "</td>"

	if("vox_quills" in pref_species.mutant_bodyparts) //sunset vox bodyparts
		dat += "<td valign='top' width='14%'>"
		dat += "<h3>Quill Style</h3>"
		dat += "<a href='?_src_=prefs;preference=vox_quills;task=input'>[features["vox_quills"]]</a><BR>"
		dat += "<span style='border:1px solid #161616; background-color: #[hair_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=hair;task=input'>Change</a><BR>"
		dat += "</td>"

	if("vox_facial_quills" in pref_species.mutant_bodyparts) //sunset vox bodyparts
		dat += "<td valign='top' width='14%'>"
		dat += "<h3>Vox Facial Quills Style</h3>"
		dat += "<a href='?_src_=prefs;preference=vox_facial_quills;task=input'>[features["vox_facial_quills"]]</a><BR>"
		dat += "<span style='border:1px solid #161616; background-color: #[facial_hair_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=facial;task=input'>Change</a><BR>"
		dat += "</td>"

	if("vox_eyes" in pref_species.mutant_bodyparts) //sunset vox bodyparts
		dat += "<td valign='top' width='14%'>"
		dat += "<h3>Vox Eye Color</h3>"
		dat += "<span style='border:1px solid #161616; background-color: #[eye_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=eyes;task=input'>Change</a><BR>"
		dat += "</td>"

	if("vox_body_markings" in pref_species.mutant_bodyparts) //sunset vox bodyparts
		dat += "<td valign='top' width='10%'>"
		dat += "<h3>Vox Body Markings</h3>"
		dat += "<a href='?_src_=prefs;preference=vox_body_markings;task=input'>[features["vox_body_markings"]]</a><BR>"
		dat += "<span style='border: 1px solid #161616; background-color: #[features["mcolor"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=mutant_color;task=input'>Change</a><BR>"
		dat += "</td>"

	if("vox_tail_markings" in pref_species.mutant_bodyparts) //sunset vox bodyparts
		dat += "<td valign='top' width='10%'>"
		dat += "<h3>Vox Tail Markings</h3>"
		dat += "<a href='?_src_=prefs;preference=vox_tail_markings;task=input'>[features["vox_tail_markings"]]</a><BR>"
		dat += "</td>"
	//Ipc body parts
	if("ipc_screen" in pref_species.mutant_bodyparts)
		dat += "<td valign='top' width='14%'>"
		dat += "<h3>Screen Style</h3>"
		dat += "<a href='?_src_=prefs;preference=ipc_screen;task=input'>[features["ipc_screen"]]</a><BR>"
		dat += "<span style='border: 1px solid #161616; background-color: #[eye_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=eyes;task=input'>Change</a><BR>"
		dat += "</td>"

	if("ipc_antenna" in pref_species.mutant_bodyparts)
		dat += "<td valign='top' width='14%'>"
		dat += "<h3>Antenna Style</h3>"
		dat += "<a href='?_src_=prefs;preference=ipc_antenna;task=input'>[features["ipc_antenna"]]</a><BR>"
		dat += "<span style='border:1px solid #161616; background-color: #[hair_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=hair;task=input'>Change</a><BR>"
		dat += "</td>"

	if("ipc_chassis" in pref_species.mutant_bodyparts)
		dat += "<td valign='top' width='14%'>"
		dat += "<h3>Chassis Style</h3>"
		dat += "<a href='?_src_=prefs;preference=ipc_chassis;task=input'>[features["ipc_chassis"]]</a><BR>"
		dat += "</td>"
	return dat


/datum/preferences/proc/process_sunset_link(mob/user, list/href_list)
	switch(href_list["preference"])
		if("vox_body") //sunset vox included
			var/new_vox_body
			new_vox_body = input(user, "Choose your character's body color:", "Character Preference") as null|anything in GLOB.vox_bodies_list
			if(new_vox_body)
				features["vox_body"] = new_vox_body
		if("vox_quills") //sunset vox included
			var/new_vox_quills
			new_vox_quills = input(user, "Choose your character's quills:", "Character Preference") as null|anything in GLOB.vox_quills_list
			if(new_vox_quills)
				features["vox_quills"] = new_vox_quills
		if("vox_facial_quills") //sunset vox included
			var/new_vox_facial_quills
			new_vox_facial_quills = input(user, "Choose your character's facial quills:", "Character Preference") as null|anything in GLOB.vox_facial_quills_list
			if(new_vox_facial_quills)
				features["vox_facial_quills"] = new_vox_facial_quills
		if("vox_body_markings") //sunset vox included
			var/new_vox_body_markings
			new_vox_body_markings = input(user, "Choose your character's body markings", "Character Preference") as null|anything in GLOB.vox_body_markings_list
			if(new_vox_body_markings)
				features["vox_body_markings"] = new_vox_body_markings
		if("vox_tail_markings") //sunset vox included
			var/new_vox_tail_markings
			new_vox_tail_markings = input(user, "Choose your character's tail markings", "Character Preference") as null|anything in GLOB.vox_tail_markings_list
			if(new_vox_tail_markings)
				features["vox_tail_markings"] = new_vox_tail_markings
		if("ipc_screen")
			var/new_ipc_screen
			new_ipc_screen = input(user, "Choose your character's screen:", "Character Preference") as null|anything in GLOB.ipc_screens_list
			if(new_ipc_screen)
				features["ipc_screen"] = new_ipc_screen
		if("ipc_antenna")
			var/new_ipc_antenna
			new_ipc_antenna = input(user, "Choose your character's antenna:", "Character Preference") as null|anything in GLOB.ipc_antennas_list
			if(new_ipc_antenna)
				features["ipc_antenna"] = new_ipc_antenna
		if("ipc_chassis")
			var/new_ipc_chassis
			new_ipc_chassis = input(user, "Choose your character's chassis:", "Character Preference") as null|anything in GLOB.ipc_chassis_list
			if(new_ipc_chassis)
				features["ipc_chassis"] = new_ipc_chassis
		if("gear")
			if(href_list["clear_loadout"])
				LAZYCLEARLIST(chosen_gear)
				gear_points = initial(gear_points)
				save_preferences()
			if(href_list["select_category"])
				for(var/i in GLOB.loadout_items)
					if(i == href_list["select_category"])
						gear_tab = i
			if(href_list["toggle_gear_path"])
				var/datum/gear/G = GLOB.loadout_items[gear_tab][href_list["toggle_gear_path"]]
				if(!G)
					return
				var/toggle = text2num(href_list["toggle_gear"])
				if(!toggle && (G.type in chosen_gear))//toggling off and the item effectively is in chosen gear)
					LAZYREMOVE(chosen_gear, G.type)
					gear_points += initial(G.cost)
				else if(toggle && (!locate(G, chosen_gear)))
					if(!is_loadout_slot_available(G.category))
						to_chat(user, "<span class='danger'>You cannot take this loadout, as you've already chosen too many of the same category!</span>")
						return
					if(gear_points >= initial(G.cost))
						LAZYADD(chosen_gear, G.type)
						gear_points -= initial(G.cost)
/datum/preferences
	clientfps = 60


