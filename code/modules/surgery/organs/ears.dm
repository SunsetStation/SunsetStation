/obj/item/organ/ears
	name = "ears"
	icon_state = "ears"
	desc = "There are three parts to the ear. Inner, middle and outer. Only one of these parts should be normally visible."
	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EARS
	gender = PLURAL

	// `deaf` measures "ticks" of deafness. While > 0, the person is unable
	// to hear anything.
	var/deaf = 0

	// damage measures long term damage to the ears, if too high,
	// the person will not have either `deaf` or damage decrease
	// without external aid (earmuffs, drugs)
	//var/ear_damage = 0

	//Resistance against loud noises
	var/bang_protect = 0
	// Multiplier for both long term and short term ear damage
	var/damage_multiplier = 1

/obj/item/organ/ears/on_life()
	if(!iscarbon(owner))
		return
	var/mob/living/carbon/C = owner
	// genetic deafness prevents the body from using the ears, even if healthy
	if(C.has_trait(TRAIT_DEAF))
		deaf = max(deaf, 1)
		heal_damage(0.1)
	// if higher than ORGAN_DAMAGE_HIGH, no natural healing occurs.
	if(get_damage_perc() < ORGAN_DAMAGE_HIGH)
		heal_damage(0.05)
		deaf = max(deaf - 1, 0)

/obj/item/organ/ears/proc/restoreEars()
	deaf = 0
	set_damage(0)

	var/mob/living/carbon/C = owner

	if(iscarbon(owner) && C.has_trait(TRAIT_DEAF))
		deaf = 1

/obj/item/organ/ears/proc/adjustEarDamage(ddmg, ddeaf)//this instead of a regular take_damage, because the deafness breaks everything
	take_damage(ddmg)
	deaf = max(deaf + (ddeaf*damage_multiplier), 0)

/obj/item/organ/ears/proc/minimumDeafTicks(value)
	deaf = max(deaf, value)

/obj/item/organ/ears/invincible
	damage_multiplier = 0


/mob/proc/restoreEars()

/mob/living/carbon/restoreEars()
	var/obj/item/organ/ears/ears = getorgan(/obj/item/organ/ears)
	if(ears)
		ears.restoreEars()

/mob/proc/adjustEarDamage()

/mob/living/carbon/adjustEarDamage(ddmg, ddeaf)
	var/obj/item/organ/ears/ears = getorgan(/obj/item/organ/ears)
	if(ears)
		ears.adjustEarDamage(ddmg, ddeaf)

/mob/proc/minimumDeafTicks()

/mob/living/carbon/minimumDeafTicks(value)
	var/obj/item/organ/ears/ears = getorgan(/obj/item/organ/ears)
	if(ears)
		ears.minimumDeafTicks(value)


/obj/item/organ/ears/cat
	name = "cat ears"
	icon = 'icons/obj/clothing/hats.dmi'
	icon_state = "kitty"
	damage_multiplier = 2

/obj/item/organ/ears/cat/Insert(mob/living/carbon/human/H, special = 0, drop_if_replaced = TRUE)
	..()
	if(istype(H))
		color = H.hair_color
		H.dna.species.mutant_bodyparts |= "ears"
		H.dna.features["ears"] = "Cat"
		H.update_body()

/obj/item/organ/ears/cat/Remove(mob/living/carbon/human/H,  special = 0)
	..()
	if(istype(H))
		color = H.hair_color
		H.dna.features["ears"] = "None"
		H.dna.species.mutant_bodyparts -= "ears"
		H.update_body()

/obj/item/organ/ears/penguin
	name = "penguin ears"
	desc = "The source of a penguin's happy feet."
	var/datum/component/waddle

/obj/item/organ/ears/penguin/Insert(mob/living/carbon/human/H, special = 0, drop_if_replaced = TRUE)
	. = ..()
	if(istype(H))
		to_chat(H, "<span class='notice'>You suddenly feel like you've lost your balance.</span>")
		waddle = H.AddComponent(/datum/component/waddling)

/obj/item/organ/ears/penguin/Remove(mob/living/carbon/human/H,  special = 0)
	. = ..()
	if(istype(H))
		to_chat(H, "<span class='notice'>Your sense of balance comes back to you.</span>")
		QDEL_NULL(waddle)

/obj/item/organ/ears/bronze
	name = "tin ears"
	desc = "The robust ears of a bronze golem. "
	damage_multiplier = 0.1 //STRONK
	bang_protect = 1 //Fear me weaklings. 

/obj/item/organ/ears/robot
	name = "auditory sensors"
	icon_state = "robotic_ears"
	desc = "A pair of microphones intended to be installed in an IPC head, that grant the ability to hear."
	zone = "head"
	slot = "ears"
	gender = PLURAL
	status = ORGAN_ROBOTIC

/obj/item/organ/ears/robot/emp_act(severity)
	switch(severity)
		if(1)
			owner.Jitter(30)
			owner.Dizzy(30)
			owner.Knockdown(200)
			deaf = 30
			to_chat(owner, "<span class='warning'>Your robotic ears are ringing, uselessly.</span>")
		if(2)
			owner.Jitter(15)
			owner.Dizzy(15)
			owner.Knockdown(100)
			to_chat(owner, "<span class='warning'>Your robotic ears buzz.</span>") 
