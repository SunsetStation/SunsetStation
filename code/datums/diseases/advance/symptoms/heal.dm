/datum/symptom/heal
	name = "Basic Healing (does nothing)" //warning for adminspawn viruses
	desc = "You should not be seeing this."
	stealth = 1
	resistance = -4
	stage_speed = -4
	transmittable = -4
	level = 0 //not obtainable
	base_message_chance = 20 //here used for the overlays
	symptom_delay_min = 1
	symptom_delay_max = 1
	var/hide_healing = FALSE
	threshold_desc = "<b>Stage Speed 6:</b> Doubles healing speed.<br>\
					  <b>Stage Speed 11:</b> Triples healing speed.<br>\
					  <b>Stealth 4:</b> Healing will no longer be visible to onlookers."

/datum/symptom/heal/Start(datum/disease/advance/A)
	..()
	if(A.properties["stealth"] >= 4) //invisible healing
		hide_healing = TRUE
	if(A.properties["stage_rate"] >= 6) //stronger healing
		power = 2
	if(A.properties["stage_rate"] >= 11) //even stronger healing
		power = 3

/datum/symptom/heal/Activate(datum/disease/advance/A)
	if(!..())
		return
	var/mob/living/M = A.affected_mob
	switch(A.stage)
		if(4, 5)
			var/effectiveness = CanHeal(A)
			if(!effectiveness)
				if(passive_message && prob(2) && passive_message_condition(M))
					to_chat(M, passive_message)
				return
			else
				Heal(M, A, effectiveness)
	return

/datum/symptom/heal/proc/CanHeal(datum/disease/advance/A)
	return power

/datum/symptom/heal/proc/Heal(mob/living/M, datum/disease/advance/A, actual_power)
	return TRUE

/datum/symptom/heal/proc/passive_message_condition(mob/living/M)
	return TRUE


/*
//////////////////////////////////////

Toxin Filter

	Little bit hidden.
	Lowers resistance tremendously.
	Decreases stage speed tremendously.
	Decreases transmittablity temrendously.
	Fatal Level.

Bonus
	Heals toxins in the affected mob's blood stream.

//////////////////////////////////////
*/

/datum/symptom/heal/toxin
	name = "Toxic Filter"
	desc = "The virus synthesizes regenerative chemicals in the bloodstream, repairing damage caused by toxins."
	stealth = 1
	resistance = -4
	stage_speed = -4
	transmittable = -4
	level = 6

/datum/symptom/heal/toxin/Heal(mob/living/M, datum/disease/advance/A)
	var/heal_amt = 1 * power
	if(M.toxloss > 0 && prob(base_message_chance) && !hide_healing)
		new /obj/effect/temp_visual/heal(get_turf(M), "#66FF99")
	M.adjustToxLoss(-heal_amt)
	return 1


/*
//////////////////////////////////////

Toxolysis

	No Stealth
	Lowers resistance a bit
	Increased stage speed 
	Decreases transmittablity a bit.
	Fatal Level.

Bonus
	Increases chem removal speed
	Consumed chems also nourishes host

Items to consider 
	TG is going with balancing viro with food. Will get input if we want to head this way before moving forward
	Also need to test for potenial for abuse with cure dodging 

//////////////////////////////////////
*/
/datum/symptom/heal/chem
	name = "Toxolysis"
	stealth = 0
	resistance = -2
	stage_speed = 2
	transmittable = -2
	level = 7
	var/food_conversion = FALSE
	desc = "The virus rapidly breaks down any foreign chemicals in the bloodstream."
	threshold_desc = "<b>Resistance 7:</b> Increases chem removal speed.<br>\
					  <b>Stage Speed 6:</b> Consumed chemicals nourish the host."

/datum/symptom/heal/chem/Start(datum/disease/advance/A)
	if(!..())
		return
	if(A.properties["stage_rate"] >= 6)
		food_conversion = TRUE
	if(A.properties["resistance"] >= 7)
		power = 2

/datum/symptom/heal/chem/Heal(mob/living/M, datum/disease/advance/A, actual_power)
	for(var/datum/reagent/R in M.reagents.reagent_list) //Not just toxins!
		M.reagents.remove_reagent(R.id, actual_power)
		if(food_conversion)
			M.nutrition += 0.3
		if(prob(2))
			to_chat(M, "<span class='notice'>You feel a mild warmth as your blood purifies itself.</span>")
	return 1


/datum/symptom/heal/metabolism
	name = "Metabolic Boost"
	stealth = -1
	resistance = -2
	stage_speed = 2
	transmittable = 1
	level = 7
	var/triple_metabolism = FALSE
	var/reduced_hunger = FALSE
	desc = "The virus causes the host's metabolism to accelerate rapidly, making them process chemicals twice as fast,\
	 but also causing increased hunger."
	threshold_desc = "<b>Stealth 3:</b> Reduces hunger rate.<br>\
					  <b>Stage Speed 10:</b> Chemical metabolization is tripled instead of doubled."

/datum/symptom/heal/metabolism/Start(datum/disease/advance/A)
	if(!..())
		return
	if(A.properties["stage_rate"] >= 10)
		triple_metabolism = TRUE
	if(A.properties["stealth"] >= 3)
		reduced_hunger = TRUE

/datum/symptom/heal/metabolism/Heal(mob/living/carbon/C, datum/disease/advance/A, actual_power)
	if(!istype(C))
		return
	C.reagents.metabolize(C, can_overdose=TRUE) //this works even without a liver; it's intentional since the virus is metabolizing by itself
	if(triple_metabolism)
		C.reagents.metabolize(C, can_overdose=TRUE)
	C.overeatduration = max(C.overeatduration - 2, 0)
	var/lost_nutrition = 9 - (reduced_hunger * 5)
	C.nutrition = max(C.nutrition - (lost_nutrition * HUNGER_FACTOR), 0) //Hunger depletes at 10x the normal speed
	if(prob(2))
		to_chat(C, "<span class='notice'>You feel an odd gurgle in your stomach, as if it was working much faster than normal.</span>")
	return 1

/*
//////////////////////////////////////

Regeneration

	Little bit hidden.
	Lowers resistance tremendously.
	Decreases stage speed tremendously.
	Decreases transmittablity temrendously.
	Fatal Level.

Bonus
	Heals brute damage slowly over time.

//////////////////////////////////////
*/

/datum/symptom/heal/brute

	name = "Regeneration"
	desc = "The virus stimulates the regenerative process in the host, causing faster wound healing."
	stealth = 1
	resistance = -4
	stage_speed = -4
	transmittable = -4
	level = 6

/datum/symptom/heal/brute/Heal(mob/living/carbon/M, datum/disease/advance/A)
	var/heal_amt = 2 * power

	var/list/parts = M.get_damaged_bodyparts(1,1) //1,1 because it needs inputs.

	if(!parts.len)
		return

	for(var/obj/item/bodypart/L in parts)
		if(L.heal_damage(heal_amt/parts.len, 0))
			M.update_damage_overlays()

	if(prob(base_message_chance) && !hide_healing)
		new /obj/effect/temp_visual/heal(get_turf(M), "#FF3333")

	return 1

/*
//////////////////////////////////////

Flesh Mending

	No resistance change.
	Decreases stage speed.
	Decreases transmittablity.
	Fatal Level.

Bonus
	Heals brute damage over time. Turns cloneloss into burn damage.

//////////////////////////////////////
*/

/datum/symptom/heal/brute/plus

	name = "Flesh Mending"
	desc = "The virus rapidly mutates into body cells, effectively allowing it to quickly fix the host's wounds."
	stealth = 0
	resistance = 0
	stage_speed = -2
	transmittable = -2
	level = 8

/datum/symptom/heal/brute/plus/Heal(mob/living/carbon/M, datum/disease/advance/A)
	var/heal_amt = 4 * power

	var/list/parts = M.get_damaged_bodyparts(1,1) //1,1 because it needs inputs.

	if(M.getCloneLoss() > 0)
		M.adjustCloneLoss(-1)
		M.take_bodypart_damage(0, 1) //Deals BURN damage, which is not cured by this symptom
		if(!hide_healing)
			new /obj/effect/temp_visual/heal(get_turf(M), "#33FFCC")

	if(!parts.len)
		return

	for(var/obj/item/bodypart/L in parts)
		if(L.heal_damage(heal_amt/parts.len, 0))
			M.update_damage_overlays()

	if(prob(base_message_chance) && !hide_healing)
		new /obj/effect/temp_visual/heal(get_turf(M), "#CC1100")

	return 1
/*

Regenerative Coma

	No Stealth 
	Bit of resistance 
	Slows stage speed considerably
	Slows transmission rate

Bonus: 
	Gives deathrattle when in coma 
	Increases healing speed
*/

/datum/symptom/heal/coma
	name = "Regenerative Coma"
	desc = "The virus causes the host to fall into a death-like coma when severely damaged, then rapidly fixes the damage."
	stealth = 0
	resistance = 2
	stage_speed = -3
	transmittable = -2
	level = 8
	passive_message = "<span class='notice'>The pain from your wounds makes you feel oddly sleepy...</span>"
	var/deathgasp = FALSE
	var/active_coma = FALSE //to prevent multiple coma procs
	threshold_desc = "<b>Stealth 2:</b> Host appears to die when falling into a coma.<br>\
					  <b>Stage Speed 7:</b> Increases healing speed."

/datum/symptom/heal/coma/Start(datum/disease/advance/A)
	if(!..())
		return
	if(A.properties["stage_rate"] >= 7)
		power = 1.5
	if(A.properties["stealth"] >= 2)
		deathgasp = TRUE

/datum/symptom/heal/coma/CanHeal(datum/disease/advance/A)
	var/mob/living/M = A.affected_mob
	if(M.has_trait(TRAIT_DEATHCOMA))
		return power
	else if(M.IsUnconscious() || M.stat == UNCONSCIOUS)
		return power * 0.9
	else if(M.stat == SOFT_CRIT)
		return power * 0.5
	else if(M.IsSleeping())
		return power * 0.25
	else if(M.getBruteLoss() + M.getFireLoss() >= 70 && !active_coma)
		to_chat(M, "<span class='warning'>You feel yourself slip into a regenerative coma...</span>")
		active_coma = TRUE
		addtimer(CALLBACK(src, .proc/coma, M), 60)

/datum/symptom/heal/coma/proc/coma(mob/living/M)
	if(deathgasp)
		M.emote("deathgasp")
	M.fakedeath("regenerative_coma")
	M.update_stat()
	M.update_canmove()
	addtimer(CALLBACK(src, .proc/uncoma, M), 300)

/datum/symptom/heal/coma/proc/uncoma(mob/living/M)
	if(!active_coma)
		return
	active_coma = FALSE
	M.cure_fakedeath("regenerative_coma")
	M.update_stat()
	M.update_canmove()

/datum/symptom/heal/coma/Heal(mob/living/carbon/M, datum/disease/advance/A, actual_power)
	var/heal_amt = 4 * actual_power

	var/list/parts = M.get_damaged_bodyparts(1,1)

	if(!parts.len)
		return

	for(var/obj/item/bodypart/L in parts)
		if(L.heal_damage(heal_amt/parts.len, heal_amt/parts.len))
			M.update_damage_overlays()

	if(active_coma && M.getBruteLoss() + M.getFireLoss() == 0)
		uncoma(M)

	return 1

/datum/symptom/heal/coma/passive_message_condition(mob/living/M)
	if((M.getBruteLoss() + M.getFireLoss()) > 30)
		return TRUE
	return FALSE

/*
//////////////////////////////////////

Tissue Regrowth

	Little bit hidden.
	Lowers resistance tremendously.
	Decreases stage speed tremendously.
	Decreases transmittablity temrendously.
	Fatal Level.

Bonus
	Heals burn damage slowly over time.

//////////////////////////////////////
*/

/datum/symptom/heal/burn

	name = "Tissue Regrowth"
	desc = "The virus recycles dead and burnt tissues, speeding up the healing of damage caused by burns."
	stealth = 1
	resistance = -4
	stage_speed = -4
	transmittable = -4
	level = 6

/datum/symptom/heal/burn/Heal(mob/living/carbon/M, datum/disease/advance/A)
	var/heal_amt = 2 * power

	var/list/parts = M.get_damaged_bodyparts(1,1) //1,1 because it needs inputs.

	if(!parts.len)
		return

	for(var/obj/item/bodypart/L in parts)
		if(L.heal_damage(0, heal_amt/parts.len))
			M.update_damage_overlays()

	if(prob(base_message_chance) && !hide_healing)
		new /obj/effect/temp_visual/heal(get_turf(M), "#FF9933")
	return 1


/*
//////////////////////////////////////

Temperature Adaptation

	No resistance change.
	Decreases stage speed.
	Decreases transmittablity.
	Fatal Level.

Bonus
	Heals burn damage over time, and helps stabilize body temperature.

//////////////////////////////////////
*/

/datum/symptom/heal/burn/plus

	name = "Temperature Adaptation"
	desc = "The virus quickly balances body heat, while also replacing tissues damaged by external sources."
	stealth = 0
	resistance = 0
	stage_speed = -2
	transmittable = -2
	level = 8

/datum/symptom/heal/burn/plus/Heal(mob/living/carbon/M, datum/disease/advance/A)
	var/heal_amt = 4 * power

	var/list/parts = M.get_damaged_bodyparts(1,1) //1,1 because it needs inputs.

	if(M.bodytemperature > 310)
		M.bodytemperature = max(310, M.bodytemperature - (10 * heal_amt * TEMPERATURE_DAMAGE_COEFFICIENT))
	else if(M.bodytemperature < 311)
		M.bodytemperature = min(310, M.bodytemperature + (10 * heal_amt * TEMPERATURE_DAMAGE_COEFFICIENT))

	if(!parts.len)
		return

	for(var/obj/item/bodypart/L in parts)
		if(L.heal_damage(0, heal_amt/parts.len))
			M.update_damage_overlays()

	if(prob(base_message_chance) && !hide_healing)
		new /obj/effect/temp_visual/heal(get_turf(M), "#CC6600")
	return 1

/*
//////////////////////////////////////

	DNA Restoration

	Not well hidden.
	Lowers resistance minorly.
	Does not affect stage speed.
	Decreases transmittablity greatly.
	Very high level.

Bonus
	Heals brain damage, treats radiation, cleans SE of non-power mutations.

//////////////////////////////////////
*/


/datum/symptom/heal/dna

	name = "Deoxyribonucleic Acid Restoration"
	desc = "The virus repairs the host's genome, purging negative mutations."
	stealth = -1
	resistance = -1
	stage_speed = 0
	transmittable = -3
	level = 5
	symptom_delay_min = 3
	symptom_delay_max = 8
	threshold_desc = "<b>Stage Speed 6:</b> Additionally heals brain damage.<br>\
					  <b>Stage Speed 11:</b> Increases brain damage healing."

/datum/symptom/heal/dna/Heal(mob/living/carbon/M, datum/disease/advance/A)
	var/amt_healed = 2 * (power - 1)
	M.adjustBrainLoss(-amt_healed)
	//Non-power mutations, excluding race, so the virus does not force monkey -> human transformations.
	var/list/unclean_mutations = (GLOB.not_good_mutations|GLOB.bad_mutations) - GLOB.mutations_list[RACEMUT]
	M.dna.remove_mutation_group(unclean_mutations)
	M.radiation = max(M.radiation - (2 * amt_healed), 0)
	return 1

