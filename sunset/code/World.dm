//This file is just for the necessary /world definition
//Try looking in game/world.dm

/world
	mob = /mob/dead/new_player
	turf = /turf/open/space/basic
	area = /area/space
	view = "15x15"
	hub = "Exadv1.spacestation13"
	name = "/Sunset/ Station 13"
	fps = 60
#ifdef FIND_REF_NO_CHECK_TICK
	loop_checks = FALSE
#endif
