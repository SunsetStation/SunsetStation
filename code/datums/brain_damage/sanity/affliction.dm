/datum/brain_trauma/affliction
	name = "Affliction"
	desc = "You shouldn't be seeing this."
	scan_desc = "Terrors" //description when detected by a health scanner
	gain_text = "<span class='notice'>You feel afflicted.</span>"
	lose_text = "<span class='notice'>You no longer feel afflicted.</span>"
	random_gain = FALSE 
	resilience = TRAUMA_RESILIENCE_SANITY
	clonable = TRUE
	var/tier = 1
	var/next_affliction //What datum does this upgrade into?