extends ControllerAction

var canSlap: bool = true
var slapTimeLeft: float = 1
var slapCooldown: float = 0.4

func actionEnter(message:String="")->void:
	corePlayer.animator.playAnimation("idle")
	if message == "reset":
		slapTimeLeft = slapCooldown # cd
	pass

func actioneExit()->void:
	pass

func actionPhysics(delta:float)->void:
	corePlayer.velocity.x = 0
	corePlayer.velocity.z = 0
	
	if Input.is_action_just_pressed("player_jump"):
		coreState.actionTransition("jump","jump")
		return
	
	
	slapTimeLeft -= delta
	if corePlayer.wishDir != Vector3.ZERO and slapTimeLeft <= 0 and canSlap:
		coreState.actionTransition("slap")
	
	if !corePlayer.is_on_floor():
		coreState.actionTransition("jump")
