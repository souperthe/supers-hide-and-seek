extends ControllerAction

func actionEnter(_message:String="")->void:
	
	corePlayer.animator.playAnimation("smile", 0, 0.45)

	corePlayer.animator.playAnimation("slip-forward", 0, 0.45)
	

	
	return
	
func actioneExit()->void:
	return


func actionPhysics(delta:float)->void:
	corePlayer.velocity.y -= (corePlayer.gravity) * delta
	
	
	if corePlayer.is_on_floor():
		coreState.actionTransition("flying_land")
		return
	
	
	return
