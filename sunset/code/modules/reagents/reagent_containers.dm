
/obj/item/reagent_containers/canconsume(mob/eater, mob/user)
	if(!eater.has_mouth())
		if(eater == user)
			to_chat(eater, "<span class='warning'>You have no mouth, and cannot eat.</span>")
		else
			to_chat(user, "<span class='warning'>You can't feed [eater], because they have no mouth!</span>")
		return 0
	. = .. ()
