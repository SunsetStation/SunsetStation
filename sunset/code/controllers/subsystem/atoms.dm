
/atom/proc/rec_act(mob/user, obj/item/makeshift/reclaimer/rec)
	SEND_SIGNAL(src, COMSIG_ATOM_REC_ACT, user, rec)
