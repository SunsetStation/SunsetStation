/obj/item/reagent_containers/glass/bucket
	icon = 'sunset/icons/obj/janitor.dmi'
	species_fit = list("Vox Outcast")
	sprite_sheets = list(
	"Vox Outcast" = 'sunset/icons/mob/species/vox/head.dmi'
	)

/obj/item/reagent_containers/glass/bucket/update_icon()
	cut_overlays()

	if(reagents.total_volume)
		var/mutable_appearance/filling = mutable_appearance('sunset/icons/obj/janitor.dmi', "bucket_contents_empty")

		var/percent = round((reagents.total_volume / volume) * 100)
		switch(percent)
			if(0 to 1)
				filling.icon_state = "bucket_contents_empty"

			if(2 to INFINITY)
				filling.icon_state = "bucket_contents"

		filling.color = mix_color_from_reagents(reagents.reagent_list)
		add_overlay(filling)