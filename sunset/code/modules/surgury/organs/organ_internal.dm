/obj/item/organ
	var/remove_on_qdel = TRUE

/obj/item/organ/Destroy()
	if(owner && remove_on_qdel)
		// The special flag is important, because otherwise mobs can die
		// while undergoing transformation into different mobs.
		Remove(owner, special=TRUE)
	return ..()
