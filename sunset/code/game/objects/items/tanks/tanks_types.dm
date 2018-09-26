/obj/item/tank/internals/emergency_oxygen/vox
	name = "vox n2 tank"
	desc = "A vox nitrogen tank made of a strong, light weight alloy; this tank is capable of holding gasses at high pressures without exploding. Due to its light weight, don't expect to robust any dustlungs with it, skrek."
	icon_state = "emergency_vox"
	flags_1 = CONDUCT_1
	slot_flags = SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	force = 0 // No, you don't get to break out of the brig using your voxygen tank, shitbird.
	distribute_pressure = TANK_DEFAULT_RELEASE_PRESSURE
	volume = 8 // Larger than a standard emergency tank, smaller than a double.
	attack_verb = list("skrekked")

/obj/item/tank/internals/emergency_oxygen/vox/New()
	..()
	air_contents.assert_gas(/datum/gas/nitrogen)

	air_contents.gases[/datum/gas/oxygen][MOLES] = 0
	air_contents.gases[/datum/gas/nitrogen][MOLES] = (10*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C)
	return
