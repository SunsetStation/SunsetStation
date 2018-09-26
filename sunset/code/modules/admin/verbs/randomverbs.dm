/obj/effect/overlay/adminfrozen
	name = "FROZEN"
	icon = 'sunset/icons/effect/effects.dmi'
	icon_state = "adminfreeze"

/client/proc/cmd_admin_freeze(mob/living/M in GLOB.mob_list)
	set category = "Special Verbs"
	set name = "Freeze Player"
	if(!holder)
		to_chat(src, "Only administrators may use this command.")
		return
	if(!istype(M))
		return
	if(!M.adminfrozen)
		var/sleepies = M.AmountSleeping()
		M.adminfrozen = sleepies ? sleepies : 1
		M.SetSleeping(200000)//20k seconds to get your admin shit together
		M.adminfreezeoverlay = new()
		M.add_overlay(M.adminfreezeoverlay)
		M.anchored = TRUE
		log_admin("[key_name(usr)] froze [key_name(M)]!")
		message_admins("[key_name(usr)] froze [key_name(M)]!")
		to_chat(M, "<span class='userdanger'>You have been frozen by Administrator [usr.key]!</span>")
	else
		M.SetSleeping(M.adminfrozen)//set it to what it was before freezing or just 1/10th of a second if it was nothing
		M.adminfrozen = 0
		M.cut_overlay(M.adminfreezeoverlay)
		M.anchored = FALSE
		log_admin("[key_name(usr)] unfroze [key_name(M)].")
		message_admins("[key_name(usr)] unfroze [key_name(M)].")
		to_chat(M, "<span class='userdanger'>You have been unfrozen by Administrator [usr.key]!</span>")
