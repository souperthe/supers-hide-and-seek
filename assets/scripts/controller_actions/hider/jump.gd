extends ControllerAction


func actionEnter(message:String="")->void:
	
	if message == "jump":
		corePlayer.velocity.y = corePlayer.jump_velocity
	return
	
func actioneExit()->void:
	return
	
func actionPhysics(delta:float)->void:
	
	corePlayer.velocity.y -= corePlayer.gravity * delta
	
	#corePlayer.velocity = corePlayer.wishDir * corePlayer.getSpeed()
	var cur_speed_in_wish_dir:float = corePlayer.velocity.dot(corePlayer.wishDir)
	# Wish speed (if wish_dir > 0 length) capped to air_cap
	var capped_speed:float = min((corePlayer.air_move_speed * corePlayer.wishDir).length(), corePlayer.air_cap)
	# How much to get to the speed the player wishes (in the new dir)
	# Notice this allows for infinite speed. If wish_dir is perpendicular, we always need to add velocity
	#  no matter how fast we're going. This is what allows for things like bhop in CSS & Quake.
	# Also happens to just give some very nice feeling movement & responsiveness when in the air.
	var add_speed_till_cap:float = capped_speed - cur_speed_in_wish_dir
	if add_speed_till_cap > 0:
		var accel_speed:float = corePlayer.air_accel * corePlayer.air_move_speed * delta # Usually is adding this one.
		accel_speed = min(accel_speed, add_speed_till_cap) # Works ok without this but sticking to the recipe
		corePlayer.velocity += accel_speed * corePlayer.wishDir
		
	if corePlayer.is_on_floor():
		coreState.actionTransition("idle", "landing")
		return
		

	
	
	return
