/obj/structure/chair/wood
	icon = 'sunset/icons/obj/chairs.dmi'

/obj/structure/chair/comfy
	icon = 'sunset/icons/obj/chairs.dmi'

/obj/structure/chair/comfy/proc/GetArmrest()
	return mutable_appearance('sunset/icons/obj/chairs.dmi', "comfychair_armrest")

/obj/structure/chair/office
	icon = 'sunset/icons/obj/chairs.dmi'
	var/mutable_appearance/armrest

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
