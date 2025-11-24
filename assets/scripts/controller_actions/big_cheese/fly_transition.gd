extends ControllerAction


var entering:bool = false


func actionEnter(message:String="")->void:
	
	entering = message == "enter"
	
	if entering:
		corePlayer.animator.playAnimation("landing_reverse", 2, 0.83)
	else:
		corePlayer.animator.playAnimation("landing", 1.5, 0.83)
	
	return
	
func actioneExit()->void:
	return

func actionPhysics(delta:float)->void:
	
	corePlayer.velocity = corePlayer.velocity.lerp(Vector3.ZERO, 12*delta)
	
	if !corePlayer.is_on_floor():
		coreState.actionTransition("fall")
		return
	
	if corePlayer.animator.animationDone:
		if entering:
			coreState.actionTransition("flying")
		else:
			coreState.actionTransition("idle")
		return
	
	
	return
