#define MINOR_INSANITY_PEN 5
#define MAJOR_INSANITY_PEN 10

/datum/component/mood
	var/mood = 0 //Real happiness
	var/sanity = 50 //Current sanity
	var/shown_mood //Shown happiness, this is what others can see when they try to examine you, prevents antag checking by noticing traitors are always very happy.
	var/mood_level = 5 //To track what stage of moodies they're on
	var/sanity_level = 5 //To track what stage of sanity they're on
	var/breakdowns = 0 //How many breakdowns you've had
	var/mood_modifier = 1 //Modifier to allow certain mobs to be less affected by moodlets
	var/AffectedByActiveSanityLoss = TRUE //Are we currently affected by active sanity loss?
	var/list/datum/mood_event/mood_events = list()
	var/insanity_effect = 0 //is the owner being punished for low mood? If so, how much?
	var/obj/screen/mood/screen_obj
	var/obj/screen/sanity/screen_obj_sanity
	var/datum/brain_trauma/affliction/current_affliction //Current affliction we are suffering from

/datum/component/mood/Initialize()
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE

	START_PROCESSING(SSmood, src)

	RegisterSignal(parent, COMSIG_ADD_MOOD_EVENT, .proc/add_event)
	RegisterSignal(parent, COMSIG_CLEAR_MOOD_EVENT, .proc/clear_event)
	RegisterSignal(parent, COMSIG_ENTER_AREA, .proc/check_area_mood)
	RegisterSignal(parent, COMSIG_ADJUST_SANITY, .proc/AdjustSanity)

	RegisterSignal(parent, COMSIG_MOB_HUD_CREATED, .proc/modify_hud)
	var/mob/living/owner = parent
	if(owner.hud_used)
		modify_hud()
		var/datum/hud/hud = owner.hud_used
		hud.show_hud(hud.hud_version)

/datum/component/mood/Destroy()
	STOP_PROCESSING(SSmood, src)
	unmodify_hud()
	return ..()

/datum/component/mood/proc/print_mood(mob/user)
	var/msg = "<span class='info'>*---------*\n<EM>Your current mood</EM>\n"
	msg += "<span class='notice'>My mental status: </span>" //Long term
	switch(sanity)
		if(-INFINITY to SANITY_INSANE) //Really fucked
			msg += "<span class='boldwarning'>AHAHAHAHAHAHAHAHAHAH!!</span>\n"
		if(SANITY_INSANE to SANITY_CREEPING) //Mildly fucked
			msg += "<span class='boldwarning'>I'm freaking out!!</span>\n"
		if(SANITY_CREEPING to SANITY_NEUTRAL) //Mini fucked
			msg += "<span class='warning'>I'm feeling a little bit unhinged...</span>\n"
		if(SANITY_NEUTRAL to SANITY_HARDENED) //Normal
			msg += "<span class='nicegreen'>I have felt quite decent lately.<span>\n"
		if(SANITY_HARDENED+1 to SANITY_MAXIMUM+1) //Hardened
			msg += "<span class='nicegreen'>My mind feels like a temple!<span>\n"

	msg += "<span class='notice'>My current mood: </span>" //Short term
	switch(mood_level)
		if(1)
			msg += "<span class='boldwarning'>I wish I was dead!<span>\n"
		if(2)
			msg += "<span class='boldwarning'>I feel terrible...<span>\n"
		if(3)
			msg += "<span class='boldwarning'>I feel very upset.<span>\n"
		if(4)
			msg += "<span class='boldwarning'>I'm a bit sad.<span>\n"
		if(5)
			msg += "<span class='nicegreen'>I'm alright.<span>\n"
		if(6)
			msg += "<span class='nicegreen'>I feel pretty okay.<span>\n"
		if(7)
			msg += "<span class='nicegreen'>I feel pretty good.<span>\n"
		if(8)
			msg += "<span class='nicegreen'>I feel amazing!<span>\n"
		if(9)
			msg += "<span class='nicegreen'>I love life!<span>\n"
	if(current_affliction)
		msg += "<span class='boldwarning'>current affliction: [current_affliction.name]<span>\n"
	msg += "<span class='notice'>Moodlets:\n</span>"//All moodlets
	if(mood_events.len)
		for(var/i in mood_events)
			var/datum/mood_event/event = mood_events[i]
			msg += event.description
	else
		msg += "<span class='nicegreen'>I don't have much of a reaction to anything right now.<span>\n"
	to_chat(user || parent, msg)

/datum/component/mood/proc/update_mood() //Called whenever a mood event is added or removed
	mood = 0
	shown_mood = 0
	for(var/i in mood_events)
		var/datum/mood_event/event = mood_events[i]
		mood += event.mood_change
		if(!event.hidden)
			shown_mood += event.mood_change
		mood *= mood_modifier
		shown_mood *= mood_modifier

	switch(mood)
		if(-INFINITY to MOOD_LEVEL_SAD4)
			mood_level = 1
		if(MOOD_LEVEL_SAD4 to MOOD_LEVEL_SAD3)
			mood_level = 2
		if(MOOD_LEVEL_SAD3 to MOOD_LEVEL_SAD2)
			mood_level = 3
		if(MOOD_LEVEL_SAD2 to MOOD_LEVEL_SAD1)
			mood_level = 4
		if(MOOD_LEVEL_SAD1 to MOOD_LEVEL_HAPPY1)
			mood_level = 5
		if(MOOD_LEVEL_HAPPY1 to MOOD_LEVEL_HAPPY2)
			mood_level = 6
		if(MOOD_LEVEL_HAPPY2 to MOOD_LEVEL_HAPPY3)
			mood_level = 7
		if(MOOD_LEVEL_HAPPY3 to MOOD_LEVEL_HAPPY4)
			mood_level = 8
		if(MOOD_LEVEL_HAPPY4 to INFINITY)
			mood_level = 9
	update_mood_icon()


/datum/component/mood/proc/update_mood_icon()
	var/mob/living/owner = parent
	if(!(owner.client || owner.hud_used))
		return
	screen_obj.cut_overlays()
	screen_obj.color = initial(screen_obj.color)
	//lets see if we have any special icons to show instead of the normal mood levels
	var/list/conflicting_moodies = list()
	var/highest_absolute_mood = 0
	for(var/i in mood_events) //adds overlays and sees which special icons need to vie for which one gets the icon_state
		var/datum/mood_event/event = mood_events[i]
		if(!event.special_screen_obj)
			continue
		if(!event.special_screen_replace)
			screen_obj.add_overlay(event.special_screen_obj)
		else
			conflicting_moodies += event
			var/absmood = abs(event.mood_change)
			if(absmood > highest_absolute_mood)
				highest_absolute_mood = absmood

	if(!conflicting_moodies.len) //no special icons- go to the normal icon states
		if(sanity < -25)
			screen_obj.icon_state = "mood_insane"
		else
			screen_obj.icon_state = "mood[mood_level]"
		screen_obj_sanity.icon_state = "sanity[sanity_level]"
		return

	for(var/i in conflicting_moodies)
		var/datum/mood_event/event = i
		if(abs(event.mood_change) == highest_absolute_mood)
			screen_obj.icon_state = "[event.special_screen_obj]"
			switch(mood_level)
				if(1)
					screen_obj.color = "#747690"
				if(2)
					screen_obj.color = "#f15d36"
				if(3)
					screen_obj.color = "#f38a43"
				if(4)
					screen_obj.color = "#dfa65b"
				if(5)
					screen_obj.color = "#4b96c4"
				if(6)
					screen_obj.color = "#a8d259"
				if(7)
					screen_obj.color = "#86d656"
				if(8)
					screen_obj.color = "#30dd26"
				if(9)
					screen_obj.color = "#2eeb9a"
			break

/datum/component/mood/process() //Called on SSmood process
	var/mob/living/owner = parent

	if(owner.stat == DEAD || !owner.client)
		return

	switch(mood_level)
		if(1)
			AdjustSanity(null, -1)
		if(2)
			AdjustSanity(null, -0.5)
		if(3)
			AdjustSanity(null, -0.25)
		if(4)
			AdjustSanity(null, -0.15)
		if(5)
			AdjustSanity(null, 0.2, maximum=50)
		if(6)
			AdjustSanity(null, 0.2, maximum=SANITY_HARDENED)
		if(7)
			AdjustSanity(null, 0.25, maximum=SANITY_HARDENED)
		if(8)
			AdjustSanity(null, 0.4, maximum=SANITY_MAXIMUM)
		if(9)
			AdjustSanity(null, 0.6, maximum=SANITY_MAXIMUM)

	if(owner.has_trait(TRAIT_DEPRESSION))
		if(prob(0.05))
			add_event(null, "depression", /datum/mood_event/depression)
			clear_event(null, "jolly")
	if(owner.has_trait(TRAIT_JOLLY))
		if(prob(0.05))
			add_event(null, "jolly", /datum/mood_event/jolly)
			clear_event(null, "depression")

	if(sanity <= SANITY_CREEPING)
		handle_insanity()

	HandleNutrition(owner)
	if(!ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner

	HandleHygiene(H)
	HandleDarkness(H)


/datum/component/mood/proc/AdjustSanity(datum/source, amount, minimum=-INFINITY, maximum=INFINITY)
	setSanity(sanity + (amount * get_sanity_coefficient()), minimum, maximum)

/datum/component/mood/proc/get_sanity_coefficient()
	. = 1
	if(sanity_level == 3) //If you're hardened, your sanity changes slower.
		. *= 0.5 

/datum/component/mood/proc/setSanity(amount, minimum=-INFINITY, maximum=SANITY_MAXIMUM	)
	if(amount == sanity)
		return
	// If we're out of the acceptable minimum-maximum range move back towards it in steps of 0.5
	// If the new amount would move towards the acceptable range faster then use it instead
	if(sanity < minimum && amount < sanity + 0.5)
		amount = sanity + 0.5
	else if(sanity > maximum && amount > sanity - 0.5)
		amount = sanity - 0.5
	sanity = amount

	var/mob/living/master = parent
	switch(sanity)
		if(-INFINITY to SANITY_INSANE) //Really fucked
			setInsanityEffect(MAJOR_INSANITY_PEN)
			master.add_movespeed_modifier(MOVESPEED_ID_SANITY, TRUE, 100, override=TRUE, multiplicative_slowdown=2, movetypes=(~FLYING))
			sanity_level = 7
			if(sanity <= (-50 + (-50 * breakdowns)))
				ExperienceBreakdown()
		if(SANITY_INSANE to SANITY_CREEPING) //Mildly fucked
			setInsanityEffect(MINOR_INSANITY_PEN)
			master.add_movespeed_modifier(MOVESPEED_ID_SANITY, TRUE, 100, override=TRUE, multiplicative_slowdown=1.5, movetypes=(~FLYING))
			sanity_level = 6
		if(SANITY_CREEPING to SANITY_NEUTRAL) //Mini fucked
			setInsanityEffect(0)
			master.add_movespeed_modifier(MOVESPEED_ID_SANITY, TRUE, 100, override=TRUE, multiplicative_slowdown=1, movetypes=(~FLYING))
			sanity_level = 5
		if(SANITY_NEUTRAL to SANITY_HARDENED) //Normal
			setInsanityEffect(0)
			master.remove_movespeed_modifier(MOVESPEED_ID_SANITY, TRUE)
			sanity_level = 4
		if(SANITY_HARDENED+1 to SANITY_MAXIMUM+1) //Hardened
			setInsanityEffect(0)
			master.remove_movespeed_modifier(MOVESPEED_ID_SANITY, TRUE)
			sanity_level = 3
			if(sanity >= 125 && current_affliction) //experience tranquility ebin
				ResetBreakdown()
	update_mood_icon()


/datum/component/mood/proc/ExperienceBreakdown()
	if(ishuman(parent))
		var/mob/living/carbon/human/H = parent
		H.Paralyze(100)
		H.stuttering += 5
		H.Jitter(20)
		H.visible_message("<span class='cult'>[parent] collapses, they seem to be having a breakdown!</span>", \
		"<span class='cultlarge'>[pick(GLOB.sanity_breakdown_messages)]</span>", )
		UpdateAffliction(H)
		remove_temp_moods()
		sanity = 50
		H.emote("scream")

/datum/component/mood/proc/ResetBreakdown()
	qdel(current_affliction)
	current_affliction = null
	sanity = 50
	breakdowns = 0

/datum/component/mood/proc/UpdateAffliction(var/mob/living/carbon/human/H)
	breakdowns++
	if(current_affliction) //If we have an affliction, upgrade it.
		current_affliction.upgrade(src)
	else //Otherwise, get a new one.
		var/datum/brain_trauma/affliction/temp_affliction = pick(GLOB.possible_afflictions)
		current_affliction = H.gain_trauma(temp_affliction)

/datum/component/mood/proc/AllowActiveSanityLoss()
	AffectedByActiveSanityLoss = TRUE

/datum/component/mood/proc/ActiveSanityLoss(amount)
	if(!AffectedByActiveSanityLoss)
		return
	AdjustSanity(null, -amount)

/datum/component/mood/proc/ActiveSanityGain(amount)
	AdjustSanity(null, amount)

/datum/component/mood/proc/setInsanityEffect(newval)
	if(newval == insanity_effect)
		return
	var/mob/living/master = parent
	master.crit_threshold = (master.crit_threshold - insanity_effect) + newval
	insanity_effect = newval

/datum/component/mood/proc/add_event(datum/source, category, type, param) //Category will override any events in the same category, should be unique unless the event is based on the same thing like hunger.
	var/datum/mood_event/the_event
	if(mood_events[category])
		the_event = mood_events[category]
		if(the_event.type != type)
			clear_event(null, category)
		else
			if(the_event.timeout)
				addtimer(CALLBACK(src, .proc/clear_event, null, category), the_event.timeout, TIMER_UNIQUE|TIMER_OVERRIDE)
			return 0 //Don't have to update the event.
	the_event = new type(src, param)

	mood_events[category] = the_event
	the_event.category = category
	if(the_event.horrific)
		if(ismob(parent))
			var/mob/M = parent
			M.playsound_local(null, pick(HORROR_SOUNDS), 40)
	update_mood()

	if(the_event.timeout)
		addtimer(CALLBACK(src, .proc/clear_event, null, category), the_event.timeout, TIMER_UNIQUE|TIMER_OVERRIDE)
	return the_event

/datum/component/mood/proc/clear_event(datum/source, category)
	var/datum/mood_event/event = mood_events[category]
	if(!event)
		return 0

	mood_events -= category
	qdel(event)
	update_mood()

/datum/component/mood/proc/remove_temp_moods(var/admin) //Removes all temp moods
	for(var/i in mood_events)
		var/datum/mood_event/moodlet = mood_events[i]
		if(!moodlet || !moodlet.timeout)
			continue
		mood_events -= moodlet.category
		qdel(moodlet)
		update_mood()


/datum/component/mood/proc/modify_hud(datum/source)
	var/mob/living/owner = parent
	var/datum/hud/hud = owner.hud_used
	screen_obj = new
	screen_obj_sanity = new
	hud.infodisplay += screen_obj
	hud.infodisplay += screen_obj_sanity
	RegisterSignal(hud, COMSIG_PARENT_QDELETED, .proc/unmodify_hud)
	RegisterSignal(screen_obj, COMSIG_CLICK, .proc/hud_click)

/datum/component/mood/proc/unmodify_hud(datum/source)
	if(!screen_obj)
		return
	var/mob/living/owner = parent
	var/datum/hud/hud = owner.hud_used
	if(hud && hud.infodisplay)
		hud.infodisplay -= screen_obj
		hud.infodisplay -= screen_obj_sanity
	QDEL_NULL(screen_obj)
	QDEL_NULL(screen_obj_sanity)

/datum/component/mood/proc/hud_click(datum/source, location, control, params, mob/user)
	print_mood(user)

/datum/component/mood/proc/HandleNutrition(mob/living/L)
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(isethereal(H))
			HandleCharge(H)
		if(H.has_trait(TRAIT_NOHUNGER))
			return FALSE //no mood events for nutrition
	switch(L.nutrition)
		if(NUTRITION_LEVEL_FULL to INFINITY)
			if (!L.has_trait(TRAIT_VORACIOUS))
				add_event(null, "nutrition", /datum/mood_event/fat)
			else
				add_event(null, "nutrition", /datum/mood_event/wellfed) // round and full
		if(NUTRITION_LEVEL_WELL_FED to NUTRITION_LEVEL_FULL)
			add_event(null, "nutrition", /datum/mood_event/wellfed)
		if( NUTRITION_LEVEL_FED to NUTRITION_LEVEL_WELL_FED)
			add_event(null, "nutrition", /datum/mood_event/fed)
		if(NUTRITION_LEVEL_HUNGRY to NUTRITION_LEVEL_FED)
			clear_event(null, "nutrition")
		if(NUTRITION_LEVEL_STARVING to NUTRITION_LEVEL_HUNGRY)
			add_event(null, "nutrition", /datum/mood_event/hungry)
		if(0 to NUTRITION_LEVEL_STARVING)
			add_event(null, "nutrition", /datum/mood_event/starving)

/datum/component/mood/proc/HandleCharge(mob/living/carbon/human/H)
	var/datum/species/ethereal/E = H.dna?.species
	switch(E.ethereal_charge)
		if(ETHEREAL_CHARGE_NONE to ETHEREAL_CHARGE_LOWPOWER)
			add_event(null, "charge", /datum/mood_event/decharged)
		if(ETHEREAL_CHARGE_LOWPOWER to ETHEREAL_CHARGE_NORMAL)
			add_event(null, "charge", /datum/mood_event/lowpower)
		if(ETHEREAL_CHARGE_NORMAL to ETHEREAL_CHARGE_ALMOSTFULL)
			clear_event(null, "charge")
		if(ETHEREAL_CHARGE_ALMOSTFULL to ETHEREAL_CHARGE_FULL)
			add_event(null, "charge", /datum/mood_event/charged)


/datum/component/mood/proc/HandleHygiene(mob/living/carbon/human/H)
	switch(H.hygiene)
		if(0 to HYGIENE_LEVEL_DIRTY)
			if(has_trait(TRAIT_NEAT))
				add_event(null, "neat", /datum/mood_event/dirty)
			if(has_trait(TRAIT_NEET))
				add_event(null, "NEET", /datum/mood_event/happy_neet)
			HygieneMiasma(H)
		if(HYGIENE_LEVEL_DIRTY to HYGIENE_LEVEL_NORMAL)
			if(has_trait(TRAIT_NEAT))
				clear_event(null, "neat")
			if(has_trait(TRAIT_NEET))
				clear_event(null, "NEET")
		if(HYGIENE_LEVEL_NORMAL to HYGIENE_LEVEL_CLEAN)
			if(has_trait(TRAIT_NEAT))
				add_event(null, "neat", /datum/mood_event/neat)
			if(has_trait(TRAIT_NEET))
				clear_event(null, "NEET")

/datum/component/mood/proc/HygieneMiasma(mob/living/carbon/human/H)
	// Properly stored humans shouldn't create miasma
	if(istype(H.loc, /obj/structure/closet/crate/coffin)|| istype(H.loc, /obj/structure/closet/body_bag) || istype(H.loc, /obj/structure/bodycontainer))
		return

	var/turf/T = get_turf(H)
	var/datum/gas_mixture/stank = new
	ADD_GAS(/datum/gas/miasma, stank.gases)
	stank.gases[/datum/gas/miasma][MOLES] = MIASMA_HYGIENE_MOLES
	T.assume_air(stank)
	T.air_update_turf()

/datum/component/mood/proc/check_area_mood(datum/source, var/area/A)
	if(A.mood_bonus)
		var/datum/mood_event/M = add_event(null, "area", /datum/mood_event/area)
		M.mood_change = A.mood_bonus
		M.description = A.mood_message
	else
		clear_event(null, "area")

/datum/component/mood/proc/handle_insanity()
	if(!ishuman(parent))
		return
	if(prob(4))
		var/effect = pick(1;3, 2;15, 3;2, 4;1)
		var/mob/living/carbon/human/H = parent
		switch(effect)
			if(1)
				H.playsound_local(null, pick(CREEPY_SOUNDS), 60, 1)
			if(2)
				H.overlay_fullscreen("sanity", pick(/obj/screen/fullscreen/sanity/type1,/obj/screen/fullscreen/sanity/type2,/obj/screen/fullscreen/sanity/type3))
				H.playsound_local(null, pick(HORROR_SOUNDS), 60)
				H.clear_fullscreen("sanity", 20)
			if(3)
				H.emote("scream")
				to_chat(H, "<span class='danger'>You can't keep it together anymore.</span>")
				H.vomit(0, FALSE, FALSE, 4, TRUE)
			if(4)
				to_chat(H, "<span class='danger'>You collapse from stress.</span>")
				H.Paralyze(150)

/datum/component/mood/proc/HandleDarkness(mob/living/carbon/human/H)
	if(H.dna.species.id in list("shadow", "nightmare"))
		return //we're tied with the dark, so we don't get scared of it; don't cleanse outright to avoid cheese
	var/turf/T = get_turf(H)
	if(!isturf(T))
		return
	var/lums = T.get_lumcount()
	if(lums <= 0.2)
		add_event(null, "nyctophobia", /datum/mood_event/nyctophobia)
	else
		clear_event(null, "nyctophobia")
	

#undef MINOR_INSANITY_PEN
#undef MAJOR_INSANITY_PEN
