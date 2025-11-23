extends ControllerState

func controllerStart(_message:String="") -> void:
	print("pls")
	corePlayer.animator.playAnimation("neutral")
	return

func controllerPhysics(_delta:float) -> void:
	
	corePlayer.velocity = corePlayer.wishDir * corePlayer.walk_speed
	
	if corePlayer.wishDir != Vector3.ZERO:
		corePlayer.modelRoot.rotation.y = atan2(-corePlayer.wishDir.x, -corePlayer.wishDir.z)
	return
