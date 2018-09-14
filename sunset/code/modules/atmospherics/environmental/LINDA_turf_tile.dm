/turf/open
	var/icy = FALSE
	var/obj/effect/overlay/gas/iceoverlay

/turf/open/tile_graphic()
	. = ..()
	if(icy)
		. = istype(., /list) ? . : new/list // This is why DM is a bad language.
		if(!iceoverlay)
			iceoverlay = new
			iceoverlay.icon = 'icons/turf/overlays.dmi'
			iceoverlay.icon_state = "snowfloor"
			iceoverlay.layer = FROST_TURF_LAYER
			iceoverlay.alpha = 0
		animate(iceoverlay, alpha = 255, time = 10)
		. += iceoverlay
	else
		QDEL_NULL(iceoverlay)

/turf/open/process_cell(fire_count)
	. = ..()
	if(air.temperature < T0C && air.return_pressure() > 0.1)
		icy = TRUE
	else
		icy = FALSE
