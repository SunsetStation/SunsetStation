
/datum/disease/transformation/lizard
	name = "Heat-Lamp Syndrome"
	max_stages = 5
	cure_text = "Milk"
	cures = list("milk")
	agent = "lizard tears"
	desc = "This disease turns its victim into a small lizard."
	viable_mobtypes = list(/mob/living/carbon/human)
	severity = DISEASE_SEVERITY_HARMFUL
	visibility_flags = 0
	stage1 = list("You feel dry.")
	stage2 = list("You feel like following the janitor.")
	stage3 = list("<span class='danger'>Your skin feels a bit... scaly.</span>")
	stage4 = list("<span class='danger'>A juicy roach sounds delicious right about now.</span>")
	stage5 = list("<span class='danger'>It's too cold in here!</span>", "<span class='danger'>You feel small...</span>")
	new_form = /mob/living/simple_animal/hostile/lizard
	var/datum/species/lizard/lizard = new /datum/species/lizard()

/datum/disease/transformation/lizard/stage_act()
	..()
	switch(stage)
		if(3)
			if (prob(10))
				affected_mob.say(pick("Hiss!"))
		if(4)
			affected_mob.set_species(lizard)
		if(5)
			if (prob(20))
				affected_mob.say(pick("Hisss!", "Ssskree!", "HISSS!!"))