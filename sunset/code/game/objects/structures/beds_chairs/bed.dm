/obj/structure/bed/patient
	name = "Patient Bed"
	icon = 'sunset/icons/obj/objects.dmi'
	icon_state = "medbed"
	desc = "For when patients want to get comfortable while their medical insurance takes forever to go through."
	anchored = TRUE
	resistance_flags = FLAMMABLE
	var/mutable_appearance/bedrest

/obj/structure/bed/patient/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/screwdriver))
		if(bolts)
			to_chat(user, "<span class='warning'>You loosen up the bolts in the wheels.</span>")
			bolts = FALSE
			anchored = FALSE
			return

		else
			to_chat(user, "<span class='warning'>You tighten the bolts in the wheels.</span>")
			bolts = TRUE
			anchored = TRUE
			return
	else
		return ..()

/obj/structure/bed/patient/post_buckle_mob(mob/living/M)
	M.pixel_y = initial(M.pixel_y)
	update_icon()

/obj/structure/bed/patient/Moved()
	. = ..()
	if(has_gravity())
		playsound(src, 'sound/effects/roll.ogg', 100, 1)

/obj/structure/bed/patient/post_unbuckle_mob(mob/living/M)
	M.pixel_x = M.get_standard_pixel_x_offset(M.lying)
	M.pixel_y = M.get_standard_pixel_y_offset(M.lying)

/obj/structure/bed/patient/Initialize()
	bedrest = mutable_appearance('sunset/icons/obj/objects.dmi', "medbed_overlay")
	bedrest.layer = ABOVE_MOB_LAYER
	return ..()

/obj/structure/bed/patient/Destroy()
	QDEL_NULL(bedrest)
	return ..()

/obj/structure/bed/patient/post_buckle_mob(mob/living/M)
	. = ..()
	update_bedrest()

/obj/structure/bed/patient/proc/update_bedrest()
	if(has_buckled_mobs())
		add_overlay(bedrest)
	else
		cut_overlay(bedrest)

/obj/structure/bed/patient/examine(mob/user)
	..()
	if(bolts)
		to_chat(user, "<span class='notice'>The bed's wheels are currently bolted, preventing it from moving.</span>")
	else
		to_chat(user, "<span class='notice'>The bed's wheels are unbolted, allowing the bed to be moved.</span>")
