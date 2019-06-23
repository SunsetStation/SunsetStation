#define ASH_WALKER_SPAWN_THRESHOLD 2
//The ash walker den consumes corpses or unconscious mobs to create ash walker eggs. For more info on those, check ghost_role_spawners.dm
/obj/structure/lavaland/ash_walker
	name = "necropolis tendril nest"
	desc = "A vile tendril of corruption. It's surrounded by a nest of rapidly growing eggs..."
	icon = 'icons/mob/nest.dmi'
	icon_state = "ash_walker_nest"

	move_resist=INFINITY // just killing it tears a massive hole in the ground, let's not move it
	anchored = TRUE
	density = TRUE

	resistance_flags = FIRE_PROOF | LAVA_PROOF
	max_integrity = 200


	var/faction = list("ashwalker")
	var/meat_counter = 6

/obj/structure/lavaland/ash_walker/Initialize()
	.=..()
	START_PROCESSING(SSprocessing, src)	

/obj/structure/lavaland/ash_walker/deconstruct(disassembled)
	new /obj/item/assembly/signaler/anomaly (get_step(loc, pick(GLOB.alldirs)))
	new	/obj/effect/collapse(loc)
	return ..()

/obj/structure/lavaland/ash_walker/process()
	consume()
	spawn_mob()

/obj/structure/lavaland/ash_walker/proc/consume()
	for(var/mob/living/M in view(src, 1)) //Only for corpse right next to/on same tile
		if(M.stat)
			visible_message("<span class='warning'>Serrated tendrils eagerly pull [M] to [src], tearing the body apart as its blood seeps over the eggs.</span>")
			playsound(get_turf(src),'sound/magic/demon_consume.ogg', 100, 1)
			for(var/obj/item/W in M)
				if(!M.dropItemToGround(W))
					qdel(W)
			if(ismegafauna(M))
				meat_counter += 20
			else
				meat_counter++
			M.gib()
			obj_integrity = min(obj_integrity + max_integrity*0.05,max_integrity)//restores 5% hp of tendril
		//else if(isashwalker(M))
		else // is supposed to be for ashwalkers only, but cannot figure out why this line breaks ( so anyone heals next to the tendrils/eggs for now)
			var/mob/living/carbon/human/H = M
			var/healed_damage = H.organ_damage_tracker
			for(var/thing in H.internal_organs)
				var/obj/item/organ/O = thing
				O.heal_damage(10)
			for(var/thing in H.bodyparts)
				var/obj/item/bodypart/B = thing
				if(B.broken)
					healed_damage++
					if(prob(15))
						B.fix_bone()
						to_chat(H, "<span class='notice'>You feel the bone in your [B] snap into place.</span>")

			healed_damage += H.maxHealth - H.health

			if(healed_damage)
				H.adjustFireLoss(-rand(2, 6))
				H.adjustBruteLoss(-rand(2, 6))
				H.adjustToxLoss(-rand(2, 6))
				H.adjustCloneLoss(-rand(2, 6))
				new /obj/effect/temp_visual/heal(get_turf(H), "#e21da3")
				if(prob(5))
					to_chat(H, "<span class='notice'>A soothing calm washes over you as your wounds heal! [pick(list("Praised be the Necropolis", "Glory to the Necropolis", "All hail the tentacle"))]!</span>")


/obj/structure/lavaland/ash_walker/proc/spawn_mob()
	if(meat_counter >= ASH_WALKER_SPAWN_THRESHOLD)
		new /obj/effect/mob_spawn/human/ash_walker(get_step(loc, pick(GLOB.alldirs)))
		visible_message("<span class='danger'>One of the eggs swells to an unnatural size and tumbles free. It's ready to hatch!</span>")
		meat_counter -= ASH_WALKER_SPAWN_THRESHOLD
