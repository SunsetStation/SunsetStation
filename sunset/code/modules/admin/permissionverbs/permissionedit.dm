//=========== MENTORS ===========

/client/proc/edit_mentor_permissions()
	set category = "Admin"
	set name = "Mentor Panel"
	set desc = "Edit mentors"
	if(!check_rights(R_PERMISSIONS))
		return
	usr.client.holder.edit_mentor_permissions()

/datum/admins/proc/edit_mentor_permissions()
	if(!check_rights(R_PERMISSIONS))
		return

	var/output = {"<!DOCTYPE html>
<html>
<head>
<title>Permissions Panel</title>
<script type='text/javascript' src='search.js'></script>
<link rel='stylesheet' type='text/css' href='panels.css'>
</head>
<body onload='selectTextField();updateSearch();'>
<div id='main'><table id='searchable' cellspacing='0'>
<tr class='title'>
<th style='width:125px;text-align:right;'>CKEY <a class='small' href='?src=[REF(src)];[HrefToken()];editmentor=add'>\[+\]</a></th>
</tr>
"}

	for(var/men_ckey in GLOB.mentor_datums)
		output += "<tr>"
		output += "<td>[men_ckey]<a class='small' href='?src=[REF(src)];[HrefToken()];editmentor=remove;ckey=[men_ckey]'>\[-\]</a></td>"
		output += "</tr>"

	output += {"
</table></div>
<div id='top'><b>Search:</b> <input type='text' id='filter' value='' style='width:70%;' onkeyup='updateSearch();'></div>
</body>
</html>"}

	usr << browse(output,"window=editrights;size=600x200")

/datum/admins/proc/log_mentor_rank_given(target_ckey)
	if(CONFIG_GET(flag/mentor_legacy_system))
		to_chat(usr, "<span class='adminnotice'>The server is using the legacy system. Modify the config files to change mentor ranks.</span>")
		return

	if(!usr.client)
		return

	if(!check_rights(R_PERMISSIONS))
		return

	if(!SSdbcore.Connect())
		to_chat(usr, "<span class='danger'>Failed to establish database connection.</span>")
		return

	if(!target_ckey)
		return

	target_ckey = ckey(target_ckey)

	if(!target_ckey)
		return

	if(!istext(target_ckey))
		return

	var/datum/DBQuery/query_make_mentor = SSdbcore.NewQuery("INSERT INTO [format_table_name("mentor")] (ckey) VALUES ('[target_ckey]')")
	if(!query_make_mentor.warn_execute())
		return
	to_chat(usr, "<span class='adminnotice'><b>[target_ckey]</b> has been added as a mentor.</span>")
	edit_mentor_permissions()
/datum/admins/proc/log_mentor_rank_delete(target_ckey)
	if(CONFIG_GET(flag/mentor_legacy_system))
		to_chat(usr, "<span class='adminnotice'>The server is using the legacy system. Modify the config files to change mentor ranks.</span>")
		return

	if(!usr.client)
		return

	if(!check_rights(R_PERMISSIONS))
		return

	if(!SSdbcore.Connect())
		to_chat(usr, "<span class='danger'>Failed to establish database connection.</span>")
		return

	if(!target_ckey)
		return

	target_ckey = ckey(target_ckey)

	if(!target_ckey)
		return

	if(!istext(target_ckey))
		return

	var/datum/DBQuery/query_delete_mentor = SSdbcore.NewQuery("DELETE FROM [format_table_name("mentor")] WHERE ckey='[target_ckey]'")
	if(!query_delete_mentor.warn_execute())
		return
	to_chat(usr, "<span class='adminnotice'><b>[target_ckey]</b> has been removed from the mentor list.</span>")
	edit_mentor_permissions()
