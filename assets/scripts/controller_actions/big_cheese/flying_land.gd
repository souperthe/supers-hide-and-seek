extends ControllerAction

func actionEnter(_message:String="")->void:
	
	coreSound.playSound(
		"res://assets/sound/sfx/physics/metal/metal_barrel_impact_hard1.wav",
		randf_range(0.9,1.1)
		)
	
	corePlayer.animator.playAnimation("smile", 0, 0.45)
	corePlayer.animator.playAnimation("slip-forward", 1, 0.5)
	

	
	return
	
func actioneExit()->void:
	return


func actionPhysics(delta:float)->void:
	
	corePlayer.velocity = corePlayer.velocity.lerp(Vector3.ZERO, 6*delta)
	
	if !(corePlayer.is_on_floor()):
		coreState.actionTransition("land_fall")
		return
	
	
	if corePlayer.animator.animationDone:
		coreState.actionTransition("idle")
		return
	
	
	return
