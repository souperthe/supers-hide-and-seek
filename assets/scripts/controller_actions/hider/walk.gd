extends ControllerAction


func actionEnter(_message:String="")->void:
	return
	
func actioneExit()->void:
	return
	
func actionPhysics(delta:float)->void:
	
	#corePlayer.velocity = corePlayer.wishDir * corePlayer.getSpeed()
	
	var cur_speed_in_wish_dir:float = corePlayer.velocity.dot(corePlayer.wishDir)
	var add_speed_till_cap:float = corePlayer.getSpeed() - cur_speed_in_wish_dir
	if add_speed_till_cap > 0:
		var accel_speed:float = corePlayer.ground_accel * delta * corePlayer.getSpeed()
		accel_speed = min(accel_speed, add_speed_till_cap)
		corePlayer.velocity += accel_speed * corePlayer.wishDir
	
	# Apply friction
	var control:float = max(corePlayer.velocity.length(), corePlayer.ground_decel)
	var drop:float = control * corePlayer.ground_friction * delta
	var new_speed:float = max(corePlayer.velocity.length() - drop, 0.0)
	
	if corePlayer.velocity.length() > 0:
		new_speed /= corePlayer.velocity.length()
		
	corePlayer.velocity *= new_speed
	
	if Input.is_action_just_pressed("player_jump"):
		coreState.actionTransition("jump", "jump")
		return
	
	if corePlayer.wishDir == Vector3.ZERO:
		coreState.actionTransition("idle")
		return
	
	return
