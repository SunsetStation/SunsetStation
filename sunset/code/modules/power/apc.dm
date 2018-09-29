/obj/machinery/power/apc/attackby(obj/item/W, mob/living/user, params)
	if(istype(W, /obj/item/apc_powercord))
		return //because we put our fancy code in the right places, and this is all in the powercord's afterattack()
	. = .. ()
