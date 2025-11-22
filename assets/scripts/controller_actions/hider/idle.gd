extends ControllerAction


func actionEnter(message:String="")->void:
	
	if message == "landing":
		coreSound.playSound("res://assets/resources/rnd_sound/stone_step.tres")
	
	
	return
	
func actioneExit()->void:
	return
	
func actionPhysics(delta:float)->void:
	
	var control:float = max(corePlayer.velocity.length(), corePlayer.ground_decel)
	var drop:float = control * corePlayer.ground_friction * delta
	var new_speed:float = max(corePlayer.velocity.length() - drop, 0.0)
	
	if corePlayer.velocity.length() > 0:
		new_speed /= corePlayer.velocity.length()
		
	corePlayer.velocity *= new_speed
	
	if !corePlayer.is_on_floor():
		coreState.actionTransition("jump")
		return
	
	if Input.is_action_just_pressed("player_jump"):
		coreState.actionTransition("jump", "jump")
		return
	
	#print(_delta)
	
	
	if corePlayer.wishDir != Vector3.ZERO:
		coreState.actionTransition("walk")
		return
	
	
	return
