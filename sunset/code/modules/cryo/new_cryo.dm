/obj/machinery/cryopod
	name = "cryogenic freezer"
	desc = "Suited for Humanoids, the pod is a safe place for personnel affected by the Space Sleep Disorder to get some rest."
	icon = 'sunset/icons/obj/cryogenic2.dmi'
	icon_state = "cryopod-open"
	density = TRUE
	anchored = TRUE
	state_open = TRUE

/obj/machinery/cryopod/close_machine(mob/user)
	if(!control_computer)
		find_control_computer(TRUE)
	if((isnull(user) || istype(user)) && state_open && !panel_open)
		..(user)
		var/mob/living/mob_occupant = occupant
		if(mob_occupant && mob_occupant.stat != DEAD)
			to_chat(occupant, "<span class='boldnotice'>You feel cool air surround you. You go numb as your senses turn inward.</span>")
		if(mob_occupant.client)//if they're logged in
			despawn_world_time = world.time + (time_till_despawn * 0.1) //tochange to timers
		else
			despawn_world_time = world.time + time_till_despawn //tochange
	icon_state = "cryopod"

/obj/machinery/cryopod/open_machine()
	..()
	icon_state = "cryopod-open"
	density = TRUE
	name = initial(name)

/obj/machinery/cryopod/container_resist(mob/living/user)
	visible_message("<span class='notice'>[occupant] emerges from [src]!</span>",
		"<span class='notice'>You climb out of [src]!</span>")
	open_machine()

/obj/machinery/cryopod/relaymove(mob/user)
	container_resist(user)

/obj/machinery/cryopod/proc/despawn_occupant()
	var/mob/living/mob_occupant = occupant
	if(mob_occupant.mind && mob_occupant.mind.assigned_role)
		//Handle job slot/tater cleanup.
		var/job = mob_occupant.mind.assigned_role
		SSjob.FreeRole(job)
		if(mob_occupant.mind.objectives.len)
			mob_occupant.mind.objectives.Cut()
			mob_occupant.mind.special_role = null

	// Delete them from datacore.

	var/announce_rank = null
	for(var/datum/data/record/R in GLOB.data_core.medical)
		if(R.fields["name"] == mob_occupant.real_name)
			qdel(R)
	for(var/datum/data/record/T in GLOB.data_core.security)
		if(T.fields["name"] == mob_occupant.real_name)
			qdel(T)
	for(var/datum/data/record/G in GLOB.data_core.general)
		if(G.fields["name"] == mob_occupant.real_name)
			announce_rank = G.fields["rank"]
			qdel(G)

	for(var/obj/machinery/computer/cloning/cloner in world)
		for(var/datum/data/record/R in cloner.records)
			if(R.fields["name"] == mob_occupant.real_name)
				cloner.records.Remove(R)

	if(GLOB.announcement_systems.len)
		var/obj/machinery/announcement_system/announcer = pick(GLOB.announcement_systems)
		announcer.announce("CRYOSTORAGE", mob_occupant.real_name, announce_rank, list())
		visible_message("<span class='notice'>\The [src] hums and hisses as it moves [mob_occupant.real_name] into storage.</span>")


	for(var/obj/item/W in mob_occupant.GetAllContents())
		if(W.loc.loc && (( W.loc.loc == loc ) || (W.loc.loc == control_computer)))
			continue//means we already moved whatever this thing was in
			//I'm a professional, okay
		for(var/T in preserve_items)
			if(istype(W, T))
				if(control_computer && control_computer.allow_items)
					control_computer.frozen_items += W
					mob_occupant.transferItemToLoc(W, control_computer, TRUE)
				else
					mob_occupant.transferItemToLoc(W, loc, TRUE)

	for(var/obj/item/W in mob_occupant.GetAllContents())
		qdel(W)//because we moved all items to preserve away
		//and yes, this totally deletes their bodyparts one by one, I just couldn't bother

	if(iscyborg(mob_occupant))
		var/mob/living/silicon/robot/R = occupant
		if(!istype(R)) return ..()

		R.contents -= R.mmi
		qdel(R.mmi)

	// Ghost and delete the mob.
	if(!mob_occupant.get_ghost(1))
		if(world.time < 30 * 600)//before the 30 minute mark
			mob_occupant.ghostize(0) // Players despawned too early may not re-enter the game
		else
			mob_occupant.ghostize(1)
	QDEL_NULL(occupant)
	open_machine()
	name = initial(name)