/obj/item/stack/rods/Initialize(mapload, new_amount, merge = TRUE)
  GLOB.rod_recipes = list ( \
  	new/datum/stack_recipe("grille", /obj/structure/grille, 2, time = 10, one_per_turf = 1, on_floor = 1), \
  	new/datum/stack_recipe("table frame", /obj/structure/table_frame, 2, time = 10, one_per_turf = 1, on_floor = 1), \
    )
