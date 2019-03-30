/obj/structure/sink/counter
	icon = 'sunset/icons/obj/watercloset.dmi'
	icon_state = "sink_counter"
	desc = "A sink used for washing, perfect to fill up with dirty dishes."


/obj/structure/patient_divider //Code for this is based on the shower curtains
	name = "divider"
	desc = "Perfect in ensuring that patients don't know that they are worse off than their neighbor."
	icon = 'sunset/icons/obj/watercloset.dmi'
	icon_state = "patient_closed"
	layer = WALL_OBJ_LAYER
	anchored = TRUE
	opacity = 1
	density = TRUE
	var/open = FALSE

/obj/structure/patient_divider/proc/toggle()
	open = !open
	update_icon()

/obj/structure/patient_divider/update_icon()
	if(!open)
		icon_state = "patient_closed"
		layer = WALL_OBJ_LAYER
		density = TRUE
		open = FALSE
		opacity = 1

	else
		icon_state = "patient_open"
		layer = SIGN_LAYER
		density = FALSE
		open = TRUE
		opacity = 0

/obj/structure/patient_divider/wrench_act(mob/living/user, obj/item/I)
	default_unfasten_wrench(user, I, 50)
	return TRUE

/obj/structure/patient_divider/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	playsound(loc, 'sound/effects/bin_open.ogg', 50, 1)
	toggle()

/obj/structure/patient_divider/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(src.loc, 'sound/weapons/slash.ogg', 80, 1)
			else
				playsound(loc, 'sound/weapons/tap.ogg', 50, 1)
		if(BURN)
			playsound(loc, 'sound/items/welder.ogg', 80, 1)
