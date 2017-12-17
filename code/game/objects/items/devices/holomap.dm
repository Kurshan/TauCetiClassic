/obj/item/device/holomap
	name = "Holomap"
	desc = "A state of art device featuring a holographic map of the area."
	icon = 'icons/obj/device.dmi'
	icon_state	= "camera_bug"
	w_class = 3
	var/list/holomap_images = list()
	var/mob/living/carbon/human/activator = null

/obj/item/device/holomap/attack_self(mob/M)
	if(M.client)
		activator = M
		START_PROCESSING(SSobj, src)

/obj/item/device/holomap/process()
	update_holomap()

/obj/item/device/holomap/proc/update_holomap()
	activator.client.images -= holomap_images
	holomap_images.len = 0

	var/turf/moblocation = get_turf(src)
	if(!moblocation)
		return
	if(!activator.client)
		deactivate_holomap()
		return

	var/image/hmap = image(generateHoloMap())
	hmap.layer = HUD_LAYER
	hmap.plane = HUD_PLANE
	hmap.loc = activator.hud_used.holomap_obj
	hmap.pixel_x = activator.client.view*WORLD_ICON_SIZE/2
	hmap.pixel_y = activator.client.view*WORLD_ICON_SIZE/2
	hmap.color = "#0B74B4"
	holomap_images += hmap

	var/image/I = image('icons/holomap_markers.dmi', "you")
	I.pixel_x = (moblocation.x-6+hmap.pixel_x)*PIXEL_MULTIPLIER
	I.pixel_y = (moblocation.y-6+hmap.pixel_x)*PIXEL_MULTIPLIER
	I.layer = ABOVE_HUD_LAYER
	I.plane = ABOVE_HUD_PLANE
	I.loc = activator.hud_used.holomap_obj
	holomap_images += I
	activator.client.images |= holomap_images

/obj/item/device/holomap/dropped(mob/M)
	if(M.client)
		deactivate_holomap()

/obj/item/device/holomap/proc/deactivate_holomap()
	spawn(5)
		activator.client.images -= holomap_images
		activator = null