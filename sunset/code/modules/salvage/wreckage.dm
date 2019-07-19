
/obj/structure/wreckage
	name = "wreckage remains"
	desc = "Remains of some kind of machine. Not much left, but maybe there is something to salvage?"
	icon = 'sunset/icons/obj/salvage_structure.dmi'
	icon_state = "wreck_remains"
	max_integrity = 50
	density = TRUE
	var/drops = list() //object to be dropped upon destruction, overwritten if randenable is set TRUE
	var/randenable = TRUE //mappers set to FALSE if they want the wreck to drop a specific item
	var/purity = 1 //changes the type of drops to make, higher is rarer
	density = TRUE

/obj/structure/wreckage/Initialize()
	. = ..()
	if (purity == 1)
		AddComponent(/datum/component/reclaimable, list( \
		SCRAP_METAL = SCRAP_METAL_STATS, \
		SCRAP_SILVER = SCRAP_SILVER_STATS, \
		SCRAP_GOLD = SCRAP_GOLD_STATS ))
	if (purity == 2)
		AddComponent(/datum/component/reclaimable, list( \
		SCRAP_METAL = SCRAP_METAL_STATS, \
		SCRAP_SILVER = SCRAP_SILVER_STATS, \
		SCRAP_GOLD = SCRAP_GOLD_STATS, \
		SCRAP_PLASMA = SCRAP_PLASMA_STATS ))
	if (purity == 3)
		AddComponent(/datum/component/reclaimable, list( \
		SCRAP_METAL = SCRAP_METAL_STATS, \
		SCRAP_SILVER = SCRAP_SILVER_STATS, \
		SCRAP_GOLD = SCRAP_GOLD_STATS, \
		SCRAP_PLASMA = SCRAP_PLASMA_STATS, \
		SCRAP_URANIUM = SCRAP_URANIUM_STATS ))
	if (purity == 4)
		AddComponent(/datum/component/reclaimable, list( \
		SCRAP_TITANIUM = SCRAP_TITANIUM_STATS, \
		SCRAP_GOLD = SCRAP_GOLD_STATS, \
		SCRAP_PLASMA = SCRAP_PLASMA_STATS, \
		SCRAP_URANIUM = SCRAP_URANIUM_STATS, \
		SCRAP_BLUESPACE = SCRAP_BLUESPACE_STATS ))


/obj/structure/wreckage/autolathe
	name = "Destroyed Autolathe"
	desc = "A heavily damaged autolathe, far beyond repair. Maybe there is something to salvage?"
	icon_state = "wreck_autolathe"
	purity = 1

/obj/structure/wreckage/protolathe
	name = "Ruined Protolathe"
	desc = "This protolathe doesnt look like its functioned in a long time. Maybe there is something to salvage?"
	icon_state = "wreck_protolathe"
	purity = 2

/obj/structure/wreckage/circuit_imprinter
	name = "Smashed Circuit Imprinter"
	desc = "This imprinter's printing days are long past it. Maybe there is something to salvage?"
	icon_state = "wreck_circuit_imprinter"
	purity = 2

/obj/structure/wreckage/destructive_analyser
	name = "Dented Destructive Analyser"
	desc = "If this thing could power up, it would probably slice you in half. Maybe there is someting to salvage?"
	icon_state = "wreck_d_analyzer"
	purity = 3

/obj/structure/wreckage/server
	name = "Retired Server"
	desc = "I dont think turning it off and on again wont fix this one. Maybe there is something to salvage?"
	icon_state = "wreck_server"
	purity = 4

/obj/structure/wreckage/console
	name = "Busted Console"
	desc = "I think something is living in there. Maybe there is something to salvage?"
	icon = 'sunset/icons/obj/computer.dmi'
	icon_state = "computer_broken"
	purity = 4

/obj/structure/wreckage/machine
	name = "Abandoned Terminal"
	desc = "It looks and smells burnt. Maybe there is something to salvage?"
	icon = 'sunset/icons/obj/pda.dmi'
	icon_state = "pdapainter-broken"
	purity = 3