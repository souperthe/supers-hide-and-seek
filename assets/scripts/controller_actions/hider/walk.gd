extends ControllerAction

var _stepTime:float = 0


func actionEnter(_message:String="")->void:
	corePlayer.animator.playAnimation("run", 2)
	_stepTime = 0
	return
	
func actioneExit()->void:
	return
	
func actionPhysics(delta:float)->void:
	
		
	if !corePlayer.is_on_floor():
		coreState.actionTransition("jump")
		corePlayer.coyote_time = 0.2
		return
		
	if Input.is_action_just_pressed("player_jump"):
		coreState.actionTransition("jump", "jump")
		return
	
	#corePlayer.velocity = corePlayer.wishDir * corePlayer.getSpeed()
	
	var cur_speed_in_wish_dir:float = corePlayer.velocity.dot(corePlayer.wishDir)
	var add_speed_till_cap:float = corePlayer.getSpeed() - cur_speed_in_wish_dir
	if add_speed_till_cap > 0:
		var accel_speed:float = corePlayer.ground_accel * delta * corePlayer.getSpeed()
		accel_speed = min(accel_speed, add_speed_till_cap)
		
		if corePlayer.crouching:
			accel_speed *= 1.5
		
		corePlayer.velocity += accel_speed * corePlayer.wishDir
	
	# Apply friction
	var control:float = max(corePlayer.velocity.length(), corePlayer.ground_decel)
	var drop:float = control * corePlayer.ground_friction * delta
	var new_speed:float = max(corePlayer.velocity.length() - drop, 0.0)
	
	if corePlayer.velocity.length() > 0:
		new_speed /= corePlayer.velocity.length()
		
	corePlayer.velocity *= new_speed
	
	
	if corePlayer.wishDir == Vector3.ZERO:
		coreState.actionTransition("idle")
		return
		
	_stepTime += corePlayer.velocity.length() * delta
	
	#print(_stepTime)
	
	if !corePlayer.crouching:
		if _stepTime > 3.5:
			coreSound.playSound("res://assets/resources/rnd_sound/stone_step.tres")
			_stepTime = 0
	
	return
