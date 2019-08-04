/datum/brain_trauma/affliction
	name = "Affliction"
	desc = "You shouldn't be seeing this."
	scan_desc = "Terrors" //description when detected by a health scanner
	gain_text = "<span class='cult'>You feel afflicted.</span>"
	lose_text = "<span class='cult'>You no longer feel afflicted.</span>"
	random_gain = FALSE 
	resilience = TRAUMA_RESILIENCE_SANITY
	clonable = TRUE
	var/tier = 1
	var/next_affliction //What datum does this upgrade into?

/datum/brain_trauma/affliction/proc/upgrade(var/datum/component/mood/M)
	var/mob/living/carbon/human/H = owner
	if(M.breakdowns >= 3)
		H.cure_trauma_type(M.current_affliction, TRAUMA_RESILIENCE_ABSOLUTE)
		M.current_affliction = H.gain_trauma(/datum/brain_trauma/affliction/overwhelming, TRAUMA_RESILIENCE_SANITY)
	if(!next_affliction)
		return FALSE //if this happens someone fucked up; fill in next_affliction retard
	
	H.cure_trauma_type(M.current_affliction, TRAUMA_RESILIENCE_ABSOLUTE, TRUE)
	M.current_affliction = H.gain_trauma(next_affliction, TRAUMA_RESILIENCE_SANITY)

/datum/brain_trauma/affliction/overwhelming
	name = "Shock death"
	desc = "All hells went over this mans mind."
	scan_desc = "Terrors" //description when detected by a health scanner
	gain_text = "<span class='cultlarge'>It becomes too much.</span>"
	lose_text = "<span class='cult'>The world is bearable again.</span>"
	tier = 3 //Last step to hell

/datum/brain_trauma/affliction/overwhelming/on_gain()
	. = ..()
	owner.hellbound = TRUE
	to_chat(owner, "<span class='cult'>You let out a final breath before the pain becomes too much.</span>")
	owner.adjustOxyLoss(200) //F