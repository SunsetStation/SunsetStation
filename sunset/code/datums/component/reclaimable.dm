#define REC_PROB "probability"
#define REC_MAXDROP "maxdrop"

/datum/component/reclaimable
	dupe_mode = COMPONENT_DUPE_UNIQUE
	var/list/recdrops = list(/obj/item/bikehorn = list(REC_PROB = 100, REC_MAXDROP = 1))
	var/datum/callback/callback
	var/reclaimed = FALSE

/datum/component/reclaimable/Initialize(list/_recdrops = list(), datum/callback/_callback)
	recdrops = _recdrops
	for(var/i in recdrops)
		if(isnull(recdrops[i][REC_MAXDROP]))
			recdrops[i][REC_MAXDROP] = 1
			stack_trace("RECLAIMABLE WARNING: [parent] contained a null max_drop value in [i].")
		if(isnull(recdrops[i][REC_PROB]))
			recdrops[i][REC_PROB] = 100
			stack_trace("RECLAIMABLE WARNING: [parent] contained a null probability value in [i].")
	callback = _callback
	RegisterSignal(parent, COMSIG_ATOM_REC_ACT, .proc/reclaimer_reclaim)
	RegisterSignal(parent, COMSIG_PARENT_QDELETED, .proc/qdel_reclaim)

/datum/component/reclaimable/InheritComponent(datum/component/reclaimable/A, i_am_original)
	var/list/other_recdrops = A.recdrops
	var/list/_recdrops = recdrops
	for(var/I in other_recdrops)
		_recdrops[I] += other_recdrops[I]

/datum/component/reclaimable/proc/reclaim(probmultiplier)
	if(!QDELETED(parent) || reclaimed)
		return FALSE
	var/turf/T = get_turf(parent)
	for(var/thing in recdrops)
		var/maxtodrop = recdrops[thing][REC_MAXDROP]
		for(var/i in 1 to maxtodrop)
			if(prob(recdrops[thing][REC_PROB] * probmultiplier)) // can't win them all!
				new thing(T)
	reclaimed = TRUE
	qdel(parent)
	if(callback)
		callback.Invoke()
	return TRUE

/datum/component/reclaimable/proc/reclaimer_reclaim(mob/user,obj/item/makeshift/reclaimer/rec)
	if(!rec.rec_ready)
		return
	if(reclaim(rec.efficency))
		rec.rec_ready = FALSE
		rec.update_icon()
		addtimer(VARSET_CALLBACK(rec,rec_ready,TRUE),100)
		addtimer(CALLBACK(rec,/obj/item/makeshift/reclaimer.proc/update_icon),105)

/datum/component/reclaimable/proc/qdel_reclaim()
	reclaim(0.5) // -50% chance to get items if it was destroyed
