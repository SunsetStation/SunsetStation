/datum/emote/living/flip/run_emote(mob/user, params)
	if(..())
		user.SpinAnimation(5,1)

/datum/emote/living/scream
	key = "scream"
	key_third_person = "screams"
	message = "screams."
	message_mime = "acts out a scream!"
	emote_type = EMOTE_AUDIBLE
	cooldown = 100

/datum/emote/living/scream/run_emote(mob/user, params)
	if(!..())
		return

	var/sound_to_play = 'sound/effects/mob_effects/goonstation/male_scream.ogg'
	var/frequency_to_use = 1

	var/mob/living/carbon/human/H = user
	if(istype(H) && H.dna && H.dna.species)
		frequency_to_use = H.dna.species.get_age_frequency()
		if(H.gender == FEMALE)
			sound_to_play = H.dna.species.Hfemale_scream_sound
		else
			sound_to_play = H.dna.species.Hmale_scream_sound
	if(iscyborg(user))
		sound_to_play = 'sound/effects/mob_effects/goonstation/robot_scream.ogg'

	playsound(user.loc, sound_to_play, 50, frequency = frequency_to_use)

/datum/emote/living/cough
	key = "cough"
	key_third_person = "coughs"
	message = "coughs."
	message_mime = "seems to be coughing!"
	emote_type = EMOTE_AUDIBLE
	cooldown = 60

/datum/emote/living/cough/run_emote(mob/user, params)
	if(!..())
		return
	var/sound_to_play = 'sound/effects/mob_effects/m_cough.ogg'
	var/mob/living/carbon/human/H = user
	if(istype(H) && H.dna && H.dna.species)
		if(H.gender == FEMALE)
			sound_to_play = H.dna.species.Hfemale_cough_sound
		else
			sound_to_play = H.dna.species.Hmale_cough_sound
	if(iscyborg(user))
		sound_to_play = 'sound/effects/mob_effects/machine_cough.ogg'

	playsound(user.loc, sound_to_play, 50)

/datum/emote/living/sneeze
	key = "sneeze"
	key_third_person = "sneezes"
	message = "sneezes!"
	message_mime = "seems to be sneezing!"
	emote_type = EMOTE_AUDIBLE
	cooldown = 60

/datum/emote/living/sneeze/run_emote(mob/user, params)
	if(!..())
		return
	var/sound_to_play = 'sound/effects/mob_effects/sneeze.ogg'
	var/mob/living/carbon/human/H = user
	if(istype(H) && H.dna && H.dna.species)
		if(H.gender == FEMALE)
			sound_to_play = H.dna.species.Hfemale_sneeze_sound
		else
			sound_to_play = H.dna.species.Hmale_sneeze_sound
	if(iscyborg(user))
		sound_to_play = 'sound/effects/mob_effects/machine_sneeze.ogg'

	playsound(user.loc, sound_to_play, 50)
