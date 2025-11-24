extends ControllerAction

func actionEnter(_message:String="")->void:
	corePlayer.animator.playAnimation("flail")
	return
	
func actioneExit()->void:
	return
	
func actionPhysics(delta:float)->void:
	corePlayer.velocity.y -= (corePlayer.gravity) * delta
	
	
	var goto:Vector3 = corePlayer.wishDir * (corePlayer.walk_speed/2)
	corePlayer.velocity.x = goto.x
	corePlayer.velocity.z = goto.z
	
	if corePlayer.is_on_floor():
		coreState.actionTransition("idle", "land")
		return
	return
