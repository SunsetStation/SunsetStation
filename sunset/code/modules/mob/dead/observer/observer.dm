/mob/living/ghost()
	set category = "OOC"
	set name = "Ghost"
	set desc = "Relinquish your life and enter the land of the dead."
	if(istype(loc, /obj/machinery/cryopod))
		var/response = alert(src, "Are you -sure- you want to ghost?\n(You are alive. If you ghost whilst still alive you may not play again this round! You can't change your mind so choose wisely!!)","Are you sure you want to ghost?","Ghost","Stay in body")
		if(response != "Ghost")//darn copypaste
			return
		var/obj/machinery/cryopod/C = loc
		C.despawn_occupant()
		return
	if(stat != DEAD)
		succumb()
	if(stat == DEAD)
		ghostize(1)
	else
		var/response = alert(src, "Are you -sure- you want to ghost?\n(You are alive. If you ghost whilst still alive you may not play again this round! You can't change your mind so choose wisely!!)","Are you sure you want to ghost?","Ghost","Stay in body")
		if(response != "Ghost")
			return	//didn't want to ghost after-all
		ghostize(0)						//0 parameter is so we can never re-enter our body, "Charlie, you can never come baaaack~" :3