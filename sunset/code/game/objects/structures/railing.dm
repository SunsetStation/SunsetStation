/obj/structure/railing
	name = "railing"
	desc = "Do not lean!"
	icon = 'sunset/icons/obj/railing.dmi'
	icon_state = "straight"
	density = TRUE

/obj/structure/railing/CanPass(atom/movable/mover, turf/target)
	if(get_dir(loc, target) == dir)
		return !density
	return TRUE

/obj/structure/railing/corner
	icon_state = "corner"
	var/no_no_dirs = NONE

/obj/structure/railing/corner/CanPass(atom/movable/mover, turf/target)
	switch(dir)
		if(SOUTH)
			no_no_dirs = WEST|NORTH
		if(NORTH)
			no_no_dirs = EAST|SOUTH
		if(EAST)
			no_no_dirs = EAST|NORTH
		if(WEST)
			no_no_dirs = WEST|SOUTH
	if(no_no_dirs & get_dir(loc, target))
		return !density
	return TRUE

/obj/structure/railing/corner/edge
	icon_state = "edge"

/obj/structure/railing/corner/end
	icon_state = "end"

/obj/structure/railing/construction
	icon_state = "construction_straight"

/obj/structure/railing/construction/corner
	icon_state = "construction_corner"
	var/no_no_dirs = NONE

/obj/structure/railing/construction/corner/CanPass(atom/movable/mover, turf/target)
	switch(dir)
		if(SOUTH)
			no_no_dirs = WEST|NORTH
		if(NORTH)
			no_no_dirs = EAST|SOUTH
		if(EAST)
			no_no_dirs = EAST|NORTH
		if(WEST)
			no_no_dirs = WEST|SOUTH
	if(no_no_dirs & get_dir(loc, target))
		return !density
	return TRUE

/obj/structure/railing/construction/corner/edge
	icon_state = "construction_edge"

/obj/structure/railing/construction/corner/end
	icon_state = "construction_end"