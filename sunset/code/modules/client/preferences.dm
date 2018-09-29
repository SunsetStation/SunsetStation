

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
	return dat


/datum/preferences/proc/process_vox(mob/user)

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
      
/datum/preferences
	clientfps = 60
