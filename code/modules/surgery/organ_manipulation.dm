/datum/surgery/organ_manipulation
	name = "organ manipulation"
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_CHEST, BODY_ZONE_HEAD)
	bodypart_types = BODYPART_ORGANIC
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/retract_skin,
		/datum/surgery_step/saw,
		/datum/surgery_step/clamp_bleeders,
		/datum/surgery_step/incise,
		/datum/surgery_step/manipulate_organs,
		//there should be bone fixing
		/datum/surgery_step/close
		)

/datum/surgery/organ_manipulation/soft
	possible_locs = list(BODY_ZONE_PRECISE_GROIN, BODY_ZONE_PRECISE_EYES, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/retract_skin,
		/datum/surgery_step/clamp_bleeders,
		/datum/surgery_step/incise,
		/datum/surgery_step/manipulate_organs,
		/datum/surgery_step/close
		)

/datum/surgery/organ_manipulation/alien
	name = "alien organ manipulation"
	possible_locs = list(BODY_ZONE_CHEST, BODY_ZONE_HEAD, BODY_ZONE_PRECISE_GROIN, BODY_ZONE_PRECISE_EYES, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)
	target_mobtypes = list(/mob/living/carbon/alien/humanoid)
	steps = list(
		/datum/surgery_step/saw,
		/datum/surgery_step/incise,
		/datum/surgery_step/retract_skin,
		/datum/surgery_step/saw,
		/datum/surgery_step/manipulate_organs,
		/datum/surgery_step/close
		)

/datum/surgery/organ_manipulation/mechanic
	name = "prosthesis organ manipulation"
	possible_locs = list(BODY_ZONE_CHEST, BODY_ZONE_HEAD)
	bodypart_types = BODYPART_ROBOTIC
	lying_required = FALSE
	self_operable = TRUE
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/open_hatch,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/manipulate_organs,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/mechanic_close
		)

/datum/surgery/organ_manipulation/mechanic/soft
	possible_locs = list(BODY_ZONE_PRECISE_GROIN, BODY_ZONE_PRECISE_EYES, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/open_hatch,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/manipulate_organs,
		/datum/surgery_step/mechanic_close
		)

/datum/surgery_step/manipulate_organs
	time = 64
	name = "manipulate organs"
	repeatable = 1
	implements = list(/obj/item/organ = 100, /obj/item/reagent_containers/food/snacks/organ = 0, /obj/item/organ_storage = 100, /obj/item/mmi = 100)
	var/implements_mend = list(/obj/item/cautery = 100, /obj/item/weldingtool = 70, /obj/item/lighter = 45, /obj/item/match = 20)
	var/implements_extract = list(/obj/item/hemostat = 100, TOOL_CROWBAR = 55)
	var/implements_heal = list(/obj/item/stack/medical/bruise_pack = 90, /obj/item/stack/medical/gauze = 55, /obj/item/stack/medical/gauze/improvised = 35)
	//var/implements_heal_robotic = list(/obj/item/stack/nanopaste = 100, /obj/item/screwdriver = 30)
	var/current_type
	var/mend_the_incision = "mend the incision in"//so we can reuse the whole thing for robotic surgery
	var/mends_the_incision = "mends the incision in"
	var/list/healed_organs = list()
	var/list/healed_organ_name_list = list()//only for the names, because english_list() works weird when it gets datums
	var/obj/item/organ/I = null

/datum/surgery_step/manipulate_organs/New()
	..()
	implements = implements + implements_extract + implements_heal + implements_mend

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
			return -1
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
	if(isorgan(tool))
		current_type = "insert"
		I = tool
		if(target_zone != I.zone || target.getorganslot(I.slot))
			to_chat(user, "<span class='notice'>There is no room for [I] in [target]'s [parse_zone(target_zone)]!</span>")
			return -1

		user.visible_message("<span class='notice'>[user] begins to insert [tool] into [target]'s [parse_zone(target_zone)].</span>",
			"<span class='notice'>You begin to insert [tool] into [target]'s [parse_zone(target_zone)]...</span>")

	else if(implement_type in implements_extract)
		current_type = "extract"
		var/list/organs = target.getorganszone(target_zone)
		if(!organs.len)
			to_chat(user, "<span class='notice'>There are no removable organs in [target]'s [parse_zone(target_zone)]!</span>")
			return -1
		else
			for(var/obj/item/organ/O in organs)
				O.on_find(user)
				organs -= O
				organs[O.name] = O

			I = input("Remove which organ?", "Surgery", null, null) as null|anything in organs
			if(I && user && target && user.Adjacent(target) && user.get_active_held_item() == tool)
				I = organs[I]
				if(!I)
					return -1
				user.visible_message("<span class='notice'>[user] begins to extract [I] from [target]'s [parse_zone(target_zone)].</span>",
					"<span class='notice'>You begin to extract [I] from [target]'s [parse_zone(target_zone)]...</span>")
			else
				return -1

	else if(istype(tool, /obj/item/reagent_containers/food/snacks/organ))
		to_chat(user, "<span class='warning'>[tool] was bitten by someone! It's too damaged to use!</span>")
		return -1
	
	else if(implement_type in implements_heal)
		current_type = "heal"
		for(var/obj/item/organ/O in target.internal_organs)
			if(O.zone == target_zone && O.get_damage_perc() && O.status == ORGAN_ORGANIC)
				healed_organs += O
				healed_organ_name_list += O.name
		if(healed_organs.len)
			user.visible_message("<span class='notice'>[user] begins to mend the damage to [target]'s [english_list(healed_organ_name_list)].</span>",
			"<span class='warning'>You begin to mend the internal damage to [target]'s [english_list(healed_organ_name_list)]!</span>")
		else
			to_chat(user, "<span class='warning'>It doesn't look like there's anything to fix in [target]'s [parse_zone(target_zone)]!</span>")
			return -1

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
	if(current_type == "insert")
		if(istype(tool, /obj/item/organ_storage))
			I = tool.contents[1]
			tool.icon_state = initial(tool.icon_state)
			tool.desc = initial(tool.desc)
			tool.cut_overlays()
			tool = I
		else
			I = tool
		user.temporarilyRemoveItemFromInventory(I, TRUE)
		I.Insert(target)
		user.visible_message("<span class='notice'>[user] inserts [tool] into [target]'s [parse_zone(target_zone)]!</span>",
			"<span class='notice'>You insert [tool] into [target]'s [parse_zone(target_zone)].</span>")

	else if(current_type == "extract")
		if(I && I.owner == target)
			user.visible_message("<span class='notice'>[user] successfully extracts [I] from [target]'s [parse_zone(target_zone)]!</span>",
				"<span class='notice'>You successfully extract [I] from [target]'s [parse_zone(target_zone)].</span>")
			log_combat(user, target, "surgically removed [I.name] from", addition="INTENT: [uppertext(user.a_intent)]")
			I.Remove(target)
			I.forceMove(get_turf(target))
		else
			user.visible_message("<span class='notice'>[user] can't seem to extract anything from [target]'s [parse_zone(target_zone)]!</span>",
				"<span class='notice'>You can't extract anything from [target]'s [parse_zone(target_zone)]!</span>")
	else if(current_type == "heal")
		if(istype(tool, /obj/item/stack/))
			var/obj/item/stack/stack = tool
			if(!stack.use(1))
				to_chat(user, "<span class='warning'>You'll need more [tool] for this!</span>")//this should never happen, since we only need 1
				return 0

		user.visible_message("<span class='notice'>[user] successfully mends the damage to [target]'s [english_list(healed_organs)]!</span>",
			"<span class='notice'>You successfully mend the damage to [target]'s [english_list(healed_organs)].</span>")
		for(var/obj/item/organ/O in healed_organs)
			O.set_damage(0)
			O.on_full_heal()
	return 0
