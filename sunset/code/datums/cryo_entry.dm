/datum/sunset/cryo_store
    var/obj/machinery/cryopod/cryo_cell
    var/name
    var/access
    var/list/uniform
    var/list/suit
    var/list/back
    var/list/belt
    var/list/gloves
    var/list/shoes
    var/list/head
    var/list/mask
    var/list/neck
    var/list/ears
    var/list/glasses
    var/list/l_pocket
    var/list/r_pocket
    var/list/suit_stores
    var/list/hands

/datum/sunset/cryo_store/New(mob/living/carbon/human/H,obj/machinery/cryopod/P)
    cryo_cell = P
    name = H.real_name
    var/obj/item/card/id/I
    access = I.access
    uniform = getItemAndContentsAndSlapItIntoCryopodContents(H.w_uniform,H)
    suit = getItemAndContentsAndSlapItIntoCryopodContents(H.wear_suit,H)
    back = getItemAndContentsAndSlapItIntoCryopodContents(H.back,H)
    belt = getItemAndContentsAndSlapItIntoCryopodContents(H.belt,H)
    gloves = getItemAndContentsAndSlapItIntoCryopodContents(H.gloves,H)
    shoes = getItemAndContentsAndSlapItIntoCryopodContents(H.shoes,H)
    head = getItemAndContentsAndSlapItIntoCryopodContents(H.head,H)
    mask = getItemAndContentsAndSlapItIntoCryopodContents(H.wear_mask,H)
    neck = getItemAndContentsAndSlapItIntoCryopodContents(H.wear_neck,H)
    ears = getItemAndContentsAndSlapItIntoCryopodContents(H.ears,H)
    glasses = getItemAndContentsAndSlapItIntoCryopodContents(H.glasses,H)
    l_pocket = getItemAndContentsAndSlapItIntoCryopodContents(H.l_store,H)
    r_pocket = getItemAndContentsAndSlapItIntoCryopodContents(H.r_store,H)
    suit_stores = getItemAndContentsAndSlapItIntoCryopodContents(H.s_store,H)
    for(var/obj/item/T in H.held_items)
        hands += getItemAndContentsAndSlapItIntoCryopodContents(T)
    
/datum/sunset/cryo_store/proc/getItemAndContentsAndSlapItIntoCryopodContents(var/atom/O, var/mob/living/carbon/H)
    if(QDELETED(O))
        return
    var/list/items = list()
    items |= O
    if(SEND_SIGNAL(O, COMSIG_CONTAINS_STORAGE))
        SEND_SIGNAL(O, COMSIG_TRY_STORAGE_RETURN_INVENTORY, items, TRUE)
    for(var/obj/item/I in items)
        H.transferItemToLoc(I,cryo_cell)
    return items