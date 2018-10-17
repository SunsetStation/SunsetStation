/obj/machinery/computer/cloning/scan_occupant(occupant)
	var/datum/dna/dna
	if(dna && dna.species && (NOSCAN in dna.species.species_traits))
		scantemp = "<span class='bad'>Subject has no DNA, or has DNA that cannot be scanned.</span>"
		playsound(src, 'sound/machines/terminal_prompt_deny.ogg', 50, 0)
		return
	. = ..()
