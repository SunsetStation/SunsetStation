/obj/item/blueshield_gun_package
	name = "Blueshield equipment box"
	desc = "You'll find the Blueshield's gun of choice inside. Schrödinger would be proud."
	w_class = WEIGHT_CLASS_SMALL
	icon = 'sunset/icons/obj/storage.dmi'
	icon_state = "blu-wrapped"
	var/list/options = list(".38 Mars Special Revolver" = /obj/item/storage/box/blueshield/revolver,
	".45 Enforcer Semi Automatic Pistol" = /obj/item/storage/box/blueshield/enforcer,
	"Aegis SG7 Laser Gun" = /obj/item/storage/box/blueshield/laser)

/obj/item/blueshield_gun_package/attack_self(mob/user)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	var/choice = input(H, "Choose your weapon!", "Blueshield Gun") as anything in options|null
	if(!choice || !Adjacent(H))
		return
	var/path_variable = options[choice]
	var/obj/item/storage/S = new path_variable(user)
	if(!istype(S))
		return
	user.put_in_hands(S)
	playsound(src.loc, 'sound/items/poster_ripped.ogg', 50, 1)
	qdel(src)

/obj/item/storage/box/blueshield
	desc = "It's a box filled with a Blueshield's equipment."
	icon = 'sunset/icons/obj/storage.dmi'
	illustration = "blu-box"

/obj/item/storage/box/blueshield/laser
	name = "Blueshield Equipment (Aegis SG7 laser gun)"

/obj/item/storage/box/blueshield/laser/PopulateContents()
	new /obj/item/gun/energy/e_gun/blueshield(src)

/obj/item/storage/box/blueshield/revolver //go and die please
	name = "Blueshield Equipment (.38 Mars Special revolver)"

/obj/item/storage/box/blueshield/revolver/PopulateContents()
	new /obj/item/gun/ballistic/revolver/detective(src)
	new /obj/item/ammo_box/c38(src)
	new /obj/item/ammo_box/c38(src)

/obj/item/storage/box/blueshield/enforcer
	name = "Blueshield Equipment (.45 Enforcer semi automatic pistol)"

/obj/item/storage/box/blueshield/enforcer/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/enforcer(src)
	new /obj/item/ammo_box/magazine/enforcer(src)
	new /obj/item/ammo_box/magazine/enforcer(src)
