extends ControllerAction

var slapLength: float = 0
var slapPower: float = 20
var direction: Vector3

func actionEnter(_message:String="")->void:
	corePlayer.animator.playAnimation("slap")
	slapLength = 0.3

func actioneExit()->void:
	pass

func actionPhysics(delta:float)->void:
	slapLength -= delta
	
	if corePlayer.wishDir != Vector3.ZERO:
		direction = corePlayer.wishDir
	
	corePlayer.velocity.x = direction.x * slapPower
	corePlayer.velocity.z = direction.z * slapPower
	
	if slapLength <= 0:
		coreState.actionTransition("idle","reset")
	
	if !corePlayer.is_on_floor():
		coreState.actionTransition("jump")
