extends ControllerAction

var _canClimb: bool = true

func actionEnter(message:String="")->void:
	_canClimb = true
	if message == "noclimb":
		_canClimb = false
	elif message == "jump":
		corePlayer.velocity.y = corePlayer.jump_velocity * 1.5
		corePlayer.animator.playAnimation("climb", 0)
func actioneExit()->void:
	pass

func actionPhysics(delta:float)->void:
	corePlayer.velocity.y -= (corePlayer.gravity) * delta
	
	corePlayer.velocity.x = corePlayer.wishDir.x * (corePlayer.walk_speed / 2)
	corePlayer.velocity.z = corePlayer.wishDir.z * (corePlayer.walk_speed / 2)
	
	if corePlayer.is_on_floor():
		coreState.actionTransition("idle","reset")
