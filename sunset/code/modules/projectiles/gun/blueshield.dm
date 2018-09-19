/obj/item/gun/energy/e_gun/blueshield
	name = "advanced stun revolver"
	desc = "An advanced stun revolver with the capacity to shoot both electrodes and lasers."
	icon_state = "bsgun"
	item_state = "gun"
	force = 7
	ammo_type = list(/obj/item/ammo_casing/energy/electrode/hos, /obj/item/ammo_casing/energy/laser/hos)
	ammo_x_offset = 1


//ENFORCER
/obj/item/gun/ballistic/automatic/pistol/enforcer
	name = "enforcer pistol"
	desc = "A lightweight .45 pistol for modern asset protection units. Smells like justice."
	icon_state = "enforcer_black"
	var/base_icon_state = "enforcer_black"
	mag_type = /obj/item/ammo_box/magazine/enforcer
	can_flashlight = TRUE
	unique_rename = TRUE
	unique_reskin = list("Default" = "enforcer_black",
						"Silver Finish" = "enforcer_silver",
						"Red Finish" = "enforcer_red",
						"Red Grip" = "enforcer_redgrip",
						"Green Finish" = "enforcer_green",
						"Green Grip" = "enforcer_greengrip",
						"Tan Finish" = "enforcer_tan",
						"Tan Grip" = "enforcer_tangrip"
						)
 /obj/item/gun/ballistic/automatic/pistol/enforcer/reskin_obj(mob/M)
	..()
	base_icon_state = icon_state
	update_icon()
 /obj/item/gun/ballistic/automatic/pistol/enforcer/update_icon()
	cut_overlays()
	icon_state = base_icon_state
	if(!chambered)
		icon_state += "-e"
	if(suppressed)
		add_overlay("enforcer_supp")
	if(gun_light)
		if(gun_light.on)
			add_overlay("enforcer_light-on")
		else
			add_overlay("enforcer_light")
 /obj/item/gun/ballistic/automatic/pistol/enforcer/ui_action_click()
	toggle_gunlight()

/obj/item/ammo_casing/rubber45
	name = ".45 rubber bullet casing"
	desc = "A .45 rubber bullet casing."
	caliber = ".45"
	projectile_type = /obj/item/projectile/bullet/weakbullet

/obj/item/ammo_casing/c45/nostamina
	name = ".45 lethal bullet casing"

/obj/item/ammo_box/r45
	name = "ammo box (.45 rubber)"
	icon_state = "45rbox"
	ammo_type = /obj/item/ammo_casing/rubber45
	max_ammo = 10

/obj/item/ammo_box/magazine/enforcer
	name = "pistol magazine (enforcer .45)"
	icon_state = "enforcer"
	desc = "A gun magazine. Compatible with the Enforcer series firearms."
	ammo_type = /obj/item/ammo_casing/rubber45
	max_ammo = 7
	caliber = ".45"
 /obj/item/ammo_box/magazine/enforcer/update_icon()
	icon_state = "enforcer-[stored_ammo.len]"
 /obj/item/ammo_box/magazine/enforcer/examine(mob/user)
	..()
	if(stored_ammo)
		var/obj/item/ammo_casing/A = stored_ammo[stored_ammo.len]
		to_chat(user, "TThere's a [A.name] at the top.")//it's either rubber or lead. better to know the difference
 /obj/item/ammo_box/magazine/enforcer/lethal
	ammo_type = /obj/item/ammo_casing/c45nostamina

/datum/design/r45
	name = "Ammo Box (.45 rubber)"
	build_type = AUTOLATHE
	materials = list(MAT_METAL = 30000)
	build_path = /obj/item/ammo_box/r45
	category = list("initial", "Security")
