

/obj/item/makeshift/reclaimer
	name = "Reclaimer"
	desc = "A tool used to efficently gather anything still useful from a wreck. A survivalist's must have."
	icon = 'sunset/icons/obj/salvage.dmi'
	icon_state = "reclaimer"
	var/efficency = 1
	var/rec_ready = TRUE

/obj/item/makeshift/reclaimer/update_icon()
	if (rec_ready)
		icon_state = "reclaimer_empty"
	else
		icon_state = "reclaimer"

/obj/item/makeshift/reclaimer/afterattack(atom/A, mob/user, proximity)
	A.rec_act(user, src)