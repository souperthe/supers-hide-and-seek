extends ControllerAction

var _finishingUp:bool = false
var _attacked:bool = false

func actionEnter(_message:String="")->void:
	
	corePlayer.animator.playAnimation("magic3", 2, 0.63)
	coreSound.playSound(
		"res://assets/sound/sfx/weapons/iceaxe/iceaxe_swing1.wav",
		randf_range(0.9,1.1)
		)
		
	_finishingUp = false
	_attacked = false
	

	
	return
	
func actioneExit()->void:
	return


func actionPhysics(delta:float)->void:
	corePlayer.velocity = corePlayer.velocity.lerp(Vector3.ZERO, 6*delta)
	
	
	if corePlayer.animator.animationGetPosition() > 1.53 and !_finishingUp:
		print("hi")
		corePlayer.animator.animationSeek(2.93)
		_finishingUp = true
		
		
	if !_attacked:
		if corePlayer.hitbox.hitboxDamage("cheesebox", 95, corePlayer.velocity):
			#corePlayer.animator.animationSeek(2.93)
			corePlayer.velocity = -corePlayer.velocity
			_attacked = true
	
	if !(corePlayer.is_on_floor()):
		coreState.actionTransition("fall")
		return
	
	
	if corePlayer.animator.animationDone:
		coreState.actionTransition("idle")
		return
	
	
	return
