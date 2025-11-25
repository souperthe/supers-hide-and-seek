extends ControllerAction


func actionEnter(message:String="")->void:
	
	corePlayer.animator.playAnimation("Fredbear_Idle_Anim")
	
	corePlayer.velocity = Vector3.ZERO
	
	return
	
func actioneExit()->void:
	return
	
func actionPhysics(_delta:float)->void:
	
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
