/obj/item/pda
	desc = "A portable microcomputer by Thinktronic Systems, LTD. Functionality determined by a preprogrammed ROM cartridge. The screen emits a very quiet hum."
	icon = 'sunset/icons/obj/pda.dmi'

/obj/item/pda/interact(mob/user)
	if(!user.IsAdvancedToolUser())
		to_chat(user, "<span class='warning'>You don't have the dexterity to do this!</span>")
		return

	..()

	var/datum/asset/simple/assets = get_asset_datum(/datum/asset/simple/sunset_pda)
	assets.send(user)

	user.set_machine(src)

	var/dat = ""

	dat += "<img src='refresh.png' class=pda_icon>   <a href='byond://?src=[REF(src)];choice=Refresh'>Refresh</a>"

	if((!isnull(cartridge)) && (mode == 0))
		dat += " | <img src='eject.png' class=pda_icon>   <a href='byond://?src=[REF(src)];choice=Eject'>Eject [cartridge]</a>"
	if(mode)
		dat += " | <img src='menu.png' class=pda_icon>   <a href='byond://?src=[REF(src)];choice=Return'>Return</a>"

	dat += "<br>"

	if(!owner)
		dat += "Warning: No owner information entered.  Please swipe card.<br><br>"
		dat += "<img src='refresh.png' class=pda_icon>   <a href='byond://?src=[REF(src)];choice=Refresh'>Retry</a>"
	else
		switch (mode)
			if(0)
				dat += "<h2>PERSONAL DATA ASSISTANT v.1.2</h2>"
				dat += "Owner: [owner], [ownjob]<br>"

				if(id)
					dat += text("ID: <A href='?src=[REF(src)];choice=Authenticate'>[id ? "[id.registered_name], [id.assignment]" : "----------"]   <a href='?src=[REF(src)];choice=UpdateInfo'>[id ? "Update PDA Info" : ""]</a><br><br>")

				dat += "[worldtime2text()]<br>" //:[world.time / 100 % 6][world.time / 100 % 10]"
				dat += "[time2text(world.realtime, "MMM DD")] [GLOB.year_integer+540]"
				dat += "<br><br>"
				dat += "<h4>General Functions</h4>"
				dat += "<li><img src='notes.png' class=pda_icon>   <a href='byond://?src=[REF(src)];choice=1'>Notekeeper</a></li>"
				dat += "<li><img src='mail.png' class=pda_icon>   <a href='byond://?src=[REF(src)];choice=2'>Messenger</a></li>"
				dat += "<li><img src='notes.png' class=pda_icon>   <a href='byond://?src=[REF(src)];choice=41'>View Crew Manifest</a></li>"

				if(cartridge)
					if(cartridge.access)
						dat += "<h4>Job Specific Functions</h4>"
						if(cartridge.access & CART_CLOWN)
							dat += "<li><img src='honk.png' class=pda_icon>   <a href='byond://?src=[REF(src)];choice=Honk'>Honk Synthesizer</a></li>"
							dat += "<li><img src='honk.png' class=pda_icon>   <a href='byond://?src=[REF(src)];choice=Trombone'>Sad Trombone</a></li>"
						if(cartridge.access & CART_STATUS_DISPLAY)
							dat += "<li><img src='status.png' class=pda_icon>   <a href='byond://?src=[REF(src)];choice=42'>Set Status Display</a></li>"
						if(cartridge.access & CART_ENGINE)
							dat += "<li><img src='power.png' class=pda_icon>   <a href='byond://?src=[REF(src)];choice=43'>Power Monitor</a></li>"
						if(cartridge.access & CART_MEDICAL)
							dat += "<li><img src='medical.png' class=pda_icon>   <a href='byond://?src=[REF(src)];choice=44'>Medical Records</a></li>"
						if(cartridge.access & CART_SECURITY)
							dat += "<li><img src='cuffs.png' class=pda_icon>   <a href='byond://?src=[REF(src)];choice=45'>Security Records</A></li>"
						if(cartridge.access & CART_QUARTERMASTER)
							dat += "<li><img src='crate.png' class=pda_icon>   <a href='byond://?src=[REF(src)];choice=47'>Supply Records</A></li>"

				dat += "<h4>Utilities</h4>"
				if(cartridge)
					if(cartridge.bot_access_flags)
						dat += "<li><img src='medbot.png' class=pda_icon>   <a href='byond://?src=[REF(src)];choice=54'>Bots Access</a></li>"
					if(cartridge.access & CART_JANITOR)
						dat += "<li><img src='bucket.png' class=pda_icon>   <a href='byond://?src=[REF(src)];choice=49'>Custodial Locator</a></li>"
					if(istype(cartridge.radio))
						dat += "<li><img src='signaler.png' class=pda_icon>   <a href='byond://?src=[REF(src)];choice=40'>Signaler System</a></li>"
					if(cartridge.access & CART_NEWSCASTER)
						dat += "<li><img src='notes.png' class=pda_icon>   <a href='byond://?src=[REF(src)];choice=53'>Newscaster Access </a></li>"
					if(cartridge.access & CART_REAGENT_SCANNER)
						dat += "<li><img src='notes.png' class=pda_icon>   <a href='byond://?src=[REF(src)];choice=Reagent Scan'>[scanmode == 3 ? "Disable" : "Enable"] Reagent Scanner</a></li>"
					if(cartridge.access & CART_ENGINE)
						dat += "<li><img src='notes.png' class=pda_icon>   <a href='byond://?src=[REF(src)];choice=Halogen Counter'>[scanmode == 4 ? "Disable" : "Enable"] Halogen Counter</a></li>"
					if(cartridge.access & CART_MEDICAL)
						dat += "<li><img src='scanner.png' class=pda_icon>   <a href='byond://?src=[REF(src)];choice=Medical Scan'>[scanmode == 1 ? "Disable" : "Enable"] Medical Scanner</a></li>"
					if(cartridge.access & CART_ATMOS)
						dat += "<li><img src='notes.png' class=pda_icon>   <a href='byond://?src=[REF(src)];choice=Gas Scan'>[scanmode == 5 ? "Disable" : "Enable"] Gas Scanner</a></li>"
					if(cartridge.access & CART_REMOTE_DOOR)
						dat += "<li><img src='rdoor.png' class=pda_icon>   <a href='byond://?src=[REF(src)];choice=Toggle Door'>Toggle Remote Door</a></li>"
					if(cartridge.access & CART_DRONEPHONE)
						dat += "<li><img src='dronephone.png' class=pda_icon>   <a href='byond://?src=[REF(src)];choice=Drone Phone'>Drone Phone</a></li>"
				dat += "<li><img src='atmos.png' class=pda_icon>   <a href='byond://?src=[REF(src)];choice=3'>Atmospheric Scan</a></li>"
				dat += "<li><img src='flashlight.png' class=pda_icon>   <a href='byond://?src=[REF(src)];choice=Light'>[fon ? "Disable" : "Enable"] Flashlight</a></li>"
				if(pai)
					if(pai.loc != src)
						pai = null
						update_icon()
					else
						dat += "<li><img src='status.png' class=pda_icon>   <a href='byond://?src=[REF(src)];choice=pai;option=1'>pAI Device Configuration</a></li>"
						dat += "<li><img src='status.png' class=pda_icon>   <a href='byond://?src=[REF(src)];choice=pai;option=2'>Eject pAI Device</a></li>"

			if(1)
				dat += "<h4><img src='notes.png' class='pda_icon'> Notekeeper V2.2</h4>"
				dat += "<a href='byond://?src=[REF(src)];choice=Edit'>Edit</a><br>"
				if(notescanned)
					dat += "(This is a scanned image, editing it may cause some text formatting to change.)<br>"
				dat += "<HR><font face=\"[PEN_FONT]\">[(!notehtml ? note : notehtml)]</font>"

			if(2)
				dat += "<h4><img src='mail.png' class='pda_icon'> SpaceMessenger V3.9.6</h4>"
				dat += "<img src='bell.png' class=pda_icon>   <a href='byond://?src=[REF(src)];choice=Toggle Ringer'>Ringer: [silent == 1 ? "Off" : "On"]</a><br>"
				dat += "<img src='mail.png' class=pda_icon>   <a href='byond://?src=[REF(src)];choice=Toggle Messenger'>Send / Receive: [toff == 1 ? "Off" : "On"]</a><br>"
				dat += "<img src='bell.png' class=pda_icon>   <a href='byond://?src=[REF(src)];choice=Ringtone'>Set Ringtone</a><br>"
				dat += "<img src='mail.png' class=pda_icon>   <a href='byond://?src=[REF(src)];choice=21'>View Message Log</a><br>"

				if(cartridge)
					dat += cartridge.message_header()

				dat += "<h4><img src='mail.png' class='pda_icon'>   Detected PDAs</h4>"

				dat += "<ul>"
				var/count = 0

				if(!toff)
					for (var/obj/item/pda/P in sortNames(get_viewable_pdas()))
						if(P == src)
							continue
						dat += "<li><a href='byond://?src=[REF(src)];choice=Message;target=[REF(P)]'>[P]</a>"
						if(cartridge)
							dat += cartridge.message_special(P)
						dat += "</li>"
						count++
				dat += "</ul>"
				if(count == 0)
					dat += "None detected.<br>"
				else if(cartridge && cartridge.spam_enabled)
					dat += "<img src='mail.png' class=pda_icon>   <a href='byond://?src=[REF(src)];choice=MessageAll'>Send To All</a>"

			if(21)
				dat += "<h4><img src='mail.png' class='pda_icon'>   SpaceMessenger V3.9.6</h4>"
				dat += "<img src='blank.png' class=pda_icon>   <a href='byond://?src=[REF(src)];choice=Clear'> Clear Messages</a>"

				dat += "<h4><img src='mail.png' class='pda_icon'>   Messages</h4>"

				dat += tnote
				dat += "<br>"

			if(41) //crew manifest
				dat += "<h4>Crew Manifest</h4>"
				dat += "<center>"
				dat += GLOB.data_core.get_manifest()
				dat += "</center>"

			if(3)
				dat += "<h4><img src='atmos.png' class='pda_icon'>   Atmospheric Readings</h4>"

				var/turf/T = user.loc
				if(isnull(T))
					dat += "Unable to obtain a reading.<br>"
				else
					var/datum/gas_mixture/environment = T.return_air()
					var/list/env_gases = environment.gases

					var/pressure = environment.return_pressure()
					var/total_moles = environment.total_moles()

					dat += "Air Pressure: [round(pressure,0.1)] kPa<br>"

					if(total_moles)
						for(var/id in env_gases)
							var/gas_level = env_gases[id][MOLES]/total_moles
							if(gas_level > 0)
								dat += "[env_gases[id][GAS_META][META_GAS_NAME]]: [round(gas_level*100, 0.01)]%<br>"

					dat += "Temperature: [round(environment.temperature-T0C)]&deg;C<br>"
				dat += "<br>"
			else//Else it links to the cart menu proc. Although, it really uses menu hub 4--menu 4 doesn't really exist as it simply redirects to hub.
				dat += cartridge.generate_menu()

	dat += "</body></html>"

	var/datum/browser/popup = new(user, "pda_ui", "<div align='center'>Personal Data Assistant</div>", 500, 600)
	popup.set_content(dat)
	popup.open(0)