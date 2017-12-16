//Deathsquad suit
/obj/item/clothing/head/helmet/space/deathsquad
	name = "deathsquad helmet"
	desc = "That's not red paint. That's real blood."
	icon_state = "deathsquad"
	item_state = "deathsquad"
	armor = list(melee = 65, bullet = 40, laser = 35,energy = 20, bomb = 30, bio = 30, rad = 30)
	var/holofilter = HOLOMAP_DEATHSQUAD
	var/datum/holomap_datum/holodatum = null
	var/list/holomap_images = list()
	var/mob/activator = null

/obj/item/clothing/head/helmet/space/deathsquad/atom_init()
	deathsquad_helmets += src
	holodatum = new /datum/holomap_datum
	..()

/obj/item/clothing/head/helmet/space/deathsquad/Destroy()
	deathsquad_helmets -= src
	..()

/obj/item/clothing/head/helmet/space/deathsquad/verb/activate_holomap(mob/user = usr)
	//if(user.mind.special_role = "Death Commando") //People, who found deathsquad helmets in junk, should not see real deathsquad.
	holodatum.activator = user
	holodatum.holomap_filter = holofilter
	START_PROCESSING(SSobj, holodatum)
//	else
	//	to_chat(user, "<span class ='notice'> You try to activate the holomap, but hotning happens. Perhaps it is broken?</span>")

/*/obj/item/clothing/head/helmet/space/deathsquad/process()
	if(!activator.client)
		return
	activator.client.images -= holomap_images
	holomap_images.len = 0
	var/turf/moblocation = get_turf(src)
	if(!moblocation)
		return
	var/image/hmap = image(generateHoloMap()) //Getting map image
	hmap.layer = HUD_LAYER
	hmap.plane = HUD_PLANE
	hmap.loc = activator.hud_used.holomap_obj
	hmap.pixel_x = activator.client.view*WORLD_ICON_SIZE/2
	hmap.pixel_y = activator.client.view*WORLD_ICON_SIZE/2
	hmap.color = "#0B74B4"
	holomap_images += hmap

	switch(holofilter) //Adding squad icons
		if("HOLOMAP_CUSTOM")
			return
		if("HOLOMAP_DEATHSQUAD")
			for(var/obj/item/clothing/head/helmet/space/deathsquad/D in deathsquad_helmets)
				var/image/mob_indicator = image('icons/holomap_markers.dmi', "you")
				mob_indicator.plane = ABOVE_HUD_PLANE
				mob_indicator.layer = ABOVE_HUD_LAYER
				mob_indicator.loc = activator.hud_used.holomap_obj
				var/turf/mob_location = get_turf(D)
				if(mob_location == src)
					mob_indicator = "you"
				else if((mob_location.z == 1) && ishuman(mob_location.loc))
					var/mob/living/carbon/human/H = D.loc
					if(H.get_item_by_slot(slot_w_uniform) == D)
						if(H.stat == DEAD)
							mob_indicator = "ds3"
						if(H.stat == UNCONSCIOUS || H.restrained())
							mob_indicator = "ds2"
						else
							mob_indicator = "ds1"
				mob_indicator.pixel_x = (mob_location.x-6+hmap.pixel_x)*PIXEL_MULTIPLIER
				mob_indicator.pixel_y = (mob_location.y-6+hmap.pixel_x)*PIXEL_MULTIPLIER
				holomap_images += hmap
		if("HOLOMAP_ERT")
			return
		if("HOLOMAP_NUKE")
			return
		if("HOLOMAP_ELITESYNDIE")
			return
		if("HOLOMAP_VOX")
			return
		if("HOLOMAP_EXODUS")
			return
	activator.client.images |= holomap_images */

/obj/item/clothing/head/helmet/space/deathsquad/beret
	name = "officer's beret"
	desc = "An armored beret commonly used by special operations officers."
	icon_state = "beret_badge"
	armor = list(melee = 65, bullet = 15, laser = 35,energy = 20, bomb = 30, bio = 30, rad = 30)
	flags = HEADCOVERSEYES | BLOCKHAIR
	siemens_coefficient = 0.9

//Space santa outfit suit
/obj/item/clothing/head/helmet/space/santahat
	name = "Santa's hat"
	desc = "Ho ho ho. Merrry X-mas!"
	icon_state = "santahat"
	flags = HEADCOVERSEYES | BLOCKHAIR
	body_parts_covered = HEAD

/obj/item/clothing/suit/space/santa
	name = "Santa's suit"
	desc = "Festive!"
	icon_state = "santa"
	item_state = "santa"
	slowdown = 0
	flags = ONESIZEFITSALL
	allowed = list(/obj/item) //for stuffing exta special presents

/obj/item/clothing/head/helmet/syndiassault
	name = "Assault helmet"
	icon_state = "assaulthelmet_b"
	item_state = "assaulthelmet_b"
	armor = list(melee = 50, bullet = 60, laser = 45, energy = 70, bomb = 50, bio = 0, rad = 50)
	siemens_coefficient = 0.2

/obj/item/clothing/head/helmet/syndiassault/alternate
	icon_state = "assaulthelmet"
	item_state = "assaulthelmet"

//Space pirate outfit
/obj/item/clothing/head/helmet/space/pirate
	name = "pirate hat"
	desc = "Yarr."
	icon_state = "pirate"
	item_state = "pirate"
	armor = list(melee = 60, bullet = 35, laser = 60,energy = 60, bomb = 30, bio = 30, rad = 30)
	flags = HEADCOVERSEYES | BLOCKHAIR

/obj/item/clothing/suit/space/pirate
	name = "pirate coat"
	desc = "Yarr."
	icon_state = "pirate"
	item_state = "pirate"
	w_class = 3
	allowed = list(/obj/item/weapon/gun,/obj/item/ammo_box/magazine,/obj/item/ammo_casing,/obj/item/weapon/melee/baton,/obj/item/weapon/handcuffs,/obj/item/weapon/tank)
	slowdown = 0
	armor = list(melee = 60, bullet = 35, laser = 60,energy = 60, bomb = 30, bio = 30, rad = 30)
	breach_threshold = 25

//Buget suit

/obj/item/clothing/suit/space/cheap
	name = "Budget spacesuit"
	desc = "It was an attempt to force the assistants to work in space.The label on the side reads: Not for atheists"
	resilience = 0.6

/obj/item/clothing/head/helmet/space/cheap
	name = "Budget spacesuit helmet"
	desc = "It was an attempt to force the assistants to work in space. At least 60% of them survived in the spacesuit."

//Mime's Hardsuit
/obj/item/clothing/head/helmet/space/mime
	name = "mime hardsuit helmet"
	desc = "A hardsuit helmet specifically designed for the mime."
	icon_state = "mim"
	item_state = "mim"

obj/item/clothing/suit/space/mime
	name = "mime hardsuit"
	desc = "A hardsuit specifically designed for the mime."
	icon_state = "mime"
	item_state = "mime"
	allowed = list(/obj/item/weapon/tank)

/obj/item/clothing/head/helmet/space/clown
	name = "clown hardsuit helmet"
	desc = "A hardsuit helmet specifically designed for the clown. SPESSHONK!"
	icon_state = "kluwne"
	item_state = "kluwne"

obj/item/clothing/suit/space/clown
	name = "clown hardsuit"
	desc = "A hardsuit specifically designed for the clown. SPESSHONK!"
	icon_state = "clowan"
	item_state = "clowan"
	allowed = list(/obj/item/weapon/tank)
