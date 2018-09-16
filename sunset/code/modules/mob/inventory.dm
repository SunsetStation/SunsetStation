// Can put in any hand?
/mob/proc/can_put_in_hands(obj/item/I)
	if(can_put_in_hand(I, active_hand_index))
		return TRUE
	if(can_put_in_hand(I, get_inactive_hand_index()))
		return TRUE
	return FALSE