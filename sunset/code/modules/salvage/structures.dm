
//************************************
//
//	TODO: Make structures work
//
//************************************

/obj/item/circuitboard/machine/controlboard //the sweet meat of the makeshift structures
	name = "error"
	desc = "A control board that looks to be made by hand."
	icon = 'sunset/icons/obj/salvage.dmi'
	icon_state = "makeshift_circuit"
	var/material = "error"

/obj/item/circuitboard/machine/controlboard
	name = "Board Crafter (Control Board)"
	build_path = /obj/machinery/makeshift/boardcrafter
	req_components = list(
		/obj/item/stock_parts/makeshift/matter_bin = 1,
		/obj/item/stock_parts/makeshift/capacitor = 1,
		/obj/item/stack/cable_coil = 1)

/obj/item/circuitboard/machine/controlboard/assembler
	name = "Assembler (Control Board)"
	build_path = /obj/machinery/makeshift/assembler
	req_components = list(
		/obj/item/stock_parts/makeshift/matter_bin = 1,
		/obj/item/stock_parts/makeshift/manipulator = 1)

/obj/item/circuitboard/machine/controlboard/matprocessor
	name = "Material Processor (Control Board)"
	build_path = /obj/machinery/makeshift/matprocessor
	req_components = list(
		/obj/item/stock_parts/makeshift/scanning_module = 1,
		/obj/item/stock_parts/makeshift/manipulator = 1,
		/obj/item/stock_parts/makeshift/capacitor = 1)

/obj/item/circuitboard/machine/controlboard/generator
	name = "Generator (Control Board)"
	build_path = /obj/machinery/makeshift/generator
	req_components = list(
		/obj/item/stock_parts/makeshift/micro_laser = 1,
		/obj/item/stock_parts/makeshift/capacitor = 1,
		/obj/item/stack/cable_coil = 1)

/obj/item/circuitboard/machine/controlboard/badsmes
	name = "Battery Bank (Control Board)"
	build_path = /obj/machinery/makeshift/badsmes
	req_components = list(
		/obj/item/stock_parts/makeshift/scanning_module = 1,
		/obj/item/stock_parts/makeshift/capacitor = 1,
		/obj/item/stack/cable_coil = 1)

//===================
//makeshift building frames and base object
//===================

/obj/machinery/makeshift
	name = "makeshift"
	desc = "You shouldnt be here."
	icon = 'sunset/icons/obj/salvage_structure.dmi'
	var/material = "Wooden" //use to define what variant to use. Wooden and Metal variants. purely cosmetic
	density = TRUE

/obj/structure/makeshift/frame //needed to build basically everything listed here. made from scrap metal or wood.
	name = "frame"
	desc = "i didnt initialize correctly"
	icon = 'sunset/icons/obj/salvage_structure.dmi'
	icon_state = "error"
	var/material = "Wooden"
	density = TRUE

/obj/structure/makeshift/frame/wood
	material = "Wooden"
	name = "Wooden Makeshift Frame"
	desc = "A loosely assembled frame of parts and components."
	icon_state = "makeshift_frame_Wooden"

/obj/structure/makeshift/frame/metal
	material = "Metal"
	name = "Metal Makeshift Frame"
	desc = "A loosely assembled frame of parts and components."
	icon_state = "makeshift_frame_Metal"

//===================
//board crafter
//===================

/obj/machinery/makeshift/boardcrafter //circuit imprinter but it can only make boards for this stuff (atleast for now)
	material = "Wooden"
	name = "i didnt initialize correctly"
	desc = "This workbench has various tools and parts to make electronics."
	icon_state = "error"

/obj/machinery/makeshift/boardcrafter/Initialize()
	. = ..()
	name = "[material] Board Crafter"
	icon_state = "board_crafter_[material]"

//===================
//makeshift assembler
//===================

/obj/machinery/makeshift/assembler //discount autolathe but with some more added options
	material = "Wooden"
	name = "i didnt initialize correctly"
	desc = "A simple assembling machine to make rudimentary and basic items."
	icon_state = "error"

/obj/machinery/makeshift/assembler/Initialize()
	. = ..()
	name = "[material] Assembler"
	icon_state = "assembler_[material]"

/obj/machinery/makeshift/matprocessor //discount orm without the mining points
	material = "Wooden"
	name = "i didnt initialize correctly"
	desc = "This machine is able to take salvage and ore and turn it into more useful products."
	icon_state = "error"

/obj/machinery/makeshift/matprocessor/Initialize()
	. = ..()
	name = "[material] Material Processor"
	icon_state = "material_processor_[material]"

//===================
//makeshift generator
//===================

/obj/machinery/makeshift/generator //like a pacman except it runs off burnables
	material = "Wooden"
	name = "i didnt initialize correctly"
	desc = "Makes some power for your machines and wakes the neighbors. You should really put a proper muffler on it."
	icon_state = "error"

/obj/machinery/makeshift/generator/Initialize()
	. = ..()
	name = "[material] Generator"
	icon_state = "generator_[material]"

//===================
//battery bank
//===================

/obj/machinery/makeshift/badsmes //its a battery array, not much else to add here
	material = "Wooden"
	name = "i didnt initialize correctly"
	desc = "A group of energy cells connected to a control box. Some chump is going to be late to work."
	icon_state = "error"

/obj/machinery/makeshift/badsmes/Initialize()
	. = ..()
	name = "[material] Battery Bank"
	icon_state = "power_storage_[material]"

//===================
//portable floodlight
//===================

/obj/structure/makeshift/floodlight
	name = "rugged floodlight"
	desc = "A tough and sturdy halo light with an internal power source. Good for outposts and work sites."
	icon = 'sunset/icons/obj/salvage_structure.dmi'
	icon_state = "floodlight"
	var/active = FALSE
	density = TRUE

/obj/structure/makeshift/floodlight/Initialize()
	. = ..()
	light_color = LIGHT_COLOR_WHITE
	if(active)
		update_icon()

/obj/structure/makeshift/floodlight/update_icon()
	icon_state = active ? "floodlight_on" : "floodlight"

/obj/structure/makeshift/floodlight/attack_hand(mob/user)
	active = !active
	active ? set_light(10) : set_light(0)
	update_icon()

//===================
//manually-operated airlock
//===================

/obj/structure/mineral_door/airlock
	name = "manual airlock"
	desc = "A heavy, hand-operated airlock. Slow, but tough."
	icon = 'sunset/icons/obj/salvage_structure.dmi'
	icon_state = "airlock"
	max_integrity = 800
	openSound = 'sunset/sound/effects/handlock_open.ogg'
	closeSound = 'sunset/sound/effects/handlock_close.ogg'
	opacity = FALSE
	rad_insulation = RAD_HEAVY_INSULATION
	sheetType = /obj/item/stack/ore/salvage/scrapmetal
	sheetAmount = 6
