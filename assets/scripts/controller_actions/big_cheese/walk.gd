extends ControllerAction


func actionEnter(_message:String="")->void:
	
	corePlayer.animator.playAnimation("walk")
	
	return
	
func actioneExit()->void:
	return

func actionPhysics(_delta:float)->void:
	
	if Input.is_action_just_pressed("player_jump"):
		coreState.actionTransition("fly_transition", "enter")
		return
	
	if corePlayer.wishDir == Vector3.ZERO:
		coreState.actionTransition("idle")
		return
		
	corePlayer.modelRoot.rotation.y = atan2(
		-corePlayer.wishDir.x,
		-corePlayer.wishDir.z
	)
	
	if !corePlayer.is_on_floor():
		coreState.actionTransition("fall")
		return
	
	
	corePlayer.velocity = corePlayer.wishDir * (corePlayer.walk_speed/2)
	
	
	return
