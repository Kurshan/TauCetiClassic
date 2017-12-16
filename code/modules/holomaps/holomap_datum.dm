/datum/holomap_datum
	var/mob/activator = null
	var/holomap_filter = null//Filter for the holomap so for example nuke won't see ERT
	var/list/holomap_images = list()

/datum/holomap_datum/process()
	update_holomap()

/datum/holomap_datum/proc/update_holomap()
	if(!activator.client)
		deactivate_holomap()
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
	switch(holomap_filter) //Adding squad icons
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
	activator.client.images |= holomap_images

/datum/holomap_datum/proc/deactivate_holomap()
	spawn(5)
		activator = null