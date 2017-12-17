


/datum/holomap_interface
	var/mob/activator = null
	var/obj/item/holder = null
	var/list/holomap_images = list()

/datum/holomap_interface/New(obj/item/holder)
	src.holder = holder
	..()

/datum/holomap_interface/Destroy()
	QDEL_NULL(holder)

/datum/holomap_interface/process()
	update_holomap()

/datum/holomap_interface/proc/draw_special()
	return

/datum/holomap_interface/proc/activate(mob/user)
	if(activator)
		return
	activator = user
	if(!holomap_updater)
		holomap_updater = new
	holomap_updater.users += user
	activator.hud_used.holomap_obj.overlays += holomap_updater.holomap
	START_PROCESSING(SSobj, src)

/datum/holomap_interface/proc/deactivate_holomap()
	STOP_PROCESSING(SSobj, src)
	if(activator)
		activator.hud_used.holomap_obj.overlays -= holomap_updater.holomap
		holomap_updater.users -= activator
		if(activator.client)
			activator.client.images -= holomap_images
		activator.client.images -= holomap_images
		for(var/i in holomap_images)
			qdel(i)
		holomap_images.Cut()
		activator = null

/datum/holomap_interface/proc/update_holomap()
	if(!activator || !activator.client)
		deactivate_holomap()
		return

	if(length(holomap_images))
		activator.client.images -= holomap_images
		for(var/i in holomap_images)
			qdel(i)
		holomap_images.Cut()

	var/turf/turf = get_turf(activator)
	var/image/I = image('icons/holomap_markers.dmi', "you")
	I.pixel_x = (turf.x - 6) * PIXEL_MULTIPLIER
	I.pixel_y = (turf.y - 6) * PIXEL_MULTIPLIER
	I.layer = ABOVE_HUD_LAYER
	I.plane = ABOVE_HUD_PLANE
	I.loc = activator.hud_used.holomap_obj
	holomap_images += I

	draw_special()

	activator.client.images |= holomap_images

/datum/holomap_interface/deathsquad/draw_special()
	for(var/obj/item/clothing/head/helmet/space/deathsquad/D in deathsquad_helmets)
		if(D == holder)
			continue
		var/image/mob_indicator = image('icons/holomap_markers.dmi', "you")
		mob_indicator.plane = ABOVE_HUD_PLANE
		mob_indicator.layer = ABOVE_HUD_LAYER
		mob_indicator.loc = activator.hud_used.holomap_obj
		var/turf/mob_location = get_turf(D)
		if(mob_location.z == 1 && ishuman(D.loc))
			var/mob/living/carbon/human/H = D.loc
			if(H.head == D)
				if(H.stat == DEAD)
					mob_indicator.icon_state = "ds3"
				else if(H.stat == UNCONSCIOUS || H.restrained())
					mob_indicator.icon_state = "ds2"
				else
					mob_indicator.icon_state = "ds1"
		mob_indicator.pixel_x = (mob_location.x - 6) * PIXEL_MULTIPLIER
		mob_indicator.pixel_y = (mob_location.y - 6) * PIXEL_MULTIPLIER
		holomap_images += mob_indicator
