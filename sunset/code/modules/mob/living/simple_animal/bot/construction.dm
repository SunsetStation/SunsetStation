/obj/item/bot_assembly/medbot
	name = "incomplete medibot assembly"
	desc = "A first aid kit with a robot arm permanently grafted to it."
	icon = 'sunset/icons/mob/aibots.dmi'
	icon_state = "grey-construction"
	created_name = "Medibot" //To preserve the name if it's a unique medbot I guess

/obj/item/bot_assembly/medbot/Initialize()
	. = ..()
	spawn(5)
		if(skin)
			icon_state = ("[skin]-construction")

/obj/item/storage/firstaid/attackby(obj/item/bodypart/S, mob/user, params)

	if((!istype(S, /obj/item/bodypart/l_arm/robot)) && (!istype(S, /obj/item/bodypart/r_arm/robot)))
		return ..()

	//Making a medibot!
	if(contents.len >= 1)
		to_chat(user, "<span class='warning'>You need to empty [src] out first!</span>")
		return

	var/obj/item/bot_assembly/medbot/A = new
	if(istype(src, /obj/item/storage/firstaid/fire))
		A.skin = "yellow"
	else if(istype(src, /obj/item/storage/firstaid/toxin))
		A.skin = "green"
	else if(istype(src, /obj/item/storage/firstaid/o2))
		A.skin = "blue"
	else if(istype(src, /obj/item/storage/firstaid/brute))
		A.skin = "red"
	else if(istype(src, /obj/item/storage/firstaid/advanced))
		A.skin = "purple"
	user.put_in_hands(A)
	to_chat(user, "<span class='notice'>You add [S] to [src].</span>")
	A.robot_arm = S.type
	A.firstaid = type
	qdel(S)
	qdel(src)

/obj/item/bot_assembly/medbot/attackby(obj/item/W, mob/user, params)
	..()
	switch(build_step)
		if(ASSEMBLY_FIRST_STEP)
			if(istype(W, /obj/item/healthanalyzer))
				if(!user.temporarilyRemoveItemFromInventory(W))
					return
				healthanalyzer = W.type
				to_chat(user, "<span class='notice'>You add [W] to [src].</span>")
				qdel(W)
				name = "first aid/robot arm/health analyzer assembly"
				add_overlay('sunset/icons/mob/aibots.dmi', "na_scanner")
				build_step++

		if(ASSEMBLY_SECOND_STEP)
			if(isprox(W))
				if(!can_finish_build(W, user))
					return
				qdel(W)
				var/mob/living/simple_animal/bot/medbot/S = new(drop_location(), skin)
				to_chat(user, "<span class='notice'>You complete the Medbot. Beep boop!</span>")
				S.name = created_name
				S.firstaid = firstaid
				S.robot_arm = robot_arm
				S.healthanalyzer = healthanalyzer
				qdel(src)
