//Ported from /vg/station13, which was in turn forked from baystation12;
//Please do not bother them with bugs from this port, however, as it has been modified quite a bit.
//Modifications include removing the world-ending full supermatter variation, and leaving only the shard.

#define PLASMA_HEAT_PENALTY 15     // Higher == Bigger heat and waste penalty from having the crystal surrounded by this gas. Negative numbers reduce penalty.
#define OXYGEN_HEAT_PENALTY 1
#define CO2_HEAT_PENALTY 0.1
#define NITROGEN_HEAT_MODIFIER -1.5
//added
#define TRITIUM_HEAT_PENALTY 35
#define PLUOX_HEAT_PENALTY 6
#define HYPER_NOBLE_HEAT_MODIFIER -3.5

#define OXYGEN_TRANSMIT_MODIFIER 1.5   //Higher == Bigger bonus to power generation.
#define PLASMA_TRANSMIT_MODIFIER 4
//added
#define TRITIUM_TRANSMIT_MODIFIER 8
#define HYPER_NOBLE_TRANSMIT_MODIFIER 0.2
#define PLUOX_TRANSMIT_MODIFIER 3

#define N2O_HEAT_RESISTANCE 6          //Higher == Gas makes the crystal more resistant against heat damage.
//added
#define NITRYL_HEAT_RESISTANCE 14


/obj/machinery/power/supermatter_crystal
	var/tritcomp = 0
	var/hypnobcomp = 0
	var/pluoxcomp = 0
	var/nitcomp = 0


/obj/machinery/power/supermatter_crystal/process_atmos()
	. = ..()
	var/datum/gas_mixture/removed

	removed.assert_gases(/datum/gas/oxygen, /datum/gas/plasma, /datum/gas/carbon_dioxide, /datum/gas/nitrous_oxide, /datum/gas/nitrogen, /datum/gas/tritium, /datum/gas/hypernoblium, /datum/gas/pluoxium, /datum/gas/nitryl)

	tritcomp = max(removed.gases[/datum/gas/tritium][MOLES]/combined_gas, 0)
	hypnobcomp = max(removed.gases[/datum/gas/hypernoblium][MOLES]/combined_gas, 0)
	pluoxcomp = max(removed.gases[/datum/gas/pluoxium][MOLES]/combined_gas, 0)
	nitcomp = max(removed.gases[/datum/gas/nitryl][MOLES]/combined_gas, 0)

	gasmix_power_ratio = min(max(plasmacomp + o2comp + co2comp + tritcomp + pluoxcomp - n2comp - hypnobcomp, 0), 1)

	dynamic_heat_modifier = max((plasmacomp * PLASMA_HEAT_PENALTY)+(o2comp * OXYGEN_HEAT_PENALTY)+(co2comp * CO2_HEAT_PENALTY)+(tritcomp * TRITIUM_HEAT_PENALTY)+(pluoxcomp * PLUOX_HEAT_PENALTY)+(hypnobcomp * HYPER_NOBLE_HEAT_MODIFIER)+(n2comp * NITROGEN_HEAT_MODIFIER), 0.5)
	dynamic_heat_resistance = max((n2ocomp * N2O_HEAT_RESISTANCE)+(nitcomp * NITRYL_HEAT_RESISTANCE), 1)

	power_transmission_bonus = max((plasmacomp * PLASMA_TRANSMIT_MODIFIER) + (o2comp * OXYGEN_TRANSMIT_MODIFIER) + (tritcomp * TRITIUM_TRANSMIT_MODIFIER) + (hypnobcomp * HYPER_NOBLE_TRANSMIT_MODIFIER) + (pluoxcomp * PLUOX_TRANSMIT_MODIFIER) , 0)
