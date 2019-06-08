/datum/brain_trauma/affliction/hemophobia
	name = "Hemophobia"
	desc = "Extreme hemophobia"
	gain_text = "<span class='cult'>The moon runs red. Blood rolls up the hills and rains into the sky. You lose sanity faster when bleeding or covered in blood</span>"
	lose_text = "<span class='cult'>The blood is no longer a fear.</span>"
	next_affliction = /datum/brain_trauma/affliction/alcoholtier2

/datum/brain_trauma/affliction/hemophobia/on_gain()
	. = ..()
	owner.add_trait(TRAIT_HEMOPHOBIA, "hemophobia")
		
/datum/brain_trauma/affliction/hemophobia/on_lose(silent)
	. = ..()
	owner.remove_trait(TRAIT_HEMOPHOBIA, "hemophobia")

/datum/brain_trauma/affliction/hemophobia/tier2
	name = "Undone by the blood"
	gain_text = "<span class='cult'>You feel the blood mites gnaw at your veins, screaming at you to expunge the unholy crimson from your body. You lose blood faster while bleeding</span>"
	tier = 2

/datum/brain_trauma/affliction/hemophobia/tier2/on_gain()
	. = ..()
	owner.add_trait(TRAIT_EXTREME_HEMOPHOBIA, "extreme_hemophobia")

		
/datum/brain_trauma/affliction/hemophobia/tier2/on_lose(silent)
	. = ..()
	owner.add_trait(TRAIT_EXTREME_HEMOPHOBIA, "extreme_hemophobia")



