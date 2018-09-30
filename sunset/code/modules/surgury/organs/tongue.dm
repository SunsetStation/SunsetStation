/obj/item/organ/tongue/vox
	icon = 'sunset/icons/obj/surgery.dmi'
	name = "vox tongue"
	desc = "A half-robotic tongue, usually found inside a vox's.. Beak? You almost swear you can hear it shrieking."
	say_mod = "shrieks"
	icon_state = "tongue-vox"
	taste_sensitivity = 50 // There's not much need for taste when you're a scavenger.
	attack_verb = list("skree'd")
	status = ORGAN_ROBOTIC

/obj/item/organ/tongue/vox/TongueSpeech(var/message)
	if(prob(10))
		playsound(owner, 'sunset/sound/voice/shriek1.ogg', 25, 1, 1)
	return message

/obj/item/organ/tongue/robot/emp_act(severity)
	owner.emote("scream")
	to_chat(owner, "<span class='warning'>Alert: Vocal cords are malfunctioning.</span>")
