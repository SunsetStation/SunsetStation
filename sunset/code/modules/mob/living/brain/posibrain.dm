

/obj/item/mmi/posibrain
	var/silenced = FALSE //if set to TRUE, they can't talk.

/obj/item/mmi/posibrain/examine(mob/user)
	if(..(user, TRUE))
		to_chat(user, "Its speaker is turned [silenced ? "off" : "on"].")

/obj/item/mmi/posibrain/ipc
	desc = "A cube of shining metal, four inches to a side and covered in shallow grooves. It has an IPC serial number engraved on the top."
	autoping = FALSE
