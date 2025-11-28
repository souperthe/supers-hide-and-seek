extends ControllerAction

var timeleft: float = 0
var direction: Vector3

func actionEnter(_message:String="")->void:
	corePlayer.animator.playAnimation("slap")
	timeleft = 0.3

func actioneExit()->void:
	pass

func actionPhysics(delta:float)->void:
	timeleft -= delta
	
	if corePlayer.wishDir != Vector3.ZERO:
		direction = corePlayer.wishDir
	
	corePlayer.velocity.x = direction.x * 20
	corePlayer.velocity.z = direction.z * 20
	
	if timeleft <= 0:
		coreState.actionTransition("idle","reset")
	
	if !corePlayer.is_on_floor():
		coreState.actionTransition("jump")
