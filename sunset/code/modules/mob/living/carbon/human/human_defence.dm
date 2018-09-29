/mob/living/carbon/human/attacked_by(obj/item/I, mob/living/user)
	. = .. ()
	var/obj/item/bodypart/affecting
	if(affecting)
		if(I.force && I.damtype != STAMINA && affecting.status == BODYPART_ROBOTIC) // Bodpart_robotic sparks when hit, but only when it does real damage
			if(I.force >= 5)
				do_sparks(1, FALSE, loc)
				if(prob(25))
					new /obj/effect/decal/cleanable/oil(loc)


/mob/living/carbon/human/emp_act(severity)
	var/informed = FALSE
	for(var/obj/item/bodypart/L in src.bodyparts)
		if(L.status == BODYPART_ROBOTIC)
			if(!informed)
				to_chat(src, "<span class='userdanger'>You feel a sharp pain as your robotic limbs overload.</span>")
				informed = TRUE
			switch(severity)
				if(1)
					L.receive_damage(0,10)
					Stun(200)
				if(2)
					L.receive_damage(0,5)
					Stun(100)
			if((TRAIT_EASYDISMEMBER in L.owner.dna.species.species_traits) && L.body_zone != "chest")
				if(prob(20))
					L.dismember(BRUTE)
	..()
