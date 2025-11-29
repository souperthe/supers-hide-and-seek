extends ControllerAction

func actionEnter(_message:String="")->void:
	pass

func actioneExit()->void:
	pass

func actionPhysics(delta:float)->void:
	corePlayer.velocity.y -= (corePlayer.gravity) * delta
	
	if corePlayer.wishDir != Vector3.ZERO:
		corePlayer.velocity.x = corePlayer.wishDir.x * 20
		corePlayer.velocity.z = corePlayer.wishDir.z * 20
	
	if corePlayer.is_on_floor():
		coreState.actionTransition("idle")
