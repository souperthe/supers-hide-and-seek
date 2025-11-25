extends ControllerAction


func actionEnter(message:String="")->void:
	
	corePlayer.animator.playAnimation("Fredbear_Idle_Anim")
	
	#corePlayer.velocity = Vector3.ZERO
	
	return
	
func actioneExit()->void:
	return
	
func actionPhysics(delta:float)->void:
	
	corePlayer.velocity = corePlayer.velocity.lerp(Vector3.ZERO, 12*delta)
	
	if Input.is_action_just_pressed("player_jump"):
		coreState.actionTransition("jump", "jump")
		return
		
	if !corePlayer.is_on_floor():
		coreState.actionTransition("jump", "jump")
		return

	if corePlayer.wishDir != Vector3.ZERO:
		coreState.actionTransition("move")
		return

	return
