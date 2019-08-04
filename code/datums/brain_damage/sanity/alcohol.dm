/datum/brain_trauma/affliction/alcohol
	name = "Burden of Truth"
	desc = "You have seen what vast, terrible emptiness lies beyond, and know that it cannot be stopped. You drink to forget, and forget, and forget. Drink or your action speed is slowed"
	gain_text = "<span class='cult'>You have seen what vast, terrible emptiness lies beyond, and know that it cannot be stopped. You drink to forget, and forget, and forget. You must drink or risk losing yourself to despair. Drink or your action speed is slowed</span>"
	lose_text = "<span class='cult'>You no longer feel like drinking is all you can do.</span>"
	next_affliction = /datum/brain_trauma/affliction/alcohol/tier2
	var/action_speed_lowered = FALSE

/datum/brain_trauma/affliction/alcohol/on_life()
	. = ..()
	if(owner.drunkenness < 20) //20% drunkness, light slurring.
		slow_actionspeed()
	else
		raise_actionspeed()

//Called when removed from a mob
/datum/brain_trauma/affliction/alcohol/on_lose(silent)
	. = ..()
	if(action_speed_lowered)
		raise_actionspeed()
	if(owner.drunkenness > 80)
		to_chat(owner, "<span class='cult'>The kick of alcohol hits you, you feel your insides burning.</span>")
		owner.apply_damage(20, TOX)

/datum/brain_trauma/affliction/alcohol/proc/slow_actionspeed()
	if(action_speed_lowered)
		return
	action_speed_lowered = !action_speed_lowered
	owner.affliction_actionspeed_modifiers += 0.2

/datum/brain_trauma/affliction/alcohol/proc/raise_actionspeed()
	if(!action_speed_lowered)
		return
	owner.affliction_actionspeed_modifiers -= 0.2

/datum/brain_trauma/affliction/alcohol/tier2
	name = "Demon in a Bottle"
	desc = "You have seen what vast, terrible emptiness lies beyond, and know that it cannot be stopped. You drink to forget, and forget, and forget."
	gain_text = "<span class='cult'>The weight of reality bears down on you like a crushing vice. You move and act slower unless you are drunk.</span>"
	lose_text = "<span class='noculttice'>You no longer feel like drinking is all you can do.</span>"
	tier = 2

/datum/brain_trauma/affliction/alcohol/tier2/on_life()
	. = ..()
	if(owner.drunkenness < 20)
		owner.add_movespeed_modifier(MOVESPEED_ID_ALCOHOLAFFLICTION, TRUE, 100, override=TRUE, multiplicative_slowdown = 0.5)
	else
		owner.remove_movespeed_modifier(MOVESPEED_ID_ALCOHOLAFFLICTION, TRUE)

/datum/brain_trauma/affliction/alcohol/tier2/on_lose(silent)
	. = ..()
	owner.remove_movespeed_modifier(MOVESPEED_ID_ALCOHOLAFFLICTION, TRUE)



