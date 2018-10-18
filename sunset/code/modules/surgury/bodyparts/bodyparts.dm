/obj/item/bodypart
	var/render_like_organic = FALSE // TRUE is for when you want a BODYPART_ROBOTIC to pretend to be a BODYPART_ORGANIC.

/obj/item/bodypart/attack(mob/living/carbon/C, mob/user)
	if(ishuman(C))
		var/mob/living/carbon/human/H = C
		if(TRAIT_EASYLIMBATTACHMENT in H.dna.species.species_traits)
			if(((src.status == BODYPART_ORGANIC) && (!(TRAIT_ROBOTIC_LIMBS in H.dna.species.species_traits))) || ((src.status == BODYPART_ROBOTIC) && (TRAIT_ROBOTIC_LIMBS in H.dna.species.species_traits))) // Can't mix organic and robotic.
				if(!H.get_bodypart(body_zone) && !animal_origin)
					if(H == user)
						H.visible_message("<span class='notice'>[H] is attempting to re-attach [src]...</span>")
						do_mob(user, H, 60)
						H.visible_message("<span class='warning'>[H] jams [src] into [H.p_their()] empty socket!</span>",\
						"<span class='notice'>You force [src] into your empty socket, and it locks into place!</span>")
					else
						H.visible_message("<span class='warning'>[user] jams [src] into [H]'s empty socket!</span>",\
						"<span class='notice'>[user] forces [src] into your empty socket, and it locks into place!</span>")
					user.temporarilyRemoveItemFromInventory(src, TRUE)
					attach_limb(C)
					return
	..()

/obj/item/bodypart/heal_damage(brute, burn, only_robotic = 0, only_organic = 1, updating_health = 1)
	if(owner.dna && owner.dna.species && (TRAIT_REVIVESBYHEALING in owner.dna.species.species_traits))
		if(owner.health > 0 && !owner.hellbound)
			owner.revive(0)
			owner.cure_husk(0) // If it has TRAIT_REVIVESBYHEALING, it probably can't be cloned. No husk cure.
	. = ..()
