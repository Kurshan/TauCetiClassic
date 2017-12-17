#define HOLOMAP_WALKABLE_TILE "#5294ff"
#define HOLOMAP_CONCRETE_TILE "#bfefff"
#define HOLOMAP_UPDATE_DELAY (2 MINUTES)
#define HOLOMAP_DURATION_WITHOUT_USERS (15 MINUTES)

var/datum/holomap_updater/holomap_updater

/datum/holomap_updater
	var/image/holomap = null
	var/last_update = 0
	var/last_update_without_users = 0
	var/list/users = list()

/datum/holomap_updater/New()
	holomap_updater = src
	activate()
	..()

/datum/holomap_updater/Destroy()
	holomap_updater = null
	return ..()

/datum/holomap_updater/proc/activate()
	last_update = world.time + HOLOMAP_UPDATE_DELAY
	holomap = image(generateHoloMap())
	holomap.color = "#0B74B4"
	holomap.layer = HUD_LAYER
	holomap.plane = HUD_PLANE
	holomap.alpha = 175
	START_PROCESSING(SSobj, src)

/datum/holomap_updater/process()
	if(last_update < world.time)
		last_update = world.time + HOLOMAP_UPDATE_DELAY
		for(var/mob/M in users)
			M.hud_used.holomap_obj.overlays -= holomap
		qdel(holomap)
		holomap = image(generateHoloMap())
		holomap.color = "#0B74B4"
		holomap.layer = HUD_LAYER
		holomap.plane = HUD_PLANE
		for(var/mob/M in users)
			M.hud_used.holomap_obj.overlays += holomap

	if(length(users) < 1 && !last_update_without_users)
		last_update_without_users = world.time
	else
		last_update_without_users = 0

	if(last_update_without_users + HOLOMAP_DURATION_WITHOUT_USERS < world.time)
		qdel(src)

/datum/holomap_updater/proc/generateHoloMap()
	var/icon/holomap = icon('icons/canvas.dmi', "blank")
	for(var/i = 1 to ((2 * world.view + 1) * 32))
		for(var/r = 1 to ((2 * world.view + 1) * 32))
			var/turf/tile = locate(i, r, 1)
			if(tile)
				if(!istype(tile, /turf/space) || istype(tile, /turf/simulated/wall) || istype(tile, /turf/unsimulated/wall) || 	(locate(/obj/structure/grille) in tile) || 	(locate(/obj/structure/window) in tile))
					holomap.DrawBox(HOLOMAP_CONCRETE_TILE, i, r)
				if (istype(tile, /turf/simulated/floor) || istype(tile, /turf/unsimulated/floor) || istype(tile, /turf/simulated/shuttle/floor))
					holomap.DrawBox(HOLOMAP_WALKABLE_TILE, i, r)
	return holomap

#undef HOLOMAP_UPDATE_DELAY
#undef HOLOMAP_WALKABLE_TILE
#undef HOLOMAP_CONCRETE_TILE
#undef HOLOMAP_DURATION_WITHOUT_USERS