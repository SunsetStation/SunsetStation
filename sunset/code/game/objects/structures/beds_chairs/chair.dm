/obj/structure/chair/wood
	icon = 'sunset/icons/obj/chairs.dmi'

/obj/structure/chair/wood/wings
	icon = 'icons/obj/chairs.dmi'

/obj/structure/chair/comfy
	icon = 'sunset/icons/obj/chairs.dmi'

/obj/structure/chair/comfy/GetArmrest()
	return mutable_appearance('sunset/icons/obj/chairs.dmi', "comfychair_armrest")

/obj/structure/chair/office
	icon = 'sunset/icons/obj/chairs.dmi'
	var/mutable_appearance/armrest

/obj/structure/chair/office/blue
	icon_state = "officechair_blue"

/obj/structure/chair/office/orange
	icon_state = "officechair_orange"

/obj/structure/chair/office/red
	icon_state = "officechair_red"

/obj/structure/chair/office/green
	icon_state = "officechair_green"

/obj/structure/chair/office/black
	icon_state = "officechair_black"

/obj/structure/chair/office/purple
	icon_state = "officechair_purple"

/obj/structure/chair/office/darkblue
	icon_state = "officechair_darkblue"

/obj/structure/chair/office/Initialize()
	armrest = GetArmrest()
	armrest.layer = ABOVE_MOB_LAYER
	return ..()

/obj/structure/chair/office/proc/GetArmrest()
	return mutable_appearance('sunset/icons/obj/chairs.dmi', "officechair_armrest")

/obj/structure/chair/office/Destroy()
	QDEL_NULL(armrest)
	return ..()

/obj/structure/chair/office/post_buckle_mob(mob/living/M)
	. = ..()
	update_armrest()

/obj/structure/chair/office/proc/update_armrest()
	if(has_buckled_mobs())
		add_overlay(armrest)
	else
		cut_overlay(armrest)

/obj/structure/chair/comfy/shuttle
	icon = 'icons/obj/chairs.dmi'

/obj/structure/chair/comfy/shuttle/GetArmrest()
	return mutable_appearance('icons/obj/chairs.dmi', "shuttle_chair_armrest")

/obj/structure/chair/stool
 	icon = 'sunset/icons/obj/chairs.dmi'

/obj/structure/chair/stool/bar
	icon = 'sunset/icons/obj/chairs.dmi'

/obj/item/chair/stool
	icon = 'sunset/icons/obj/chairs.dmi'

/obj/item/chair/stool/narsie_act()
	return //sturdy enough to ignore a god

/obj/item/chair/wood
	icon = 'sunset/icons/obj/chairs.dmi'
