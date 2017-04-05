var/datum/subsystem/parallax/SSparallax

/datum/subsystem/parallax
	name = "Parallax"

	priority = SS_PRIORITY_PARALAX
	wait     = SS_WAIT_PARALAX

	flags = SS_POST_FIRE_TIMING | SS_FIRE_IN_LOBBY | SS_BACKGROUND | SS_NO_INIT

	var/list/currentrun

/datum/subsystem/parallax/New()
	NEW_SS_GLOBAL(SSparallax)

/datum/subsystem/parallax/fire(resumed = 0)
	if (!resumed)
		src.currentrun = clients.Copy()

	//cache for sanic speed (lists are references anyways)
	var/list/currentrun = src.currentrun

	while(length(currentrun))
		var/client/C = currentrun[currentrun.len]
		currentrun.len--

		if (!C || !C.eye)
			if (MC_TICK_CHECK)
				return
			continue
		var/atom/movable/A = C.eye
		if(!A)
			return
		for (A; isloc(A.loc) && !isturf(A.loc); A = A.loc);

		if(A != C.movingmob)
			if(C.movingmob != null)
				C.movingmob.client_mobs_in_contents -= C.mob
				UNSETEMPTY(C.movingmob.client_mobs_in_contents)
			LAZYINITLIST(A.client_mobs_in_contents)
			A.client_mobs_in_contents += C.mob
			C.movingmob = A
		if (MC_TICK_CHECK)
			return
	currentrun = null