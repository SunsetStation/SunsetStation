/obj/item/clothing
	var/list/species_restricted = null //Only these species can wear this kit.


	//BS12: Species-restricted clothing check.
/obj/item/clothing/mob_can_equip(mob/M, slot)

		//if we can't equip the item anyway, don't bother with species_restricted (also cuts down on spam)
	if(!..())
		return FALSE

		// Skip species restriction checks on non-equipment slots
	if(slot in list(SLOT_IN_BACKPACK, SLOT_L_STORE, SLOT_R_STORE))
		return TRUE

	if(species_restricted && ishuman(M))

		var/wearable = null
		var/exclusive = null
		var/mob/living/carbon/human/H = M

		if("exclude" in species_restricted)
			exclusive = TRUE

		if(H.dna.species)
			if(exclusive)
				if(!(H.dna.species.name in species_restricted))
					wearable = TRUE
			else
				if(H.dna.species.name in species_restricted)
					wearable = TRUE

			if(!wearable)
				to_chat(M, "<span class='warning'>Your species cannot wear [src].</span>")
				return FALSE

	return TRUE

/obj/item/clothing/proc/refit_for_species(var/target_species)
		//Set species_restricted list
	switch(target_species)
		if("Human")//humanoid bodytypes
			species_restricted = list("exclude","Unathi","Ash Walker", "Ethari")
		else
			species_restricted = list(target_species)

		//Set icon
	if(sprite_sheets && (target_species in sprite_sheets))
		icon_override = sprite_sheets[target_species]
	else
		icon_override = initial(icon_override)

	if(sprite_sheets_obj && (target_species in sprite_sheets_obj))
		icon = sprite_sheets_obj[target_species]
	else
		icon = initial(icon)

/obj/item/clothing/gloves
	species_fit = list("Vox Outcast")
	sprite_sheets = list("Vox Outcast" = 'sunset/icons/mob/species/vox/gloves.dmi')


/obj/item/clothing/head
	species_fit = list("Vox Outcast")
	sprite_sheets = list(
		"Vox Outcast" = 'sunset/icons/mob/species/vox/head.dmi'
		)


/obj/item/clothing/mask
	species_fit = list("Vox Outcast")
	sprite_sheets = list(
		"Vox Outcast" = 'sunset/icons/mob/species/vox/mask.dmi'
		)


/obj/item/clothing/shoes
	species_fit = list("Vox Outcast")
	sprite_sheets = list(
		"Vox Outcast" = 'sunset/icons/mob/species/vox/shoes.dmi'
		)


/obj/item/clothing/suit
	species_fit = list("Vox Outcast")
	sprite_sheets = list(
		"Vox Outcast" = 'sunset/icons/mob/species/vox/suit.dmi'
		)


/obj/item/clothing/head/helmet/space
	species_fit = list("Vox Outcast")
	sprite_sheets = list(
		"Vox Outcast" = 'sunset/icons/mob/species/vox/helmet.dmi'
		)


/obj/item/clothing/suit/space
	species_fit = list("Vox Outcast")
	sprite_sheets = list(
		"Vox Outcast" = 'sunset/icons/mob/species/vox/suit.dmi'
		)

/obj/item/clothing/under
	species_fit = list("Vox Outcast")
	sprite_sheets = list(
		"Vox Outcast" = 'sunset/icons/mob/species/vox/uniform.dmi'
		)

/obj/item/clothing/under/attack_hand(mob/user)
	if(attached_accessory && ispath(attached_accessory.pocket_storage_component_path) && loc == user)
		attached_accessory.attack_hand(user)
		return
	..()
