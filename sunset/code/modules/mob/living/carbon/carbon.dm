/mob/living/carbon/vomit(lost_nutrition = 10, blood = FALSE, stun = TRUE, distance = 1, message = TRUE, toxic = FALSE)
	if(!has_mouth())
		return 1
	. = .. ()

/mob/living/carbon/has_mouth()
	for(var/obj/item/bodypart/head/head in bodyparts)
		if(head.mouth)
			return TRUE
