/*
Blueshield
*/

/datum/job/blueshield
	title = "Blueshield"
	flag = BLUESHIELD
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "captain and command personnel"
	selection_color = "#ddddff"
	req_admin_notify = 1
	minimal_player_age = 14
	exp_requirements = 600 //10 hours
	exp_type = EXP_TYPE_CREW
	special_notice = "You are a bodyguard for heads of staff. You are not a security officer. Do not do security's job."

	outfit = /datum/outfit/job/blueshield

	access = list(ACCESS_SECURITY,ACCESS_MEDICAL,ACCESS_MORGUE,ACCESS_ENGINE,ACCESS_MAINT_TUNNELS,ACCESS_TELEPORTER,ACCESS_EVA,ACCESS_HEADS,
			ACCESS_ALL_PERSONAL_LOCKERS,ACCESS_COURT,ACCESS_RESEARCH,ACCESS_CONSTRUCTION,ACCESS_CARGO,ACCESS_SEC_DOORS,ACCESS_WEAPONS,
			ACCESS_RC_ANNOUNCE,ACCESS_KEYCARD_AUTH,ACCESS_BLUESHIELD,ACCESS_ATMOSPHERICS)
	minimal_access = list(ACCESS_SECURITY,ACCESS_MEDICAL,ACCESS_MORGUE,ACCESS_ENGINE,ACCESS_MAINT_TUNNELS,ACCESS_TELEPORTER,ACCESS_EVA,ACCESS_HEADS,
			ACCESS_ALL_PERSONAL_LOCKERS,ACCESS_COURT,ACCESS_RESEARCH,ACCESS_CONSTRUCTION,ACCESS_CARGO,ACCESS_SEC_DOORS,ACCESS_WEAPONS,
			ACCESS_RC_ANNOUNCE,ACCESS_KEYCARD_AUTH,ACCESS_BLUESHIELD,ACCESS_ATMOSPHERICS)

/datum/outfit/job/blueshield
	name = "Blueshield"
	jobtype = /datum/job/blueshield

	id = /obj/item/card/id/silver
	uniform = /obj/item/clothing/under/rank/blueshield
	gloves = /obj/item/clothing/gloves/combat
	shoes = /obj/item/clothing/shoes/jackboots
	ears = /obj/item/radio/headset/heads/blueshield/alt
	glasses = /obj/item/clothing/glasses/hud/health/sunglasses
	pda_slot = /obj/item/pda/blueshield

	implants = list(/obj/item/implant/mindshield)

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec

	backpack_contents = list(
		/obj/item/blueshield_gun_package = 1
	)
