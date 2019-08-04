GLOBAL_LIST_EMPTY(vending_machine_icon)

/obj/machinery/vending/ui_interact(mob/user)
	var/onstation = FALSE
	if(SSmapping.level_trait(z, ZTRAIT_STATION))
		onstation = TRUE
	var/dat = ""
	var/datum/bank_account/account
	var/mob/living/carbon/human/H
	var/obj/item/card/id/C
	if(ishuman(user))
		H = user
		C = H.get_idcard()

	if(!C)
		dat += "<font color = 'red'><h3>No ID Card detected!</h3></font>"
	else if (!C.registered_account)
		dat += "<font color = 'red'><h3>No account on registered ID card!</h3></font>"
	if(onstation && C && C.registered_account)
		account = C.registered_account
	dat += "<h3>Select an item</h3>"
	dat += "<div class='statusDisplay'>"
	if(!product_records.len)
		dat += "<font color = 'red'>No product loaded!</font>"
	else
		var/list/display_records = product_records + coin_records
		if(extended_inventory)
			display_records = product_records + coin_records + hidden_records
		dat += "<table>"
		for (var/datum/data/vending_product/R in display_records)
			var/price_listed = "$[default_price]"
			var/is_hidden = hidden_records.Find(R)
			if(is_hidden && !extended_inventory)
				continue
			if(R.custom_price)
				price_listed = "$[R.custom_price]"
			if(!onstation || account && account.account_job && account.account_job.paycheck_department == payment_department)
				price_listed = "FREE"
			if(coin_records.Find(R) || is_hidden)
				price_listed = "$[extra_price]"
			dat += "<tr><td><img src='data:image/jpeg;base64,[GetIconForProduct(R)]'/></td>"
			dat += "<td><b>[sanitize(R.name)] ([price_listed])</b>:</td>"
			dat += " <td><b>[R.amount]</b></td>"
			if(R.amount > 0 && ((C && C.registered_account && onstation) || (!onstation && iscarbon(user))))
				dat += "<td><a href='byond://?src=[REF(src)];vend=[REF(R)]'>Vend</a></td> "
			else
				dat += "<td><span class='linkOff'>Not Available</span></td> "
			dat += "</tr>"
		dat += "</table>"
	dat += "</div>"
	if(onstation && C && C.registered_account)
		dat += "<b>Balance: $[account.account_balance]</b>"
	if(istype(src, /obj/machinery/vending/snack))
		dat += "<h3>Chef's Food Selection</h3>"
		dat += "<div class='statusDisplay'>"
		for (var/O in dish_quants)
			if(dish_quants[O] > 0)
				var/N = dish_quants[O]
				dat += "<a href='byond://?src=[REF(src)];dispense=[sanitize(O)]'>Dispense</A> "
				dat += "<B>[capitalize(O)] ($[default_price]): [N]</B><br>"
		dat += "</div>"

	var/datum/browser/popup = new(user, "vending", (name))
	popup.set_content(dat)
	popup.set_title_image(user.browse_rsc_icon(icon, icon_state))
	popup.open()
