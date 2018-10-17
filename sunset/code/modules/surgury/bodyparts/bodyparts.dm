/obj/item/bodypart
	var/render_like_organic = FALSE // TRUE is for when you want a BODYPART_ROBOTIC to pretend to be a BODYPART_ORGANIC.
/obj/item/bodypart/get_limb_icon(dropped)
	icon_state = "" //to erase the default sprite, we're building the visual aspects of the bodypart through overlays alone.

	. = list()

	var/image_dir = 0
	if(dropped)
		image_dir = SOUTH
		if(dmg_overlay_type)
			if(brutestate)
				. += image('icons/mob/dam_mob.dmi', "[dmg_overlay_type]_[body_zone]_[brutestate]0", -DAMAGE_LAYER, image_dir)
			if(burnstate)
				. += image('icons/mob/dam_mob.dmi', "[dmg_overlay_type]_[body_zone]_0[burnstate]", -DAMAGE_LAYER, image_dir)

	var/image/limb = image(layer = -BODYPARTS_LAYER, dir = image_dir)
	. += limb

	if(animal_origin)
		if(status == BODYPART_ORGANIC)
			limb.icon = 'icons/mob/animal_parts.dmi'
			if(species_id == "husk")
				limb.icon_state = "[animal_origin]_husk_[body_zone]"
			else
				limb.icon_state = "[animal_origin]_[body_zone]"
		else
			limb.icon = 'icons/mob/augmentation/augments.dmi'
			limb.icon_state = "[animal_origin]_[body_zone]"
		return

	var/icon_gender = (body_gender == FEMALE) ? "f" : "m" //gender of the icon, if applicable

	if((body_zone != "head" && body_zone != "chest"))
		should_draw_gender = FALSE

	if(status == BODYPART_ORGANIC || (status == BODYPART_ROBOTIC && render_like_organic == TRUE)) // So IPC augments can be colorful without disrupting normal BODYPART_ROBOTIC render code.
		if(should_draw_greyscale)
			limb.icon = 'sunset/icons/mob/human_parts_greyscale.dmi'
			if(should_draw_gender)
				limb.icon_state = "[species_id]_[body_zone]_[icon_gender]"
			else if(use_digitigrade)
				limb.icon_state = "digitigrade_[use_digitigrade]_[body_zone]"
			else
				limb.icon_state = "[species_id]_[body_zone]"
		else
			limb.icon = 'sunset/icons/mob/human_parts.dmi'
			if(should_draw_gender)
				limb.icon_state = "[species_id]_[body_zone]_[icon_gender]"
			else
				limb.icon_state = "[species_id]_[body_zone]"

	else
		limb.icon = icon
		if(should_draw_gender)
			limb.icon_state = "[body_zone]_[icon_gender]"
		else
			limb.icon_state = "[body_zone]"
		return

	if(should_draw_greyscale)
		var/draw_color = mutation_color || species_color || (skin_tone && skintone2hex(skin_tone))
		if(draw_color)
			limb.color = "#[draw_color]"

/obj/item/bodypart/attack(mob/living/carbon/C, mob/user)
	if(ishuman(C))
		var/mob/living/carbon/human/H = C
		if(EASYLIMBATTACHMENT in H.dna.species.species_traits)
			if(((src.status == BODYPART_ORGANIC) && (!(ROBOTIC_LIMBS in H.dna.species.species_traits))) || ((src.status == BODYPART_ROBOTIC) && (ROBOTIC_LIMBS in H.dna.species.species_traits))) // Can't mix organic and robotic.
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
	if(owner.dna && owner.dna.species && (REVIVESBYHEALING in owner.dna.species.species_traits))
		if(owner.health > 0 && !owner.hellbound)
			owner.revive(0)
			owner.cure_husk(0) // If it has REVIVESBYHEALING, it probably can't be cloned. No husk cure.
	. = ..()
