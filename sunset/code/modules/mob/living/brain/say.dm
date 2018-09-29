/mob/living/brain/say(message, language)
	var/obj/item/device/mmi/posibrain/P = container
	if(P && P.silenced)
		to_chat(usr, "<span class='warning'>You cannot speak, as your internal speaker is turned off.</span>")
		return
	. = .. ()
