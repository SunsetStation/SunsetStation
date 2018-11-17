/obj/machinery/computer/cloning/scan_occupant(occupant)
	var/mob/living/carbon/human/H = occupant
	if(istype(H) && H.dna && H.dna.species && (NOSCAN in H.dna.species.species_traits))
		scantemp = "<span class='bad'>Subject has no valid, scannable biological tissue.</span>"
		playsound(src, 'sound/machines/terminal_prompt_deny.ogg', 50, 0)
		return
	return ..()
