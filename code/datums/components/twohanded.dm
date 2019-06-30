/datum/component/twohanded
	var/wielded = FALSE
	var/extra_force = 0
	var/two_hands_required = FALSE
	var/wieldsound
	var/unwieldsound

/datum/component/twohanded/Initialize(two_hands_required = FALSE, extra_force = 0)
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, list(COMSIG_ITEM_ATTACK_SELF), .proc/attack_self)
	RegisterSignal(parent, list(COMSIG_ITEM_DROPPED), .proc/dropped)
	RegisterSignal(parent, list(COMSIG_ITEM_EQUIPPED), .proc/equipped)
	if (two_hands_required)
		src.two_hands_required = TRUE
		RegisterSignal(parent, COMSIG_ATOM_ATTACK_HAND, .proc/attack_hand)
	if (extra_force)
		src.extra_force = extra_force

/datum/component/twohanded/proc/attack_self(datum/source, mob/living/carbon/user)
	if(wielded)
		unwield(user)
	else
		wield(user)

/datum/component/twohanded/proc/attack_hand(datum/source, mob/living/carbon/user)
	var/obj/item/H = user.get_inactive_held_item()
	var/obj/item/parent_item = parent
	if(get_dist(src,user) > 1)
		return
	if(H != null)
		to_chat(user, "<span class='notice'>[src] is too cumbersome to carry in one hand!</span>")
		return COMPONENT_NO_ATTACK_HAND
	if(parent_item.loc != user)
		wield(user)

/datum/component/twohanded/proc/equipped(datum/source, mob/living/carbon/user, slot)


/datum/component/twohanded/proc/dropped(datum/source, mob/living/carbon/user)
	if(wielded)
		unwield(user)

/datum/component/twohanded/proc/wield(mob/living/user)
	if(wielded)
		return
	if(ismonkey(user))
		to_chat(user, "<span class='warning'>It's too heavy for you to wield fully.</span>")
		return
	if(user.get_inactive_held_item())
		to_chat(user, "<span class='warning'>You need your other hand to be empty!</span>")
		return
	if(user.get_num_arms() < 2)
		to_chat(user, "<span class='warning'>You don't have enough intact hands.</span>")
		return
	wielded = TRUE
	var/obj/item/item = parent
	item.force += extra_force
	item.name = "[item.name] (Wielded)"
	item.update_icon()
	item.item_state = "[item.item_state]w"
	if(iscyborg(user))
		to_chat(user, "<span class='notice'>You dedicate your module to [item].</span>")
	else
		to_chat(user, "<span class='notice'>You grab [item] with both hands.</span>")
	if (wieldsound)
		playsound(parent, wieldsound, 50, 1)
	var/obj/item/twohanded_offhand/O = new(user, parent, src) ////Let's reserve his other hand~
	O.name = "[initial(item.name)] - offhand"
	O.desc = "Your second grip on [src]."
	user.put_in_inactive_hand(O)

/datum/component/twohanded/proc/unwield(mob/living/carbon/user, show_message = TRUE)
	if(!wielded || !user)
		return
	var/obj/item/item = parent
	wielded = FALSE
	item.force -= extra_force
	item.name = replacetext(item.name, " (Wielded)", "")
	item.item_state = copytext(item.item_state, 1, length(item.item_state))
	item.update_icon()
	if(user.get_item_by_slot(SLOT_BACK) == item)
		user.update_inv_back()
	else
		user.update_inv_hands()
	if(show_message)
		if(iscyborg(user))
			to_chat(user, "<span class='notice'>You free up your module.</span>")
		else
			to_chat(user, "<span class='notice'>You are now carrying [item] with one hand.</span>")
	if(unwieldsound)
		playsound(item.loc, unwieldsound, 50, 1)
	var/obj/item/twohanded_offhand/O = user.get_inactive_held_item()
	if(O && istype(O))
		qdel(O)

/obj/item/twohanded_offhand
	name = "offhand"
	icon_state = "offhand"
	w_class = WEIGHT_CLASS_HUGE
	item_flags = ABSTRACT
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	var/obj/item/main_item
	var/datum/component/twohanded/item_component

/obj/item/twohanded_offhand/Initialize(mapload, main_item, item_component)
	. = ..()
	if (!main_item || !item_component)
		return INITIALIZE_HINT_QDEL
	src.main_item = main_item
	src.item_component = item_component

/obj/item/twohanded_offhand/dropped(mob/living/user, show_message = TRUE)
	item_component.unwield(user)
	if (!QDELETED(src))
		user.dropItemToGround(main_item)
		qdel(src)
