/obj/structure/closet/crate/freezer/blood
	name = "Blood freezer"
	desc = "A freezer containing packs of blood. It has the medical logo on it."
	icon = 'sunset/icons/obj/crates.dmi'
	icon_state = "freezer_b"

/obj/structure/closet/crate/freezer/blood/PopulateContents()
	new /obj/item/reagent_containers/blood(src)
	new /obj/item/reagent_containers/blood(src)
	new /obj/item/reagent_containers/blood/AMinus(src)
	new /obj/item/reagent_containers/blood/BMinus(src)
	new /obj/item/reagent_containers/blood/BPlus(src)
	new /obj/item/reagent_containers/blood/OMinus(src)
	new /obj/item/reagent_containers/blood/OPlus(src)
	new /obj/item/reagent_containers/blood/lizard(src)
	new /obj/item/reagent_containers/blood/vox(src)
	for(var/i in 1 to 3)
		new /obj/item/reagent_containers/blood/random(src)

/obj/structure/closet/crate/freezer/surplus_limbs
	name = "Surplus Prosthetic Limbs"
	desc = "A crate containing an assortment of cheap prosthetic limbs."
	icon = 'sunset/icons/obj/crates.dmi'
	icon_state = "freezer_b"