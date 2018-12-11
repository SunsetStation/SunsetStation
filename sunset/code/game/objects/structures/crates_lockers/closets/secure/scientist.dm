/obj/structure/closet/secure_closet/science
	name = "\proper Science Equipment Locker"
	req_access = list(ACCESS_RESEARCH)
	icon_state = "science"

/obj/structure/closet/secure_closet/science/PopulateContents()
	..()
	new /obj/item/clothing/suit/toggle/labcoat/science(src)
	new /obj/item/clothing/under/rank/scientist(src)
	new /obj/item/radio/headset/headset_sci(src)
	new /obj/item/radio/headset/headset_sci(src)
	new /obj/item/clothing/shoes/sneakers/white(src)
	new /obj/item/clothing/gloves/color/latex(src)
	new /obj/item/tank/internals/air(src)
	new /obj/item/clothing/mask/gas(src)
	new /obj/item/cartridge/signal/toxins(src)
	new /obj/item/clothing/suit/hooded/wintercoat/science(src)
	new /obj/item/clothing/accessory/pocketprotector(src)
	new /obj/item/storage/backpack/science(src)
	new /obj/item/storage/backpack/satchel/tox(src)

/obj/structure/closet/secure_closet/robotics
	name = "\proper Robotics Equipment Locker"
	req_access = list(ACCESS_ROBOTICS)
	icon_state = "science"

/obj/structure/closet/secure_closet/robotics/PopulateContents()
	..()
	new /obj/item/clothing/suit/toggle/labcoat(src)
	new /obj/item/clothing/under/rank/roboticist(src)
	new /obj/item/radio/headset/headset_rob(src)
	new /obj/item/clothing/shoes/sneakers/black(src)
	new /obj/item/cartridge/roboticist(src)
	new /obj/item/clothing/glasses/hud/diagnostic(src)
	new /obj/item/clothing/head/soft/black(src)
	new /obj/item/clothing/gloves/fingerless(src)
	new /obj/item/clothing/mask/bandana/skull(src)
	new /obj/item/storage/backpack/science(src)
	new /obj/item/storage/backpack/satchel/tox(src)