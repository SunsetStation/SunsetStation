/obj/structure/closet/secure_closet/genpop
	name = "prisoner closet"
	desc = "It's a secure locker for inmates's personal belongings."
	var/default_desc = "It's a secure locker for the storage inmates's personal belongings during their time in prison."
	var/default_name = "prisoner closet"
	req_access = list(ACCESS_BRIG)
	icon = 'goon/icons/obj/closet.dmi'
	icon_state = "prisoner"
	var/obj/item/card/id/prisoner/registered_id = null
	locked = FALSE
	anchored = TRUE
	opened = TRUE
	density = FALSE

/obj/structure/closet/secure_closet/genpop/attackby(obj/item/W, mob/user, params)
	if(!broken && locked && W == registered_id) //Prisoner opening
		handle_prisoner_id(user)
		return

	return ..()

/obj/structure/closet/secure_closet/genpop/proc/handle_prisoner_id(mob/user)
	var/obj/item/card/id/prisoner/prisoner_id = null
	for(prisoner_id in user.held_items)
		if(prisoner_id != registered_id)
			prisoner_id = null
		else
			break

	if(!prisoner_id)
		to_chat(user, "<span class='danger'>Access Denied.</span>")
		return FALSE

	qdel(registered_id)
	registered_id = null
	locked = FALSE
	open(user)
	desc = "It's a secure locker for prisoner effects."
	to_chat(user, "<span class='notice'>You insert your prisoner id into \the [src] and it springs open!</span>")

	return TRUE

/obj/structure/closet/secure_closet/genpop/proc/handle_edit_sentence(mob/user)
	var/dat = "<div id='wrapper'>"
	dat += "<p style='display:none' id='invisText'>I exist in order to get the default font color of the page</p>"
	dat += "<table>"
	dat += "	<tr>"
	dat += "		<td>"
	dat += "			<table>"
	dat += "				<tr>"
	dat += "					<td>"
	dat += "						<img alt='logo' src='data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAByklEQVR4Ae1bAa7CIAyd5l/Fg3hyD+JhvkFDQmqBFrpKS00Mw5X1vddXFjO9HMfxf2z8um7M/U19ewH+NB1wf9KyPW60OImoy5l7AJVwj8iZgogLIEW6Joq0GGICnE0cCiIlhMgmqE0+iSGVc8oBUiBgdbnzGTcMO2AV8rNuGBJgJfLZLaOYWC0wmiSD1Bo5LTHkAC0iGnnIAlipfhKNg5UkAOeCGlWj5KBi7gpAvRAFlHYMBXtXAG3Q2vmaAlAU1AbMzdfjUBWgt5AL5JfxLS5VAX4JWDM3KkBLMU1wkrlqnFABJBOvfq0QAFaoZhUYZ3GOcQsHWKykJOZwQKkm1iPleQ/HkGM4wENVZziEA2bU87A2HOChijMcwgEz6nlYGw4oq8h5olKus3QMOW7vANazQUuVpmL9+pEU/LJAvZCVuG4LwAArxCg4MW7RAphyXtsAcwB6F8iBXsZU5MwFFnz7FkAdAFXyPP+6DZZkvewFNftnrun/As33/fk5b3Vs8Ys9INtg15G1CeY9wcpILWqz/2H/rL4PQLy9eewBVJvAuNwG6fPVjiHW1jwc0FJnh3Osu4BHQUIAj1XlcAoHcNTyGBsO8FhVDqcX+5wppCEnrBIAAAAASUVORK5CYII='>"
	dat += "					</td>"
	dat += "					<td style='padding:1em'></td>" // This gives a little bit a space between the logo and the desc text
	dat += "					<td>"
	dat += "						<span class='desc'>Secu-SAFE V 1.3<br>All rights reserved.<br>Licenced to Nanotrasen<br>for station use only.</span>"
	dat += "					</td>"
	dat += "				</tr>"
	dat += "			</table>"
	dat += "		</td>"
	dat += "	</tr>"
	dat += "	<tr>"
	dat += "		<td><p class='txt'>Input Name of Prisoner</p></td>"
	dat += "		<td><span class='brackets'>\[</span><input class='data' type='text' onkeydown='return blockSpecialChar(event)' value='[registered_id.registered_name]'/><span class='brackets'>\]</span></td>"
	dat += "	</tr>"
	dat += "	<tr>"
	dat += "		<td><p class='txt'>Input Length of Prisoner's<br>Sentence in Minutes (0 for Perma)</p></td>"
	dat += "		<td><span class='brackets'>\[</span><input onkeydown='return isNumber(event)' class='data' type='text'/ value='[registered_id.sentence]'><span class='brackets'>\]</span></td>"
	dat += "	</tr>"
	dat += "	<tr>"
	dat += "		<td><p class='txt' style='margin-right:125px;'>Input Prisoner's Crimes</p></td>"
	dat += "		<td><span class='brackets'>\[</span><input class='data' type='text' onkeydown='return blockSpecialChar(event)' value='[registered_id.crime]'/><span class='brackets'>\]</span></td>"
	dat += "	</tr>"
	dat += "</table>"
	dat += "<br>"
	dat += "<center>"
	dat += "<div>"
	if (registered_id.served == 0)
		dat += "<center><div><span>NO PRISONER LOADED</span></div></center>"
		// The "time served" fields need to exist so display:none while no prisoner loaded
		dat += "<center><div style='display:none'><span>Time Served: <span id='timeServed'><label id='minutes'>00</label>:<label id='seconds'>00</label></span>&nbsp&nbsp<button onclick='resetServed()' type='button'>Reset</button></span></div></center>"
	else
		dat += "<center><div><span>Time Served: <span id='timeServed'><label id='minutes'>00</label>:<label id='seconds'>00</label></span>&nbsp&nbsp<span class='brackets'>\[</span><button onclick='resetServed()' type='button' class='button'>Reset</button><span class='brackets'>\]</span></span></div></center>"
	dat += "</div>"
	dat += "</center>"
	dat += "<br>"
	dat += "<center>"
	dat += "	<button class='button' onclick='checkForm()' type='button'>\[ OK \]</button>"
	dat += "	&nbsp&nbsp"
	dat += "	<button class='button' onclick='clearForm()' type='button'>\[ Clear \]</button>"
	dat += "	&nbsp&nbsp"
	dat += "	<button class='button' onclick='cancelForm()'>\[ Cancel \]</button>"
	dat += "</center>"
	dat += "</div>"

	var/datum/browser/popup = new(user, "genpopLocker", "", 570, 365)
	popup.set_content(dat)
	popup.set_window_options("can_close=0")
	popup.add_stylesheet("style", 'html/sunset_ui/content/genpopLockers/style.css')
	popup.add_head_content({"
		<link href="https://fonts.googleapis.com/css?family=Press+Start+2P&display=swap" rel="stylesheet"> 
		<script>
		// These deal with the time served count up
		var totalSeconds = [registered_id.served];
		window.onload = function() {
			setInterval(setTime, 1000);
		};
		// This resets the time served
		function resetServed() {
			totalSeconds = 0; // this is for the client to show as 'reset'
			window.location = 'byond://?src=[REF(src)];choice=ClearServed;'; // sends the flag back to the server to clear the time served
		}
		// runs topic cancel
		function cancelForm() {
			window.location = 'byond://?src=[REF(src)];choice=close;';
		}
		function checkForm() {
			var dataInputs = document.getElementsByClassName('data');
			var txtFields = document.getElementsByClassName('txt');
			var fontColor = document.getElementById('invisText').style.color;
			var counter = 0; // counter is for checking if all three fields have data
			for (var i = 0; i <= 2; i++) {
				if (dataInputs\[i\].value.trim() == '') txtFields\[i\].style.color = 'red'; // if field is blank, make label RED
				else {
					txtFields\[i\].style.color = fontColor; // If field is not blank, return it to normal font color
					counter++;
				}
			}
			if (counter == 3) {
				window.onunload = "";
				// SO, because this form is fairly simple, i'm just going to use the href_list functionality to transfer out the input values for creating the ID
				var tmp = 'data1=' + dataInputs\[0\].value.replace(/#/gi, 'u0023') + ';data2=' + dataInputs\[1\].value + ';data3=' + dataInputs\[2\].value + ';';
				//alert('This closes the page and transfer's data to byond'); // debug
				window.location = 'byond://?src=[REF(src)];choice=OK;' + tmp; // production
			}
		}
		function setTime() {
			++totalSeconds; // increase by one second
			document.getElementById('seconds').innerHTML = pad(totalSeconds % 60); // edit seconds
			document.getElementById('minutes').innerHTML = pad(parseInt(totalSeconds / 60)); // edit minutes
		}
		// adds padding/formatting for seconds and minutes in time served. Used in setTime()
		function pad(val) {
			var valString = val + '';
			if (valString.length < 2) {
				return '0' + valString;
			} else {
				return valString;
			}
		}
		// Because i'm using the href function to pass data, can't allow special characters unless they are specialy coded to pass
		function blockSpecialChar(e) {
			var tmp = event.key;
			var rgx = /\[^A-Za-z0-9,\\.# -\]/g;
			if (tmp.match(rgx)) return false;
			else return true;
		}
		// So, byond turns number fields into normal textboxes. So, this makes so only digits can be in that textbox
		function isNumber(event) {
			var tmp = event.key.replace(/\[^0-9\]/, ''); // replaces any none digit with nothing
			if (tmp == '') return false; // feed the textbox nothing
			else return true; // feed the textbox the digit the user put in
		}
		// This clears out each input field
		function clearForm() {
			var fontColor = document.getElementById('invisText').style.color;
			var dataInputs = document.getElementsByClassName('data');
			var txtFields = document.getElementsByClassName('txt');
			for (var i = 0; i <= 2; i++) {
				dataInputs\[i\].value = '';
				txtFields\[i\].style.color = 'fontColor';
			}
		}
		</script>
	"})
	popup.open(TRUE)

/obj/structure/closet/secure_closet/genpop/Topic(href, href_list)
	..()
	var/mob/living/U = usr
	add_fingerprint(U)

	switch(href_list["choice"])
		if("OK")
			// #(pound/hashtag) can't be used in a hyperlinks so i flip it from unicode safe format to normal string #
			registered_id.registered_name = replacetext(href_list["data1"],"u0023","#") // data1 is the name field (string)
			registered_id.sentence = text2num(href_list["data2"]) // data2 is the sentencing field (integer)
			registered_id.crime = href_list["data3"] // data3 is the crime field (string)
			registered_id.update_label(registered_id.registered_name, registered_id.assignment)
			name = "[default_name] ([registered_id.registered_name])"
			desc = "[default_desc] It contains the personal effects of [registered_id.registered_name]."
			close(U)
			locked = TRUE
			update_icon()
			registered_id.forceMove(src.loc)
			U << browse(null, "window=genpopLocker")
		if("ClearServed") // This just clears the time
			registered_id.served = 0
		if("close") // this makes is so the locker opens back up if the user closes an empty or no prisoner loaded locker
			if(!locked)
				qdel(registered_id)
				registered_id = null
				locked = FALSE
				open(U)
				update_icon()
			U << browse(null, "window=genpopLocker") // if not locked (aka has prisoner configured) then just close the window
			


/obj/structure/closet/secure_closet/genpop/togglelock(mob/living/user)
	if(!allowed(user))
		return ..()

	if(!broken && locked && registered_id != null)
		var/name = registered_id.registered_name
		var/result = alert(user, "This locker currently contains [name]'s personal belongings ","Locker In Use","Reset","Amend ID", "Open")
		if(!user.Adjacent(src))
			return
		if(result == "Reset")
			name = default_name
			desc = default_desc
			registered_id = null
		if(result == "Open" | result == "Reset")
			locked = FALSE
			open(user)
			to_chat(user,"The lock clicks open as a pre-recorded message plays from the locker \"Don't forget to lock the locker when finished\"")
		if(result == "Amend ID")
			handle_edit_sentence(user)
	else
		return ..()

/obj/structure/closet/secure_closet/genpop/close(mob/living/user)
	if(registered_id != null)
		locked = FALSE // Don't want the locker to lock unless user clicks 'ok' in prompt
	return ..()

/obj/structure/closet/secure_closet/genpop/attack_hand(mob/user)
	var/mob/living/carbon/C = user
	if(!istype(C))
		return
	if(!(C.mobility_flags & MOBILITY_STAND) || get_dist(src, user) > 1)
		return
	if(!broken && registered_id && user.is_holding(registered_id))
		handle_prisoner_id(user)
		return
	if(!broken && opened && !locked && allowed(user) && !registered_id) //Genpop setup
		registered_id = new /obj/item/card/id/prisoner/(src.contents)
		handle_edit_sentence(user)
		return
	return ..()
