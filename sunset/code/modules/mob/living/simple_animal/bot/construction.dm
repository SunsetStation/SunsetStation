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

//Floorbot assemblies
/obj/item/bot_assembly/floorbot
	desc = "It's a toolbox with tiles sticking out the top."
	name = "tiles and toolbox"
	icon_state = "btoolbox_tiles"
	icon = 'sunset/icons/mob/aibots.dmi'
	throwforce = 10
	created_name = "Floorbot"
	toolbox = /obj/item/storage/toolbox
	var/toolboxType = null

/obj/item/bot_assembly/floorbot/Initialize()
	. = ..()
	update_icon()

/obj/item/bot_assembly/floorbot/update_icon()
	..()
	switch(build_step)
		if(ASSEMBLY_FIRST_STEP)
			desc = initial(desc)
			name = initial(name)
			icon_state = "[toolboxType]toolbox_tiles"

		if(ASSEMBLY_SECOND_STEP)
			desc = "It's a toolbox with tiles sticking out the top and a sensor attached."
			name = "incomplete floorbot assembly"
			icon_state = "[toolboxType]toolbox_tiles_sensor"


/obj/item/storage/toolbox/attackby(obj/item/stack/tile/plasteel/T, mob/user, params)
	if(!istype(T, /obj/item/stack/tile/plasteel))
		..()
		return

	if(contents.len >= 1)
		to_chat(user, "<span class='warning'>They won't fit in, as there is already stuff inside!</span>")
		return

	if(T.use(10))
		var/obj/item/bot_assembly/floorbot/B = new
		B.toolbox = type
		if(istype(src, /obj/item/storage/toolbox/emergency))
			B.toolboxType = "r"
		else if(istype(src, /obj/item/storage/toolbox/electrical))
			B.toolboxType = "y"
		else if(istype(src, /obj/item/storage/toolbox/syndicate))
			B.toolboxType = "s"
		else if(istype(src, /obj/item/storage/toolbox/artistic))
			B.toolboxType = "g"
		else
			B.toolboxType = "b"
		update_icon()
		user.put_in_hands(B)
		to_chat(user, "<span class='notice'>You add the tiles into the empty [src.name]. They protrude from the top.</span>")
		qdel(src)
	else
		to_chat(user, "<span class='warning'>You need 10 floor tiles to start building a floorbot!</span>")
		return

/obj/item/bot_assembly/floorbot/attackby(obj/item/W, mob/user, params)
	..()
	switch(build_step)
		if(ASSEMBLY_FIRST_STEP)
			if(isprox(W))
				if(!user.temporarilyRemoveItemFromInventory(W))
					return
				to_chat(user, "<span class='notice'>You add [W] to [src].</span>")
				qdel(W)
				build_step++
				update_icon()

		if(ASSEMBLY_SECOND_STEP)
			if(istype(W, /obj/item/bodypart/l_arm/robot) || istype(W, /obj/item/bodypart/r_arm/robot))
				if(!can_finish_build(W, user))
					return
				var/mob/living/simple_animal/bot/floorbot/A = new(drop_location(), toolboxType)
				A.name = created_name
				A.robot_arm = W.type
				A.toolbox = toolbox
				to_chat(user, "<span class='notice'>You add [W] to [src]. Boop beep!</span>")
				qdel(W)
				qdel(src)

/obj/item/bot_assembly/honkbot
	icon = 'sunset/icons/mob/aibots.dmi'

/obj/item/bot_assembly/cleanbot
	icon = 'sunset/icons/mob/aibots.dmi'

/obj/item/bot_assembly/secbot
	name = "incomplete securitron assembly"
	desc = "Some sort of bizarre assembly made from a proximity sensor, helmet, and signaler."
	icon = 'sunset/icons/mob/aibots.dmi'
	icon_state = "securitron_shell_antenna"
	item_state = "helmet"
	created_name = "Securitron" //To preserve the name if it's a unique securitron I guess
	swordamt = 0 //If you're converting it into a grievousbot, how many swords have you attached
	toyswordamt = 0 //honk

/obj/item/bot_assembly/secbot/attackby(obj/item/I, mob/user, params)
	..()
	var/atom/Tsec = drop_location()
	switch(build_step)
		if(ASSEMBLY_FIRST_STEP)
			if(I.tool_behaviour == TOOL_WELDER)
				if(I.use_tool(src, user, 0, volume=40))
					add_overlay("securitron_shell_hole")
					to_chat(user, "<span class='notice'>You weld a hole in [src]!</span>")
					build_step++

			else if(I.tool_behaviour == TOOL_SCREWDRIVER) //deconstruct
				new /obj/item/assembly/signaler(Tsec)
				new /obj/item/securitron_shell(Tsec)
				to_chat(user, "<span class='notice'>You disconnect the signaler from the helmet.</span>")
				qdel(src)

		if(ASSEMBLY_SECOND_STEP)
			if(isprox(I))
				if(!user.temporarilyRemoveItemFromInventory(I))
					return
				to_chat(user, "<span class='notice'>You add [I] to [src]!</span>")
				add_overlay("securitron_shell_eye")
				name = "helmet/signaler/prox sensor assembly"
				qdel(I)
				build_step++

			else if(I.tool_behaviour == TOOL_WELDER || !ASSEMBLY_FIRST_STEP) //deconstruct
				if(I.use_tool(src, user, 0, volume=40))
					cut_overlay("securitron_shell_hole")
					to_chat(user, "<span class='notice'>You weld the hole in [src] shut!</span>")
					build_step--

		if(ASSEMBLY_THIRD_STEP)
			if((istype(I, /obj/item/bodypart/l_arm/robot)) || (istype(I, /obj/item/bodypart/r_arm/robot)))
				if(!user.temporarilyRemoveItemFromInventory(I))
					return
				to_chat(user, "<span class='notice'>You add [I] to [src]!</span>")
				name = "helmet/signaler/prox sensor/robot arm assembly"
				add_overlay("securitron_arm")
				robot_arm = I.type
				qdel(I)
				build_step++

			else if(I.tool_behaviour == TOOL_SCREWDRIVER) //deconstruct
				cut_overlay("securitron_shell_eye")
				new /obj/item/assembly/prox_sensor(Tsec)
				to_chat(user, "<span class='notice'>You detach the proximity sensor from [src].</span>")
				build_step--

		if(ASSEMBLY_FOURTH_STEP)
			if(istype(I, /obj/item/melee/baton))
				if(!can_finish_build(I, user))
					return
				to_chat(user, "<span class='notice'>You complete the Securitron! Beep boop.</span>")
				var/mob/living/simple_animal/bot/secbot/S = new(Tsec)
				S.name = created_name
				S.baton_type = I.type
				S.robot_arm = robot_arm
				qdel(I)
				qdel(src)
			if(I.tool_behaviour == TOOL_WRENCH)
				to_chat(user, "You adjust [src]'s arm slots to mount extra weapons")
				build_step ++
				return
			if(istype(I, /obj/item/toy/sword))
				if(toyswordamt < 3 && swordamt <= 0)
					if(!user.temporarilyRemoveItemFromInventory(I))
						return
					created_name = "General Beepsky"
					name = "helmet/signaler/prox sensor/robot arm/toy sword assembly"
					icon_state = "grievous_assembly"
					to_chat(user, "<span class='notice'>You superglue [I] onto one of [src]'s arm slots.</span>")
					qdel(I)
					toyswordamt ++
				else
					if(!can_finish_build(I, user))
						return
					to_chat(user, "<span class='notice'>You complete the Securitron!...Something seems a bit wrong with it..?</span>")
					var/mob/living/simple_animal/bot/secbot/grievous/toy/S = new(Tsec)
					S.name = created_name
					S.robot_arm = robot_arm
					qdel(I)
					qdel(src)

			else if(I.tool_behaviour == TOOL_SCREWDRIVER) //deconstruct
				cut_overlay("securitron_arm")
				var/obj/item/bodypart/dropped_arm = new robot_arm(Tsec)
				robot_arm = null
				to_chat(user, "<span class='notice'>You remove [dropped_arm] from [src].</span>")
				build_step--
				if(toyswordamt > 0 || toyswordamt)
					icon_state = initial(icon_state)
					to_chat(user, "<span class='notice'>The superglue binding [src]'s toy swords to its chassis snaps!</span>")
					for(var/IS in 1 to toyswordamt)
						new /obj/item/toy/sword(Tsec)

		if(ASSEMBLY_FIFTH_STEP)
			if(istype(I, /obj/item/melee/transforming/energy/sword/saber))
				if(swordamt < 3)
					if(!user.temporarilyRemoveItemFromInventory(I))
						return
					created_name = "Securitron"
					name = "shell/signaler/prox sensor/robot arm/energy sword assembly"
					icon_state = "general-secbot-assembly"
					to_chat(user, "<span class='notice'>You bolt [I] onto one of [src]'s arm slots.</span>")
					qdel(I)
					swordamt ++
				else
					if(!can_finish_build(I, user))
						return
					to_chat(user, "<span class='notice'>You complete the Securitron!...Something seems a bit wrong with it..?</span>")
					var/mob/living/simple_animal/bot/secbot/grievous/S = new(Tsec)
					S.name = created_name
					S.robot_arm = robot_arm
					qdel(I)
					qdel(src)
			else if(I.tool_behaviour == TOOL_SCREWDRIVER) //deconstruct
				build_step--
				icon_state = initial(icon_state)
				to_chat(user, "<span class='notice'>You unbolt [src]'s energy swords</span>")
				for(var/IS in 1 to swordamt)
					new /obj/item/melee/transforming/energy/sword/saber(Tsec)
