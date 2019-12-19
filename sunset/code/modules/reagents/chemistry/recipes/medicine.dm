/datum/chemical_reaction/system_cleaner
	name = "System Cleaner"
	id = "system_cleaner"
	results = list("system_cleaner" = 4)
	required_reagents = list("ethanol" = 1, "chlorine" = 1, "phenol" = 1, "potassium" = 1)

/datum/chemical_reaction/liquid_solder
	name = "Liquid Solder"
	id = "liquid_solder"
	results = list("liquid_solder" = 3)
	required_reagents = list("ethanol" = 1, "copper" = 1, "silver" = 1)
	required_temp = 370
	mix_message = "The mixture becomes a metallic slurry."
