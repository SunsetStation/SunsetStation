/mob/living/simple_animal/bot/medbot
	icon = 'sunset/icons/mob/aibots.dmi'
	icon_state = "grey"

/mob/living/simple_animal/bot/medbot/mysterious
	icon_state = "black"
	skin = "black"

/mob/living/simple_animal/bot/medbot/derelict
	icon_state = "black"
	skin = "black"

/mob/living/simple_animal/bot/medbot/update_icon()
	if(skin)
		icon_state = "[skin]"
		if(!on)
			icon_state = "[skin]-off"
			return
		if(IsStun() || IsParalyzed())
			icon_state = "[skin]-stunned"
			return
		if(mode == BOT_HEALING)
			icon_state = "[skin]-injecting"
			return
		else if(stationary_mode) //Bot has yellow light to indicate stationary mode.
			icon_state = "[skin]-standby"
	else
		icon_state = "grey"
		if(!on)
			icon_state = "grey-off"
			return
		if(IsStun() || IsParalyzed())
			icon_state = "grey-stunned"
			return
		if(mode == BOT_HEALING)
			icon_state = "grey-injecting"
			return
		else if(stationary_mode) //Bot has yellow light to indicate stationary mode.
			icon_state = "grey-standby"