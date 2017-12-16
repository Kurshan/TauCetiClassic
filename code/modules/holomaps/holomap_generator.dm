#define HOLOMAP_WALKABLE_TILE "#5294ff"
#define HOLOMAP_CONCRETE_TILE "#0a0a0a"

/proc/generateHoloMaps()
	var/list/filters = list(
			HOLOMAP_CUSTOM,
			HOLOMAP_DEATHSQUAD,
			HOLOMAP_ERT,
			HOLOMAP_NUKE,
			HOLOMAP_ELITESYNDIE,
			HOLOMAP_VOX,
			HOLOMAP_EXODUS
			)

/proc/generateHoloMap(var/icon/canvas)
	canvas = icon('icons/canvas.dmi', "blank")
	for(var/i = 1 to ((2*world.view +1)*32))
		for(var/r = 1 to ((2 * world.view +1)*32))
			var/turf/tile = locate(i, r, 1)
			if(tile)
				if(!istype(tile, /turf/space) || istype(tile, /turf/simulated/wall) || istype(tile, /turf/unsimulated/wall) || (locate(/obj/structure/grille) in tile) || (locate(/obj/structure/window) in tile))
					canvas.DrawBox(HOLOMAP_CONCRETE_TILE, i, r)
				if (istype(tile, /turf/simulated/floor) || istype(tile, /turf/unsimulated/floor) || istype(tile, /turf/simulated/shuttle/floor))
					canvas.DrawBox(HOLOMAP_WALKABLE_TILE, i, r)
	return canvas
