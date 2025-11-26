extends ControllerAction


func actionEnter(message:String="")->void:
	
	if message == "jump":
		corePlayer.velocity.y = corePlayer.jump_velocity
		if corePlayer.crouching:
			corePlayer.velocity.y = corePlayer.jump_velocity * 0.8
	return
	
func actioneExit()->void:
	return
	
func actionPhysics(delta:float)->void:
	
	corePlayer.velocity.y -= corePlayer.gravity * delta
	
	#corePlayer.velocity = corePlayer.wishDir * corePlayer.getSpeed()
	var cur_speed_in_wish_dir:float = corePlayer.velocity.dot(corePlayer.wishDir)
	var capped_speed:float = min((corePlayer.air_move_speed * corePlayer.wishDir).length(), corePlayer.air_cap)
	var add_speed_till_cap:float = capped_speed - cur_speed_in_wish_dir
	if add_speed_till_cap > 0:
		var accel_speed:float = corePlayer.air_accel * corePlayer.air_move_speed * delta
		accel_speed = min(accel_speed, add_speed_till_cap)
		corePlayer.velocity += accel_speed * corePlayer.wishDir
		
	if corePlayer.is_on_floor():
		coreState.actionTransition("idle", "landing")
		return
		

	
	
	return
