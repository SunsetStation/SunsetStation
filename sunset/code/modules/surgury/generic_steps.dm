///////////////ROBOTIC STEPS///////////////
/datum/surgery_step/unscrew
	name = "unscrew cover"
	implements = list(/obj/item/screwdriver = 100, /obj/item/coin = 30)
	time = 20
/datum/surgery_step/unscrew/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	user.visible_message("<span class='notice'>[user] begins to unscrew the cover panel on [target]'s [parse_zone(target_zone)].</span>",
		"<span class='notice'>You begin to unscrew the cover panel on [target]'s [parse_zone(target_zone)]...</span>")
/datum/surgery_step/pry_off
	name = "pry off cover"
	implements = list(/obj/item/crowbar = 100)
	time = 30
/datum/surgery_step/pry_off/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	user.visible_message("<span class='notice'>[user] begins to pry open the cover panel on [target]'s [parse_zone(target_zone)].</span>",
		"<span class='notice'>You begin to pry open the cover panel on [target]'s [parse_zone(target_zone)]...</span>")
/datum/surgery_step/close_hatch
	name = "close cover"
	implements = list(/obj/item/crowbar = 100)
	time = 30
/datum/surgery_step/close_hatch/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	user.visible_message("<span class='notice'>[user] begins to put the cover panel on [target]'s [parse_zone(target_zone)] back in place.</span>",
	"<span class='notice'>You begin to put the cover panel on [target]'s [parse_zone(target_zone)] back in place...</span>")
/datum/surgery_step/robotic_amputation
	name = "disconnect limb"
	implements = list(/obj/item/multitool = 100, /obj/item/wirecutters = 10)
	time = 64
/datum/surgery_step/robotic_amputation/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(!istype(tool, /obj/item/multitool))
		user.visible_message("<span class='notice'>[user] begins to cut through the circuitry in [target]'s [parse_zone(target_zone)]!</span>", "<span class='notice'>You begin to cut through the circuitry in [target]'s [parse_zone(target_zone)]...</span>")
	else
		var/pro = pick("neatly", "calmly", "professionally", "carefully", "swiftly", "proficiently")
		user.visible_message("[user] begins to [pro] disconnect [target]'s [parse_zone(target_zone)]!", "<span class='notice'>You begin to [pro] disconnect [target]'s [parse_zone(target_zone)]...</span>")
/datum/surgery_step/robotic_amputation/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/mob/living/carbon/human/L = target
	user.visible_message("<span class='notice'>[user] removes [L]'s [parse_zone(target_zone)]!</span>", "<span class='notice'>You remove [L]'s [parse_zone(target_zone)].</span>")
	if(surgery.operated_bodypart)
		var/obj/item/bodypart/target_limb = surgery.operated_bodypart
		target_limb.drop_limb()
