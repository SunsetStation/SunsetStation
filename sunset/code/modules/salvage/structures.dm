
//im just filling stuff in here so its just here, i dont expect this to work at all or even compile at this point

/obj/item/circuitboard //the sweet meat of the makeshift structures
	name = "error"
	desc = "A control board that looks to be made by hand."
	icon = 'sunset/icons/obj/salvage.dmi'
	icon_state = "makeshift_circuit"
	var/circuit = "basic"

/obj/item/circuitboard/Initialize()
	name = "[circuit] control board"

/obj/machinery/makeshift
	name = "makeshift"
	desc = "You shouldnt be here."
	icon = 'sunset/icons/obj/salvage_structure.dmi'
	var/material = "Wooden" //use to define what variant to use. Wooden and Metal variants. purely cosmetic

/obj/machinery/makeshift/frame //needed to build basically everything listed here. made from scrap metal or wood.
	material = "Wooden"
	name = "error"
	desc = "A loosely assembled frame of parts and components."
	icon_state = "error"

/obj/machinery/makeshift/frame/Initialize()
	. = ..()
	name = "[material] Makeshift Frame"
	icon_state = "makeshift_frame_[material]"

/obj/machinery/makeshift/boardcrafter //circuit imprinter but it can only make boards for this stuff (atleast for now)
	material = "Wooden"
	name = "error"
	desc = "This workbench has various tools and parts to make electronics."
	icon_state = "error"

/obj/machinery/makeshift/boardcrafter/Initialize()
	. = ..()
	name = "[material] Board Crafter"
	icon_state = "board_crafter_[material]"

/obj/machinery/makeshift/assembler //discount autolathe but with some more added options
	material = "Wooden"
	name = "error"
	desc = "A simple assembling machine to make rudimentary and basic items."
	icon_state = "error"

/obj/machinery/makeshift/assembler/Initialize()
	. = ..()
	name = "[material] Assembler"
	icon_state = "assembler_[material]"

/obj/machinery/makeshift/matprocessor //discount orm without the mining points
	material = "Wooden"
	name = "error"
	desc = "This machine is able to take salvage and ore and turn it into more useful products."
	icon_state = "error"

/obj/machinery/makeshift/matprocessor/Initialize()
	. = ..()
	name = "[material] Material Processor"
	icon_state = "material_processor_[material]"

/obj/machinery/makeshift/generator //like a pacman except it runs off burnables
	material = "Wooden"
	name = "error"
	desc = "Makes some power for your machines and wakes the neighbors. You should really put a proper muffler on it."
	icon_state = "error"

/obj/machinery/makeshift/generator/Initialize()
	. = ..()
	name = "[material] Generator"
	icon_state = "generator_[material]"

/obj/machinery/makeshift/badsmes //its a battery array, not much else to add here
	material = "Wooden"
	name = "error"
	desc = "A group of energy cells connected to a control box. Some chump is going to be late to work."
	icon_state = "error"

/obj/machinery/makeshift/badsmes/Initialize()
	. = ..()
	name = "[material] Battery Bank"
	icon_state = "power_storage_[material]"