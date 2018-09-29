/obj/structure/closet/secure_closet/blueshield
	icon = 'sunset/icons/obj/closet.dmi'
	name = "\proper blueshield's locker"
	req_access = list(ACCESS_BLUESHIELD)
	icon_state = "blueshield"

/obj/structure/closet/secure_closet/blueshield/PopulateContents()
	..()
	new	/obj/item/storage/firstaid/regular(src)
	new /obj/item/storage/belt/security(src)
	new /obj/item/grenade/flashbang(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/melee/baton/loaded(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	new /obj/item/clothing/suit/armor/vest/blueshield(src)
	new /obj/item/clothing/suit/storage/blueshield(src)
	new /obj/item/storage/belt/holster/blueshield(src)
	new /obj/item/clothing/shoes/jackboots(src)
