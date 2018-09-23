/obj/item/clothing/suit/armor/vest/blueshield
	name = "blueshield security armor"
	desc = "An armored vest with the badge of a Blueshield Lieutenant."
	alternate_worn_icon = 'sunset/icons/mob/suit.dmi'
	icon = 'sunset/icons/obj/clothing/suits.dmi'
	icon_state = "blueshield"
	item_state = "blueshield"

/obj/item/clothing/suit/storage/blueshield
	name = "blueshield coat"
	desc = "NT deluxe ripoff. You finally have your own coat."
	icon = 'sunset/icons/obj/clothing/suits.dmi'
	alternate_worn_icon = 'sunset/icons/mob/suit.dmi'
	icon_state = "blueshieldcoat"
	item_state = "blueshieldcoat"
	blood_overlay_type = "coat"
	body_parts_covered = CHEST|LEGS|ARMS
	allowed = list(/obj/item/gun/energy, /obj/item/reagent_containers/spray/pepper, /obj/item/ammo_box, /obj/item/ammo_casing,/obj/item/melee/baton, /obj/item/restraints/handcuffs, /obj/item/flashlight/seclite, /obj/item/melee/classic_baton)
	armor = list(melee = 25, bullet = 10, laser = 25, energy = 10, bomb = 0, bio = 0, rad = 0)
	cold_protection = CHEST|LEGS|ARMS
	heat_protection = CHEST|LEGS|ARMS

/obj/item/clothing/under/rank/blueshield
	desc = "Gold trim on space-black cloth, this uniform displays the rank of \"Lieutenant\" on the left shoulder."
	name = "\improper Blueshield Uniform"
	icon = 'sunset/icons/obj/clothing/uniform.dmi'
	alternate_worn_icon = 'sunset/icons/mob/uniform.dmi'
	icon_state = "ert_uniform"
	item_state = "bl_suit"
	item_color = "ert_uniform"
	armor = list(melee = 10, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0)

/obj/item/storage/belt/holster/blueshield
	name = "blueshield's shoulder holster"
	desc = "A holster specifically designed to carry the blueshield's weapon."
	
/obj/item/storage/belt/holster/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.max_items = 3
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.can_hold = typecacheof(list(
		/obj/item/gun/energy/e_gun/blueshield,
		/obj/item/gun/ballistic/revolver/detective,
		/obj/item/ammo_box/c38,
		/obj/item/gun/ballistic/automatic/pistol/enforcer,
		/obj/item/ammo_box/magazine/enforcer,
		))
