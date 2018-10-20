/datum/sunset/cryo_store
    var/cryo_cell
    var/name
    var/access
    var/contents
	var/uniform = null
	var/suit = null
	var/back = null
	var/belt = null
	var/gloves = null
	var/shoes = null
	var/head = null
	var/mask = null
	var/neck = null
	var/ears = null
	var/glasses = null
	var/l_pocket = null
	var/r_pocket = null
	var/suit_store = null
	var/r_hand = null
	var/l_hand = null

/datum/sunset/cryo_store/New(mob/living/carbon/C,/obj/machinery/cryopod/P
    cryo_cell = P
    name = C.real_name
    access = C.wear_id.access
    uniform = getItemAndContentsAndSlapItIntoCryopodContents(C.w_uniform)
    suit = getItemAndContentsAndSlapItIntoCryopodContents(C.wear_suit)
    back = getItemAndContentsAndSlapItIntoCryopodContents(C.back)
    belt = getItemAndContentsAndSlapItIntoCryopodContents(C.belt)
    gloves = getItemAndContentsAndSlapItIntoCryopodContents(C.gloves)
    shoes = getItemAndContentsAndSlapItIntoCryopodContents(C.shoes)
    head = getItemAndContentsAndSlapItIntoCryopodContents(C.head)
    mask = getItemAndContentsAndSlapItIntoCryopodContents(C.wear_mask)
    neck = getItemAndContentsAndSlapItIntoCryopodContents(C.wear_neck)
    ears = getItemAndContentsAndSlapItIntoCryopodContents(C.ears)
    glasses = getItemAndContentsAndSlapItIntoCryopodContents(C.glasses)
    
    
/datum/sunset/cryo_store/getItemAndContentsAndSlapItIntoCryopodContents(var/O) //the name is just glorius right?
    if(QDELETED(O))
        return
    var/list/items = list()
    items |= O
    if(SEND_SIGNAL(O, COMSIG_CONTAINS_STORAGE))
        SEND_SIGNAL(O, COMSIG_TRY_STORAGE_RETURN_INVENTORY, items, TRUE)
    for(atom/movable/A in items)
        A.forceMove(cryo_cell)
    return items