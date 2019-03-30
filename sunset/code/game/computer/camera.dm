
// SECURITY MONITORS

/obj/machinery/computer/security/wooden_tv
	icon = 'sunset/icons/obj/computer.dmi'
	name = "security camera monitor"
	desc = "An old TV hooked into the station's camera network."
	icon_state = "television"
	icon_keyboard = null
	icon_screen = "detective_tv"
	clockwork = TRUE
	pass_flags = PASSTABLE

/obj/machinery/computer/security/retro
	icon = 'sunset/icons/obj/computer.dmi'
	name = "Television"
	desc = "Hopefully this tv can show your favorite soap operas."
	icon_state = "retro_television"
	icon_keyboard = null
	icon_screen = "show"
	clockwork = TRUE
	pass_flags = PASSTABLE
	network = list("thunder")