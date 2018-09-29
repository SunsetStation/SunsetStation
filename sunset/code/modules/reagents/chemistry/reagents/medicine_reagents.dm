/datum/reagent/medicine/charcoal
	process_flags = ORGANIC

/datum/reagent/medicine/system_cleaner
	name = "System Cleaner"
	id = "system_cleaner"
	description = "Neutralizes harmful chemical compounds inside synthetic systems."
	reagent_state = LIQUID
	color = "#F1C40F"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	process_flags = SYNTHETIC

/datum/reagent/medicine/system_cleaner/on_mob_life(mob/living/M)
	M.adjustToxLoss(-2*REM, 0)
	. = 1
	for(var/datum/reagent/R in M.reagents.reagent_list)
		if(R != src)
			M.reagents.remove_reagent(R.id,1)
	..()

/datum/reagent/medicine/liquid_solder
	name = "Liquid Solder"
	id = "liquid_solder"
	description = "Repairs brain damage in synthetics."
	color = "#727272"
	taste_description = "metallic"
	process_flags = SYNTHETIC

/datum/reagent/medicine/liquid_solder/on_mob_life(mob/living/M)
	M.adjustBrainLoss(-3*REM)
	..()

/datum/reagent/medicine/syndicate_nanites //Used exclusively by Syndicate medical cyborgs
	process_flags = ORGANIC | SYNTHETIC
	
