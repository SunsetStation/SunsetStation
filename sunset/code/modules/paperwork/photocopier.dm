/obj/machinery/photocopier/proc/copy(var/obj/item/paper/copy)
	var/obj/item/paper/c
	for(var/i = 0, i < copies, i++)
		if(toner > 0 && !busy && copy)
			var/copy_as_paper = 1
			if(istype(copy, /obj/item/paper/contract/employment))
				var/obj/item/paper/contract/employment/E = copy
				var/obj/item/paper/contract/employment/C = new /obj/item/paper/contract/employment (loc, E.target.current)
				if(C)
					copy_as_paper = 0
			if(copy_as_paper)
				c = new /obj/item/paper (loc)
				if(length(copy.info) > 0)	//Only print and add content if the copied doc has words on it
					if(toner > 10)	//lots of toner, make it dark
						c.info = "<font color = #101010>"
					else			//no toner? shitty copies for you!
						c.info = "<font color = #808080>"
					var/copied = copy.info
					copied = replacetext(copied, "<font face=\"[PEN_FONT]\" color=", "<font face=\"[PEN_FONT]\" nocolor=")	//state of the art techniques in action
					copied = replacetext(copied, "<font face=\"[CRAYON_FONT]\" color=", "<font face=\"[CRAYON_FONT]\" nocolor=")	//This basically just breaks the existing color tag, which we need to do because the innermost tag takes priority.
					c.info += copied
					c.info += "</font>"
					c.name = copy.name
					c.fields = copy.fields
					c.update_icon()
					c.updateinfolinks()
					c.stamps = copy.stamps
					if(copy.stamped)
						c.stamped = copy.stamped.Copy()
					c.copy_overlays(copy, TRUE)
					toner--
			busy = TRUE
			addtimer(CALLBACK(src, .proc/disable_busy,), 15)
		else
			break
	return c
	updateUsrDialog()

/obj/machinery/photocopier/proc/disable_busy()
	busy = FALSE

/obj/machinery/photocopier/proc/photocopy(var/obj/item/photo/photocopy)
	var/obj/item/photo/p
	for(var/i = 0, i < copies, i++)
		if(toner >= 5 && !busy && photocopy)  //Was set to = 0, but if there was say 3 toner left and this ran, you would get -2 which would be weird for ink
			p = new /obj/item/photo (loc)
			var/icon/I = icon(photocopy.icon, photocopy.icon_state)
			//var/icon/img = icon(photocopy.img) Will need to be fixed for photocopying
			if(greytoggle == "Greyscale")
				if(toner > 10) //plenty of toner, go straight greyscale
					I.MapColors(rgb(77,77,77), rgb(150,150,150), rgb(28,28,28), rgb(0,0,0)) //I'm not sure how expensive this is, but given the many limitations of photocopying, it shouldn't be an issue.
					//img.MapColors(rgb(77,77,77), rgb(150,150,150), rgb(28,28,28), rgb(0,0,0)) Will need to be fixed for photocopying
				else //not much toner left, lighten the photo
					I.MapColors(rgb(77,77,77), rgb(150,150,150), rgb(28,28,28), rgb(100,100,100))
					//img.MapColors(rgb(77,77,77), rgb(150,150,150), rgb(28,28,28), rgb(100,100,100)) Will need to be fixed for photocopying
				toner -= 5	//photos use a lot of ink!
			else if(greytoggle == "Color")
				if(toner >= 10)
					toner -= 10 //Color photos use even more ink!
				else
					continue
			p.icon = I
			//p.img = img Will need to be fixed for photocopying
			p.name = photocopy.name
			p.desc = photocopy.desc
			p.scribble = photocopy.scribble
			p.pixel_x = rand(-10, 10)
			p.pixel_y = rand(-10, 10)
			//p.blueprints = photocopy.blueprints //a copy of a picture is still good enough for the syndicate Will need to be fixed for photocopying
			busy = TRUE
			sleep(15)
			busy = FALSE
		else
			break
	return p