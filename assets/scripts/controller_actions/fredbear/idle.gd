extends ControllerAction


func actionEnter(_message:String="")->void:
	corePlayer.animator.playAnimation("Fredbear_Idle_Anim")
	
	if _message == "land":
		coreSound.playSound(
			"res://assets/resources/rnd_sound/fredbear_step.tres",
			1,
			0.3
			)
	
	#corePlayer.velocity = Vector3.ZERO
	
	return
	
func actioneExit()->void:
	return
	
func actionPhysics(delta:float)->void:
	
	corePlayer.velocity = corePlayer.velocity.lerp(Vector3.ZERO, 24*delta)
	
	if Input.is_action_just_pressed("player_attack"):
		coreState.actionTransition("punch")
		return
	
	if Input.is_action_just_pressed("player_jump"):
		coreState.actionTransition("jump", "jump")
		return
		
	if !corePlayer.is_on_floor():
		coreState.actionTransition("jump")
		return

	if corePlayer.wishDir != Vector3.ZERO:
		coreState.actionTransition("move")
		return

	return
