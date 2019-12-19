// Robotic Tongue emotes. Beep!
/datum/emote/living/carbon/human/robot_tongue/can_run_emote(mob/user)
	if(!..())
		return FALSE
	var/obj/item/organ/tongue/T = user.getorganslot("tongue")
	if(T.status == ORGAN_ROBOTIC)
		return TRUE
/datum/emote/living/carbon/human/robot_tongue/beep
	key = "beep"
	key_third_person = "beeps"
	message = "beeps."
	message_param = "beeps at %t."
/datum/emote/living/carbon/human/robot_tongue/beep/run_emote(mob/user, params)
	if(..())
		playsound(user.loc, 'sound/machines/twobeep.ogg', 50)
/datum/emote/living/carbon/human/robot_tongue/buzz
	key = "buzz"
	key_third_person = "buzzes"
	message = "buzzes."
	message_param = "buzzes at %t."
/datum/emote/living/carbon/human/robot_tongue/buzz/run_emote(mob/user, params)
	if(..())
		playsound(user.loc, 'sound/machines/buzz-sigh.ogg', 50)
/datum/emote/living/carbon/human/robot_tongue/buzz2
	key = "buzz2"
	message = "buzzes twice."
/datum/emote/living/carbon/human/robot_tongue/buzz2/run_emote(mob/user, params)
	if(..())
		playsound(user.loc, 'sound/machines/buzz-two.ogg', 50)
/datum/emote/living/carbon/human/robot_tongue/chime
	key = "chime"
	key_third_person = "chimes"
	message = "chimes."
/datum/emote/living/carbon/human/robot_tongue/chime/run_emote(mob/user, params)
	if(..())
		playsound(user.loc, 'sound/machines/chime.ogg', 50)
/datum/emote/living/carbon/human/robot_tongue/ping
	key = "ping"
	key_third_person = "pings"
	message = "pings."
	message_param = "pings at %t."
/datum/emote/living/carbon/human/robot_tongue/ping/run_emote(mob/user, params)
	if(..())
		playsound(user.loc, 'sound/machines/ping.ogg', 50)
/datum/emote/living/carbon/human/robot_tongue/yes
	key = "yes"
	message = "blips affirmatively."
/datum/emote/living/carbon/human/robot_tongue/yes/run_emote(mob/user, params)
	if(..())
		playsound(user.loc, 'sunset/sound/effects/mob_effects/synth_yes.ogg', 50)
/datum/emote/living/carbon/human/robot_tongue/no
	key = "no"
	message = "buzzes negatively."
/datum/emote/living/carbon/human/robot_tongue/no/run_emote(mob/user, params)
	if(..())
		playsound(user.loc, 'sunset/sound/effects/mob_effects/synth_no.ogg', 50)
  // Clown Robotic Tongue ONLY. Henk.
/datum/emote/living/carbon/human/robot_tongue/clown/can_run_emote(mob/user)
	if(!..())
		return FALSE
	if(user.mind.assigned_role == "Clown")
		return TRUE
/datum/emote/living/carbon/human/robot_tongue/clown/honk
	key = "honk"
	key_third_person = "honks"
	message = "honks."
/datum/emote/living/carbon/human/robot_tongue/clown/honk/run_emote(mob/user, params)
	if(..())
		playsound(user.loc, 'sound/items/bikehorn.ogg', 50)
/datum/emote/living/carbon/human/robot_tongue/clown/sad
	key = "sad"
	key_third_person = "plays a sad trombone..."
	message = "plays a sad trombone..."
/datum/emote/living/carbon/human/robot_tongue/clown/sad/run_emote(mob/user, params)
	if(..())
		playsound(user.loc, 'sound/misc/sadtrombone.ogg', 50)
/datum/emote/living/deathgasp
	message_ipc = "gives one shrill beep before falling limp, their monitor flashing blue before completely shutting off..."
