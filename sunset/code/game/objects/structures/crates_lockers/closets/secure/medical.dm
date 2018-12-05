/obj/structure/closet/secure_closet/chemistry
	name = "Chemist locker"
	desc = "Equipment locker for chemists."
	icon_door = "chemical"
	req_access = list(ACCESS_CHEMISTRY)

/obj/structure/closet/secure_closet/chemistry/PopulateContents() //Contains equipment for two chemists per locker
	..()
	new /obj/item/clothing/suit/toggle/labcoat/chemist(src)
	new /obj/item/clothing/suit/toggle/labcoat/chemist(src)
	new /obj/item/clothing/under/rank/chemist(src)
	new /obj/item/clothing/under/rank/chemist(src)
	new /obj/item/clothing/shoes/sneakers/white(src)
	new /obj/item/clothing/shoes/sneakers/white(src)
	new /obj/item/radio/headset/headset_med(src)
	new /obj/item/radio/headset/headset_med(src)
	new /obj/item/storage/bag/chemistry(src)
	new /obj/item/storage/bag/chemistry(src)
	new /obj/item/storage/backpack/chemistry(src)
	new /obj/item/storage/backpack/satchel/chem(src)

/obj/structure/closet/secure_closet/genetics
	name = "Genetics Locker"
	req_access = list(ACCESS_GENETICS)
	icon_state = "med_secure"

/obj/structure/closet/secure_closet/genetics/PopulateContents() //Contains equipment for two geneticists per locker.
	..()
	new /obj/item/radio/headset/headset_med(src)
	new /obj/item/radio/headset/headset_med(src)
	new /obj/item/clothing/suit/toggle/labcoat/genetics(src)
	new /obj/item/clothing/suit/toggle/labcoat/genetics(src)
	new /obj/item/clothing/under/rank/geneticist(src)
	new /obj/item/clothing/under/rank/geneticist(src)
	new /obj/item/clothing/shoes/sneakers/white(src)
	new /obj/item/clothing/shoes/sneakers/white(src)
	new /obj/item/storage/box/bodybags(src)
	new /obj/item/storage/box/rxglasses(src)
	new /obj/item/storage/backpack/genetics(src)
	new /obj/item/storage/backpack/satchel/gen(src)

/obj/structure/closet/secure_closet/virology
	icon = 'sunset/icons/obj/closet.dmi'
	name = "Virologist Locker"
	req_access = list(ACCESS_VIROLOGY)
	icon_state = "viro_secure"

/obj/structure/closet/secure_closet/virology/PopulateContents()
	..()
	new /obj/item/radio/headset/headset_med(src)
	new /obj/item/radio/headset/headset_med(src)
	new /obj/item/clothing/shoes/sneakers/white(src)
	new /obj/item/clothing/shoes/sneakers/white(src)
	new /obj/item/storage/backpack/virology(src)
	new /obj/item/storage/backpack/satchel/vir(src)
	new /obj/item/clothing/suit/toggle/labcoat/virologist
	new /obj/item/clothing/suit/toggle/labcoat/virologist
	new /obj/item/clothing/under/rank/virologist(src)
	new /obj/item/clothing/under/rank/virologist(src)
	new /obj/item/storage/bag/bio(src)
	new /obj/item/storage/backpack/virology(src)
	new /obj/item/storage/backpack/satchel/vir(src)