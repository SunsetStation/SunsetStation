/obj/item/reagent_containers/blood/random/Initialize()
	blood_type = pick("A+", "A-", "B+", "B-", "O+", "O-", "L", "F", "V")
	. = ..()

/obj/item/reagent_containers/blood/vox
	blood_type = "V"
