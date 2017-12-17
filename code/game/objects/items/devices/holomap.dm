/obj/item/device/holomap
	name = "Holomap"
	desc = "A state of art device featuring a holographic map of the area."
	icon = 'icons/obj/device.dmi'
	icon_state	= "camera_bug"
	w_class = 3
	var/datum/holomap_interface/holo
	var/on = FALSE

/obj/item/device/holomap/atom_init()
	. = ..()
	holo = new(src)

/obj/item/device/holomap/attack_self(mob/M)
	if(on)
		holo.deactivate_holomap()
	else
		holo.activate(M)
	on = !on

/obj/item/device/holomap/dropped(mob/M)
	holo.deactivate_holomap()
	on = FALSE
	return ..()

/obj/item/device/holomap/Destroy()
	QDEL_NULL(holo)
	return ..()