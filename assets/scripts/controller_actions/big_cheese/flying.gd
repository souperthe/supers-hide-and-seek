extends ControllerAction

func actionEnter(_message:String="")->void:
	
	#corePlayer.animator.playAnimation("fly", 0.5)
	corePlayer.velocity.y = corePlayer.jump_velocity*2
	
	return
	
func actioneExit()->void:
	return


func actionPhysics(delta:float)->void:
	
	corePlayer.velocity.y -= (corePlayer.gravity) * delta
	
	var goto:Vector3 = corePlayer.wishDir * (corePlayer.walk_speed*2)
	
	if goto != Vector3.ZERO:
		corePlayer.velocity.x = lerpf(corePlayer.velocity.x, goto.x, 6 * delta)
		corePlayer.velocity.z = lerpf(corePlayer.velocity.z, goto.z, 6 * delta)
		
		corePlayer.modelRoot.rotation.y = atan2(
			-corePlayer.velocity.x,
			-corePlayer.velocity.z
		)
	else:
		corePlayer.velocity.x = lerpf(corePlayer.velocity.x, 0, 6 * delta)
		corePlayer.velocity.z = lerpf(corePlayer.velocity.z, 0, 6 * delta)
	if Input.is_action_just_pressed("player_jump") and corePlayer.velocity.y < 0: 
		corePlayer.velocity.y = corePlayer.jump_velocity*2
	
	if corePlayer.is_on_floor():
		if goto != Vector3.ZERO:
			coreState.actionTransition("flying_land")
		else:
			coreState.actionTransition("fly_transition")
		return
	
	return
