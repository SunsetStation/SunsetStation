/mob/living/carbon/human/handle_blood()

	if(NOBLOOD in dna.species.species_traits)
		bleed_rate = 0
		return

	if(bodytemperature >= TCRYO && !(has_trait(TRAIT_HUSK))) //cryosleep or husked people do not pump the blood.

		//Blood regeneration if there is some space
		if(blood_volume < BLOOD_VOLUME_NORMAL && !has_trait(TRAIT_NOHUNGER))
			var/nutrition_ratio = 0
			switch(nutrition)
				if(0 to NUTRITION_LEVEL_STARVING)
					nutrition_ratio = 0.2
				if(NUTRITION_LEVEL_STARVING to NUTRITION_LEVEL_HUNGRY)
					nutrition_ratio = 0.4
				if(NUTRITION_LEVEL_HUNGRY to NUTRITION_LEVEL_FED)
					nutrition_ratio = 0.6
				if(NUTRITION_LEVEL_FED to NUTRITION_LEVEL_WELL_FED)
					nutrition_ratio = 0.8
				else
					nutrition_ratio = 1
			if(satiety > 80)
				nutrition_ratio *= 1.25
			nutrition = max(0, nutrition - nutrition_ratio * HUNGER_FACTOR)
			blood_volume = min(BLOOD_VOLUME_NORMAL, blood_volume + 0.5 * nutrition_ratio)

		//Effects of bloodloss
		var/word = pick("dizzy","woozy","faint")
		switch(blood_volume)
			if(BLOOD_VOLUME_OKAY to BLOOD_VOLUME_SAFE)
				if(prob(5))
					to_chat(src, "<span class='warning'>You feel [word].</span>")
				if(prob(4.5))
					if(prob(50))
						Paralyze(30)
					else
						Stun(30)
				adjustOxyLoss(round((BLOOD_VOLUME_NORMAL - blood_volume) * 0.01, 1))
			if(BLOOD_VOLUME_BAD to BLOOD_VOLUME_OKAY)
				adjustOxyLoss(round((BLOOD_VOLUME_NORMAL - blood_volume) * 0.02, 1))
				if(prob(5))
					blur_eyes(6)
					to_chat(src, "<span class='warning'>You feel very [word].</span>")
				if(prob(7.5))
					if(prob(50))
						Knockdown(45)
					else
						Stun(45)
			if(BLOOD_VOLUME_ARREST to BLOOD_VOLUME_BAD)
				adjustOxyLoss(5)
				if(prob(15))
					Unconscious(rand(20,60))
					to_chat(src, "<span class='warning'>You feel extremely [word].</span>")
				if(prob(17.5))
					if(prob(50))
						Paralyze(75)
					else
						Stun(75)
			if(BLOOD_VOLUME_SURVIVE to BLOOD_VOLUME_ARREST)
				if(prob(45)) //it doesn't instantly happen, you still have a chance to start chugging iron or hook yourself to an IV if possible
					if(stat == CONSCIOUS)
						visible_message("<span class='danger'>[src] clutches at [p_their()] chest as if [p_their()] heart is stopping!</span>", "<span class='userdanger'>It feels as if your heart has stopped!</span>")
					stop_sound_channel(CHANNEL_HEARTBEAT)
					playsound_local(src, 'sound/effects/singlebeat.ogg', 100, 0)
					set_heartattack(TRUE)
			if(-INFINITY to BLOOD_VOLUME_SURVIVE)
				if(!has_trait(TRAIT_NODEATH))
					death()

		var/temp_bleed = 0
		//Bleeding out
		for(var/X in bodyparts)
			var/obj/item/bodypart/BP = X
			var/brutedamage = BP.brute_dam

			//We want an accurate reading of .len
			listclearnulls(BP.embedded_objects)
			temp_bleed += 0.5*BP.embedded_objects.len

			if(brutedamage >= 20)
				temp_bleed += (brutedamage * 0.013)

		bleed_rate = max(bleed_rate - 0.5, temp_bleed)//if no wounds, other bleed effects (heparin) naturally decreases

		if(bleed_rate && !bleedsuppress && !(has_trait(TRAIT_FAKEDEATH)))
			bleed(bleed_rate)