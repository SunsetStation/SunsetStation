/mob/living/carbon/human/become_husk(source)
	if(istype(dna.species) && (NOHUSK in dna.species.species_traits))
		cure_husk()
		return
	return ..()