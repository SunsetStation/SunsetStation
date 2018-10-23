/obj/item/beacon
	var/beacon_note = ""

/obj/item/beacon/verb/alter_signal(mob/user)
	set name = "Add Note To Signal"
	set category = "Object"

	beacon_note = copytext(sanitize(input(user, "What would you like to add to the beacons signal", "Add Note", null) as text), 1, MAX_NAME_LEN)
