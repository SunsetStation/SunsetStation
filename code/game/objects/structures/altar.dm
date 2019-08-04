/obj/structure/holyaltar
	name = "holy altar"
	desc = "An altar dedicated to a deity."
	icon = 'icons/obj/hand_of_god_structures.dmi'
	icon_state = "convertaltar"
	density = TRUE
	resistance_flags = FLAMMABLE

/obj/structure/holyaltar/attack_hand(mob/living/user)
	.=..()
	to_chat(user, "<span class='notice'>You take a moment to calm your mind and pray.</span>")
	if(do_after(user, 100, target = src))
		to_chat(user, "<span class='notice'>You finish your prayer, and feel a lot calmer.</span>")
		SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "altar", /datum/mood_event/religiously_satisfied)