extends ControllerAction

var _canClimb: bool = true

func actionEnter(message:String="")->void:
	_canClimb = true
	if message == "noclimb":
		_canClimb = false
func actioneExit()->void:
	pass

func actionPhysics(delta:float)->void:
	corePlayer.velocity.y -= (corePlayer.gravity) * delta
	
	if corePlayer.wishDir != Vector3.ZERO:
		corePlayer.velocity.x = corePlayer.wishDir.x * 20
		corePlayer.velocity.z = corePlayer.wishDir.z * 20
		corePlayer.modelPivot.rotation.y = atan2(
			-corePlayer.wishDir.x,
			-corePlayer.wishDir.z
		)
		if corePlayer.wallRay.is_colliding() and _canClimb:
			coreState.actionTransition("climb")
			return
	
	if corePlayer.is_on_floor():
		coreState.actionTransition("idle","reset")
