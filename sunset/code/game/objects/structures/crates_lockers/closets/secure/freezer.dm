/obj/structure/closet/secure_closet/freezer/fridge
	name = "Refrigerator"
	desc = "Is your refrigitator running? If so, you better catch it then!" //I have no regrets
	icon = 'sunset/icons/obj/closet.dmi'
	icon_state = "freezer"
	icon_welded = "freezer_welded"

/obj/structure/closet/secure/freezer/fridge/update_icon()
	cut_overlays()
	if(!opened)
		layer = OBJ_LAYER
		if(icon_door)
			add_overlay("[icon_door]_door")
		else
			add_overlay("[icon_state]_door")
		if(welded)
			add_overlay(icon_welded)
		if(secure && !broken)
			if(locked)
				add_overlay("freezer_locked")
			else
				add_overlay("freezer_unlocked")

	else
		layer = BELOW_OBJ_LAYER
		if(icon_door_override)
			add_overlay("[icon_door]_open")
		else
			add_overlay("[icon_state]_open")