/obj/machinery/reagentgrinder/blender
	name = "Kitchen Blender"
	desc = "From BlenderTech. This blender will not only blend, it will look in place in your kitchen!"
	icon = 'sunset/icons/obj/kitchen.dmi'
	icon_state = "blender1"

/obj/machinery/reagentgrinder/blender/update_icon()
	if(beaker)
		icon_state = "blender1"
	else
		icon_state = "blender0"

/obj/machinery/reagentgrinder/blender/chemistry
	name = "Chemistry Blender"
	desc = "From BlenderTech. Guaranteed to blend whatever chemical concoctions you throw into it."
	icon = 'sunset/icons/obj/kitchen.dmi'
	icon_state = "blenderC1"

/obj/machinery/reagentgrinder/blender/chemistry/update_icon()
	if(beaker)
		icon_state = "blenderC1"
	else
		icon_state = "blenderC0"

/obj/machinery/reagentgrinder/blender/green
	name = "Green Blender"
	desc = "From BlenderTech. Guaranteed to be 100 percent identical as the other models when it comes to blending stuff!"
	icon = 'sunset/icons/obj/kitchen.dmi'
	icon_state = "blenderG1"

/obj/machinery/reagentgrinder/blender/green/update_icon()
	if(beaker)
		icon_state = "blenderG1"
	else
		icon_state = "blenderG0"

/obj/machinery/reagentgrinder/blender/purple
	name = "Green Blender"
	desc = "From BlenderTech. Guaranteed to be 100 percent grind whatever unnatural biological materials you place in it!"
	icon = 'sunset/icons/obj/kitchen.dmi'
	icon_state = "blenderP1"

/obj/machinery/reagentgrinder/blender/purple/update_icon()
	if(beaker)
		icon_state = "blenderP1"
	else
		icon_state = "blenderP0"