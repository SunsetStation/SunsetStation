/obj/machinery/computer/teleporter
	var/obj/item/gps/locked

/obj/machinery/computer/teleporter/attackby(obj/I, mob/living/user, params)
	if(istype(I, /obj/item/gps))
		var/obj/item/gps/L = I
		if(L.locked_location && !(stat & (NOPOWER|BROKEN)))
			if(!user.transferItemToLoc(L, src))
				to_chat(user, "<span class='warning'>\the [I] is stuck to your hand, you cannot put it in \the [src]!</span>")
				return
			locked = L
			to_chat(user, "<span class='caution'>You insert the GPS device into the [name]'s slot.</span>")
			updateDialog()
	else
		return ..()

/obj/machinery/computer/teleporter/ui_interact(mob/user)
	var/data = "<h3>Teleporter Status</h3>"
	if(!power_station)
		data += "<div class='statusDisplay'>No power station linked.</div>"
	else if(!power_station.teleporter_hub)
		data += "<div class='statusDisplay'>No hub linked.</div>"
	else
		data += "<div class='statusDisplay'>Current regime: [regime_set]<BR>"
		data += "Current target: [(!target) ? "None" : "[get_area(target)] [(regime_set != "Gate") ? "" : "Teleporter"]"]<BR>"
		if(calibrating)
			data += "Calibration: <font color='yellow'>In Progress</font>"
		else if(power_station.teleporter_hub.calibrated || power_station.teleporter_hub.accurate >= 3)
			data += "Calibration: <font color='green'>Optimal</font>"
		else
			data += "Calibration: <font color='red'>Sub-Optimal</font>"
		data += "</div><BR>"

		data += "<A href='?src=[REF(src)];regimeset=1'>Change regime</A><BR>"
		data += "<A href='?src=[REF(src)];settarget=1'>Set target</A><BR>"
		if(locked)
			data += "<BR><A href='?src=[REF(src)];locked=1'>Get target from memory</A><BR>"
			data += "<A href='?src=[REF(src)];eject=1'>Eject GPS device</A><BR>"
		else
			data += "<BR><span class='linkOff'>Get target from memory</span><BR>"
			data += "<span class='linkOff'>Eject GPS device</span><BR>"

		data += "<BR><A href='?src=[REF(src)];calibrate=1'>Calibrate Hub</A>"

	var/datum/browser/popup = new(user, "teleporter", name, 400, 400)
	popup.set_content(data)
	popup.open()

/obj/machinery/computer/teleporter/Topic(href, href_list)
	if(..())
		return

	if(href_list["eject"])
		eject()
		updateDialog()
		return

	if(!check_hub_connection())
		say("Error: Unable to detect hub.")
		return
	if(calibrating)
		say("Error: Calibration in progress. Stand by.")
		return

	if(href_list["locked"])
		power_station.engaged = 0
		power_station.teleporter_hub.update_icon()
		power_station.teleporter_hub.calibrated = 0
		target = get_turf(locked.locked_location)
	if(href_list["calibrate"])
		if(!target)
			say("Error: No target set to calibrate to.")
			return
		if(power_station.teleporter_hub.calibrated || power_station.teleporter_hub.accurate >= 3)
			say("Hub is already calibrated!")
			return
		say("Processing hub calibration to target...")

		calibrating = 1
		spawn(50 * (3 - power_station.teleporter_hub.accurate)) //Better parts mean faster calibration
			calibrating = 0
			if(check_hub_connection())
				power_station.teleporter_hub.calibrated = 1
				say("Calibration complete.")
			else
				say("Error: Unable to detect hub.")
			updateDialog()
	updateDialog()

/obj/machinery/computer/teleporter/proc/eject()
	if(locked)
		locked.forceMove(get_turf(src))
		locked = null
