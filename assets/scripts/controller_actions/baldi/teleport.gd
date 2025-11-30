extends ControllerAction

var time_left: float = 0

func actionEnter(_message:String="")->void:
	corePlayer.animator.playAnimation("teleport")
	time_left = 3

func actioneExit()->void:
	pass

func actionPhysics(delta:float)->void:
	time_left -= delta
	corePlayer.velocity.x = 0
	corePlayer.velocity.z = 0
	
	if time_left <= 0:
		coreState.actionTransition("idle","reset")
