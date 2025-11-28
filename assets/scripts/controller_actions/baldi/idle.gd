extends ControllerAction

var canSlap: float = 1
var slapCooldown: float = 0.4

func actionEnter(message:String="")->void:
	corePlayer.animator.playAnimation("idle")
	if message == "reset":
		canSlap = slapCooldown # cd
	pass

func actioneExit()->void:
	pass

func actionPhysics(delta:float)->void:
	corePlayer.velocity.x = 0
	corePlayer.velocity.z = 0
	
	canSlap -= delta
	if corePlayer.wishDir != Vector3.ZERO and canSlap <= 0:
		coreState.actionTransition("slap")
	
	if !corePlayer.is_on_floor():
		coreState.actionTransition("jump")
