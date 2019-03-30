/mob/living/ghost()
	if(istype(loc, /obj/machinery/cryopod))
		var/response = alert(src, "Are you -sure- you want to ghost?\n(You are alive. If you ghost whilst still alive you may not play again this round! You can't change your mind so choose wisely!!)","Are you sure you want to ghost?","Ghost","Stay in body")
		if(response != "Ghost")//darn copypaste
			return
		var/obj/machinery/cryopod/C = loc
		C.despawn_occupant()
	return ..()