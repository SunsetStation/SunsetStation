GLOBAL_VAR(iceoverlaymaster)

/turf/open
	var/icy = FALSE

/turf/open/tile_graphic()
	. = ..()
	if(icy)
		. = istype(., /list) ? . : new/list // This is why DM is a bad language.
		if(!GLOB.iceoverlaymaster)
			var/obj/effect/overlay/gas/iceoverlay = new()
			iceoverlay.icon = 'icons/turf/overlays.dmi'
			iceoverlay.icon_state = "snowfloor"
			iceoverlay.layer = FROST_TURF_LAYER
			GLOB.iceoverlaymaster = iceoverlay
		. += GLOB.iceoverlaymaster

/turf/open/process_cell(fire_count)
	. = ..()
	if(air.temperature < T0C && air.return_pressure() > 0.1)
		icy = TRUE
	else
		icy = FALSE