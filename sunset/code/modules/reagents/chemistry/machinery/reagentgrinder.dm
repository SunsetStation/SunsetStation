
#define MILK_TO_BUTTER_COEFF 15

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

