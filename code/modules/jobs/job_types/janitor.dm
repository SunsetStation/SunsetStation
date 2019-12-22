/datum/job/janitor
	title = "Janitor"
	flag = JANITOR
	department_head = list("Head of Personnel")
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 2
	spawn_positions = 1
	supervisors = "the head of personnel"
	selection_color = "#bbe291"
	var/global/janitors = 0

	outfit = /datum/outfit/job/janitor

	access = list(ACCESS_JANITOR, ACCESS_MAINT_TUNNELS, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_JANITOR, ACCESS_MAINT_TUNNELS, ACCESS_MINERAL_STOREROOM)
	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV

	display_order = JOB_DISPLAY_ORDER_JANITOR

/datum/outfit/job/janitor
	name = "Janitor"
	jobtype = /datum/job/janitor

	pda_slot = /obj/item/pda/janitor//sunset adds pda
	ears = /obj/item/radio/headset/headset_srv
	uniform = /obj/item/clothing/under/rank/janitor
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/advanced=1)
