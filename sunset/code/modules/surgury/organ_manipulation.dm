/datum/surgery/organ_manipulation

	bodypart_types = BODYPART_ORGANIC

/datum/surgery_step/manipulate_organs
	implements = list(/obj/item/organ = 100, /obj/item/reagent_containers/food/snacks/organ = 0, /obj/item/organ_storage = 100, /obj/item/mmi = 100)
	var/mend_the_incision = "mend the incision in"//so we can reuse the whole thing for robotic surgery
	var/mends_the_incision = "mends the incision in"
	var/implements_mend = list(/obj/item/cautery = 100, /obj/item/weldingtool = 70, /obj/item/lighter = 45, /obj/item/match = 20)


/datum/surgery_step/manipulate_organs/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	I = null
	if(istype(tool, /obj/item/organ_storage))
		if(!tool.contents.len)
			to_chat(user, "<span class='notice'>There is nothing inside [tool]!</span>")
			return -1
		I = tool.contents[1]
		if(!isorgan(I))
			to_chat(user, "<span class='notice'>You cannot put [I] into [target]'s [parse_zone(target_zone)]!</span>")
			return -1
		tool = I
	if(istype(tool, /obj/item/mmi))//this whole thing is only used for robotic surgery in organ_mani_robotic.dm :*
		current_type = "posibrain"
		var/obj/item/bodypart/affected = target.get_bodypart(check_zone(target_zone))
		if(!affected)
			return -1
		if(affected.status != ORGAN_ROBOTIC)
			to_chat(user, "<span class='notice'>You can't put [tool] into a meat enclosure!</span>")
			return -1
		if(!isipc(target))
			to_chat(user, "<span class='notice'>[target] does not have the proper connectors to interface with [tool].</span>")
			return -1
		if(target_zone != "chest")
			to_chat(user, "<span class='notice'>You have to install [tool] in [target]'s chest!</span>")
		if(target.internal_organs_slot["brain"])
			to_chat(user, "<span class='notice'>[target] already has a brain! You'd rather not find out what would happen with two in there.</span>")
			return -1
		var/obj/item/mmi/P = tool
		if(!istype(P))
			return -1
		if(!P.brainmob || !P.brainmob.client)
			to_chat(user, "<span class='notice'>[tool] has no life in it, this would be pointless!</span>")
			return -1
		user.visible_message("<span class='notice'>[user] begins to insert [tool] into [target]'s [parse_zone(target_zone)].</span>",
			"<span class='notice'>You begin to insert [tool] into [target]'s [parse_zone(target_zone)]...</span>")
	. = .. ()

/datum/surgery_step/manipulate_organs/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(current_type == "posibrain")
		if(istype(tool, /obj/item/organ_storage))
			tool.icon_state = "evidenceobj"
			tool.desc = "A container for holding body parts."
			tool.cut_overlays()
			tool = tool.contents[1]
 		user.temporarilyRemoveItemFromInventory(tool)
		spawn(1)
			I = new /obj/item/organ/brain/mmi_holder/posibrain(tool)
			I.Insert(target)
			user.visible_message("<span class='notice'>[user] inserts [tool] into [target]'s [parse_zone(target_zone)]!</span>",
				"<span class='notice'>You insert [tool] into [target]'s [parse_zone(target_zone)].</span>")
	. = .. ()
