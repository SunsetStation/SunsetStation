/obj/item/securitron_shell
	name = "Securitron Shell"
	icon = 'sunset/icons/mob/aibots.dmi'
	icon_state = "securitron_shell"
	item_state = "syringe_kit"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	force = 5
	throwforce = 10
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_NORMAL
	flags_1 = CONDUCT_1
	materials = list(MAT_METAL=500)

/obj/item/securitron_shell/attack(mob/living/M, mob/living/user)
	. = ..()
	if(prob(50))
		playsound(M, 'sound/items/trayhit1.ogg', 50, 1)
	else
		playsound(M, 'sound/items/trayhit2.ogg', 50, 1)

/obj/item/securitron_shell/attackby(obj/item/I, mob/user, params)
	if(issignaler(I))
		var/obj/item/assembly/signaler/S = I
		if(S.secured)
			qdel(S)
			var/obj/item/bot_assembly/secbot/A = new
			user.put_in_hands(A)
			to_chat(user, "<span class='notice'>You add the signaler to the securitron shell.</span>")
			qdel(src)
			return
	return ..()