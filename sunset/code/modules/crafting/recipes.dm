/datum/crafting_recipe/secbot
	name = "Securitron"
	result = /mob/living/simple_animal/bot/secbot
	reqs = list(/obj/item/assembly/signaler = 1,
				/obj/item/securitron_shell = 1,
				/obj/item/melee/baton = 1,
				/obj/item/assembly/prox_sensor = 1,
				/obj/item/bodypart/r_arm/robot = 1)
	tools = list(TOOL_WELDER)
	time = 60
	category = CAT_ROBOT

/datum/crafting_recipe/honkbot
	name = "Honkbot"
	result = /mob/living/simple_animal/bot/honkbot
	reqs = list(/obj/item/storage/box/clown = 1,
				/obj/item/bodypart/r_arm/robot = 1,
				/obj/item/assembly/prox_sensor = 1,
				/obj/item/bikehorn/ = 1)
	time = 40
	category = CAT_ROBOT

/datum/crafting_recipe/honkbot
	name = "Securitron Shell"
	result = /obj/item/securitron_shell
	reqs = list(
				/obj/item/stack/sheet/plasteel = 5)
	tools = list(TOOL_WELDER)
	time = 20
	category = CAT_ROBOT