#define LIVER_DEFAULT_TOX_TOLERANCE 3 //amount of toxins the liver can filter out
#define LIVER_DEFAULT_TOX_LETHALITY 0.01 //lower values lower how harmful toxins are to the liver

/obj/item/organ/liver
	name = "liver"
	icon_state = "liver"
	w_class = WEIGHT_CLASS_NORMAL
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_LIVER
	desc = "Pairing suggestion: chianti and fava beans."
	var/alcohol_tolerance = ALCOHOL_RATE//affects how much damage the liver takes from alcohol
	var/failing //is this liver failing?
	var/toxTolerance = LIVER_DEFAULT_TOX_TOLERANCE//maximum amount of toxins the liver can just shrug off
	var/toxLethality = LIVER_DEFAULT_TOX_LETHALITY//affects how much damage toxins do to the liver
	var/filterToxins = TRUE //whether to filter toxins

#define HAS_SILENT_TOXIN 0 //don't provide a feedback message if this is the only toxin present
#define HAS_NO_TOXIN 1
#define HAS_PAINFUL_TOXIN 2

/obj/item/organ/liver/damage_effect_check()
	if(get_damage_perc() > ORGAN_DAMAGE_LOW)
		return TRUE

/obj/item/organ/liver/damage_effect()
	if(!owner)
		return
	if(!iscarbon(owner))
		return
	var/dealt_damage = FALSE
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		if(TRAIT_TOXINLOVER in H.dna.species.species_traits)
			owner.adjustToxLoss(-8)
			dealt_damage = TRUE
	if(!dealt_damage)
		owner.adjustToxLoss(8)


/obj/item/organ/liver/on_life()

	..()
	var/mob/living/carbon/C = owner

	//slowyly heal liver damage
	heal_damage(0.1)

	if(istype(C))
		if(!failing)//can't process reagents with a failing liver
			var/provide_pain_message = HAS_NO_TOXIN
			if(filterToxins && !owner.has_trait(TRAIT_TOXINLOVER))
				//handle liver toxin filtration
				for(var/I in C.reagents.reagent_list)
					var/datum/reagent/pickedreagent = I
					if(istype(pickedreagent, /datum/reagent/toxin))
						var/datum/reagent/toxin/found_toxin = pickedreagent
						var/thisamount = C.reagents.get_reagent_amount(initial(found_toxin.id))
						if (thisamount <= toxTolerance && thisamount)
							C.reagents.remove_reagent(initial(found_toxin.id), 1)
						else
							take_damage(thisamount * toxLethality)
							if(provide_pain_message != HAS_PAINFUL_TOXIN)
								provide_pain_message = found_toxin.silent_toxin ? HAS_SILENT_TOXIN : HAS_PAINFUL_TOXIN
			C.reagents.metabolize(C, can_overdose=TRUE)//metabolize reagents

#undef HAS_SILENT_TOXIN
#undef HAS_NO_TOXIN
#undef HAS_PAINFUL_TOXIN

/obj/item/organ/liver/prepare_eat()
	var/obj/S = ..()
	S.reagents.add_reagent("iron", 5)
	return S

/obj/item/organ/liver/fly
	name = "insectoid liver"
	icon_state = "liver-x" //xenomorph liver? It's just a black liver so it fits.
	desc = "A mutant liver designed to handle the unique diet of a flyperson."
	alcohol_tolerance = 0.007 //flies eat vomit, so a lower alcohol tolerance is perfect!

/obj/item/organ/liver/plasmaman
	name = "reagent processing crystal"
	icon_state = "liver-p"
	desc = "A large crystal that is somehow capable of metabolizing chemicals, these are found in plasmamen."

/obj/item/organ/liver/alien
	name = "alien liver" // doesnt matter for actual aliens because they dont take toxin damage
	icon_state = "liver-x" // Same sprite as fly-person liver.
	desc = "A liver that used to belong to a killer alien, who knows what it used to eat."
	toxLethality = LIVER_DEFAULT_TOX_LETHALITY * 2.5 // rejects its owner early after too much punishment
	toxTolerance = 15 // complete toxin immunity like xenos have would be too powerful

/obj/item/organ/liver/cybernetic
	name = "cybernetic liver"
	icon_state = "liver-c"
	desc = "An electronic device designed to mimic the functions of a human liver. Handles toxins slightly better than an organic liver."
	synthetic = TRUE
	max_integrity = 110
	toxTolerance = 3.3
	toxLethality = 0.009

/obj/item/organ/liver/cybernetic/upgraded
	name = "upgraded cybernetic liver"
	icon_state = "liver-c-u"
	desc = "An upgraded version of the cybernetic liver, designed to improve further upon organic livers. It is resistant to alcohol poisoning and is very robust at filtering toxins."
	alcohol_tolerance = 0.001
	//maxHealth = 200 //double the health of a normal liver
	toxTolerance = 15 //can shrug off up to 15u of toxins
	toxLethality = 0.008 //20% less damage than a normal liver
	max_integrity = 200 //double the health of a normal liver

/obj/item/organ/liver/cybernetic/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	switch(severity)
		if(1)
			take_damage(100)
		if(2)
			take_damage(50)

/obj/item/organ/liver/cybernetic/upgraded/ipc
	name = "substance processor"
	icon_state = "substance_processor"
	attack_verb = list("processed")
	desc = "A machine component, installed in the chest. This grants the Machine the ability to process chemicals that enter its systems."
	alcohol_tolerance = 0
	toxTolerance = -1
	toxLethality = 0
	status = ORGAN_ROBOTIC

/obj/item/organ/liver/cybernetic/upgraded/ipc/emp_act(severity)
	to_chat(owner, "<span class='warning'>Alert: Your Substance Processor has been damaged. Replace as soon as possible.</span>")

