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
	var/dat = "<div id='wrapper'>";
	dat += "<p style='display:none' id='invisText'>I exist in order to get the default font color of the page</p>"
	dat += "<table>"
	dat += "<tr><td><p class='txt'>Input Name of Prisoner</p></td><td><input class='data' type='text' onkeydown='return blockSpecialChar(event)' value='[registered_id.registered_name]'/></td></tr>"
	dat += "<tr><td><p class='txt'>Input Length of Prioners<br>Sentence in Minutes (0 for Perma)</p></td><td><input onkeydown='return isNumber(event)' class='data' type='text'/ value='[registered_id.sentence]'></td></tr>"
	dat += "<tr><td><p class='txt'>Input Prioner's Crimes</p></td><td><input class='data' type='text' onkeydown='return blockSpecialChar(event)' value='[registered_id.crime]'/></td></tr>"
	dat += "</table>"
	dat += "<br>"
	if (registered_id.served != 0)
		dat += "<center><div style=''><span>NO PRISONER LOADED</span></div></center>"
	else
		dat += "<center><div style='display:none'><span>Time Served: <span id='timeServed'><label id='minutes'>00</label>:<label id='seconds'>00</label></span>&nbsp&nbsp<button onclick='resetServed()' type='button'>Reset</button></span></div></center>"
	dat += "<center><button onclick='checkForm()' type='button'>OK</button>&nbsp&nbsp<button onclick='clearForm()' type='button'>Clear</button></center>"
	dat += "</div>"

	var/datum/browser/popup = new(user, "genpopLocker", "", 590, 250)
	popup.set_content(dat)
	popup.add_head_content({"
	<script>

	// This resets the time served
	function resetServed(){
		totalSeconds = 0;
		window.location = 'byond://?src=[REF(src)];choice=ClearServed;';
	}
	// Next Two functions deal with the time served count up
	var totalSeconds = [registered_id.served];
	setInterval(setTime, 1000);

	function setTime() {
	++totalSeconds;
	document.getElementById("seconds").innerHTML = pad(totalSeconds % 60);
	document.getElementById("minutes").innerHTML = pad(parseInt(totalSeconds / 60));
	}

	function pad(val) {
	var valString = val + "";
	if (valString.length < 2) {
		return "0" + valString;
	} else {
		return valString;
	}
	}
	// Because i'm using the href function to pass data, can't allow special characters unless they are specialy coded to pass
	function blockSpecialChar(e){
		var test = event.key.replace(/\[^A-Za-z0-9,.#-\]/,'');
		if (test == '')
			return false;
		else
			return true;
    }
	// So, byond turns number fields into normal textboxes. So, this makes so only digits can be in that field
	function isNumber(event) {
		var test = event.key.replace(/\[^0-9\]/,'');
		if (test == '')
			return false;
		else
			return true;
	}
	// This clears out each input field
	function clearForm() {
		var fontColor = document.getElementById('invisText').style.color;
		var dataInputs = document.getElementsByClassName('data');
		var txtFields = document.getElementsByClassName('txt');
		for (var i=0;i<=2;i++) {
			dataInputs\[i\].value = '';
			txtFields\[i\].style.color = 'fontColor';
		}
	}
	function checkForm() {
		var dataInputs = document.getElementsByClassName('data');
		var txtFields = document.getElementsByClassName('txt');
		var fontColor = document.getElementById('invisText').style.color;
		var counter=0; // counter is for checking if all three fields have data
		for (var i=0;i<=2;i++) {
			if (dataInputs\[i\].value.trim() == '')
				txtFields\[i\].style.color = 'red'; // if field is blank, make label RED
			else {
				txtFields\[i\].style.color = fontColor; // If field is nont blank, return it to normal font color
				counter++;
			}
		}
		if (counter == 3) {
			// SO, because this form is fairly simple, i'm just going to use the href_list functionality to transfer out the input values for creating the ID
			var tmp = 'data1=' + dataInputs\[0\].value.replace(/#/gi,'u0023') + ';data2=' + dataInputs\[1\].value + ';data3=' + dataInputs\[2\].value + ';';
			window.location = 'byond://?src=[REF(src)];choice=OK;' + tmp;
		}

	}
	</script>
	"})
	popup.open(0)

/*
	var/prisoner_name = input(user, "Please input the name of the prisoner.", "Prisoner Name", registered_id.registered_name) as text|null
	if(prisoner_name == null | !user.Adjacent(src))
		return FALSE
	var/sentence_length = input(user, "Please input the length of their sentence in minutes (0 for perma).", "Sentence Length", registered_id.sentence) as num|null
	if(sentence_length == null | !user.Adjacent(src))
		return FALSE
	var/crimes = input(user, "Please input their crimes.", "Crimes", registered_id.crime) as text|null
	if(crimes == null | !user.Adjacent(src))
		return FALSE

	registered_id.registered_name = prisoner_name
	registered_id.sentence = text2num(sentence_length)
	registered_id.crime = crimes
	registered_id.update_label(prisoner_name, registered_id.assignment)

	name = "[default_name] ([prisoner_name])"
	desc = "[default_desc] It contains the personal effects of [prisoner_name]."

	return TRUE*/

/obj/structure/closet/secure_closet/genpop/Topic(href, href_list)
	..()
	var/mob/living/U = usr
	add_fingerprint(U)

	switch(href_list["choice"])
		if("OK")
			// # can't be used in a hyperlinks so i flip it back and forth between unicode character code
			registered_id.registered_name = replacetext(href_list["data1"],"u0023","#") 
			registered_id.sentence = text2num(href_list["data2"])
			registered_id.crime = href_list["data3"]
			registered_id.update_label(registered_id.registered_name, registered_id.assignment)
			name = "[default_name] ([registered_id.registered_name])"
			desc = "[default_desc] It contains the personal effects of [registered_id.registered_name]."
			close(U)
			locked = TRUE
			update_icon()
			registered_id.forceMove(src.loc)
			U << browse(null, "window=genpopLocker")
		if("ClearServed")
			registered_id.served = 0
		if("close")
			if(!locked)
				qdel(registered_id)
				registered_id = null
				locked = FALSE
				open(U)
				update_icon()
			


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
		if(result == "Amend ID")
			handle_edit_sentence(user)
			/*if(alert(user, "Do you want to reset their timer to 0?", "Reset Sentence?", "Yes", "No") == "Yes")
				registered_id.served = 0*/
	else
		return ..()

/obj/structure/closet/secure_closet/genpop/close(mob/living/user)
	if(registered_id != null)
		locked = TRUE
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
		/*if(handle_edit_sentence(user))
			registered_id.served = 0
			close(user)
			locked = TRUE
			update_icon()
			registered_id.forceMove(src.loc)
		else
			qdel(registered_id)
			registered_id = null
		return*/
	return ..()
