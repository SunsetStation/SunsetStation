//Floorbot
/mob/living/simple_animal/bot/floorbot
	icon = 'sunset/icons/mob/aibots.dmi'
	icon_state = "bfloorbot0"
	var/toolboxType = "b"

/mob/living/simple_animal/bot/floorbot/Initialize(toolboxused)
	. = ..()
	var/datum/job/engineer/J = new/datum/job/engineer
	access_card.access += J.get_access()
	prev_access = access_card.access
	toolboxType = toolboxused
	update_icon()

/mob/living/simple_animal/bot/floorbot/repair(turf/target_turf)

	if(isspaceturf(target_turf))
		 //Must be a hull breach or in line mode to continue.
		if(!is_hull_breach(target_turf) && !targetdirection)
			target = null
			return
	else if(!isfloorturf(target_turf))
		return
	if(isspaceturf(target_turf)) //If we are fixing an area not part of pure space, it is
		anchored = TRUE
		icon_state = "[toolboxType]floorbot-c"
		visible_message("<span class='notice'>[targetdirection ? "[src] begins installing a bridge plating." : "[src] begins to repair the hole."] </span>")
		mode = BOT_REPAIRING
		sleep(50)
		if(mode == BOT_REPAIRING && src.loc == target_turf)
			if(autotile) //Build the floor and include a tile.
				target_turf.PlaceOnTop(/turf/open/floor/plasteel)
			else //Build a hull plating without a floor tile.
				target_turf.PlaceOnTop(/turf/open/floor/plating)

	else
		var/turf/open/floor/F = target_turf

		if(F.type != initial(tiletype.turf_type) && (F.broken || F.burnt || isplatingturf(F)) || F.type == (initial(tiletype.turf_type) && (F.broken || F.burnt)))
			anchored = TRUE
			icon_state = "[toolboxType]floorbot-c"
			mode = BOT_REPAIRING
			visible_message("<span class='notice'>[src] begins repairing the floor.</span>")
			sleep(50)
			if(mode == BOT_REPAIRING && F && src.loc == F)
				F.broken = 0
				F.burnt = 0
				F.PlaceOnTop(/turf/open/floor/plasteel)

		if(replacetiles && F.type != initial(tiletype.turf_type) && specialtiles && !isplatingturf(F))
			anchored = TRUE
			icon_state = "[toolboxType]floorbot-c"
			mode = BOT_REPAIRING
			visible_message("<span class='notice'>[src] begins replacing the floor tiles.</span>")
			sleep(50)
			if(mode == BOT_REPAIRING && F && src.loc == F)
				F.broken = 0
				F.burnt = 0
				F.PlaceOnTop(initial(tiletype.turf_type))
				specialtiles -= 1
				if(specialtiles == 0)
					speak("Requesting refill of custom floortiles to continue replacing.")
	mode = BOT_IDLE
	update_icon()
	anchored = FALSE
	target = null

/mob/living/simple_animal/bot/floorbot/update_icon()
		icon_state = "[toolboxType]floorbot[on]"

