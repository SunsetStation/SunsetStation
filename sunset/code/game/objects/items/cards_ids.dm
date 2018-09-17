/obj/item/card/id/prisoner
	assignment = "Convict"

	var/served = 0 //Time served in seconds
	var/sentence = 0 //Sentance in minutes
	var/crime = "\[redacted\]"

	access = list(ACCESS_GENPOP_ENTER)

/obj/item/card/id/prisoner/Initialize()
	. = ..()
	START_PROCESSING(SSprocessing, src)
	registered_name = "Prisoner #13-[rand(100,999)]"


/obj/item/card/id/prisoner/process()
	if (sentence > 0 && served > (sentence * 60)) //FREEDOM!
		assignment = "Ex-Convict"
		access = list(ACCESS_GENPOP_EXIT)
		update_label(registered_name, assignment)
		playsound(loc, 'sound/machines/ping.ogg', 50, 1)
		if(isliving(loc))
			to_chat(loc, "<span class='boldnotice'>\the [src] buzzes: You have served your sentence! You may now exit prison through the turnstiles and collect your belongings.</span>")
		STOP_PROCESSING(SSprocessing, src)
	else
		served += 1

/obj/item/card/id/prisoner/examine(mob/user)
	..()
	var/minutesServed = round(served / 60)
	var/secondsServed = served - (minutesServed * 60)
	if(sentence <= 0)
		to_chat(usr, "<span class='notice'>You are serving a permanent sentence for [crime].</span>")
	else if(served >= (sentence * 60))
		to_chat(usr, "<span class='notice'>You have served your sentence for [crime].</span>")
	else
		to_chat(usr, "<span class='notice'>You have served [minutesServed] minutes [secondsServed] seconds of your [sentence] minute sentance for [crime].</span>")
	if(goal > 0)
		to_chat(usr, "<span class='notice'>You have accumulated [points] out of the [goal] points you need for freedom.</span>")