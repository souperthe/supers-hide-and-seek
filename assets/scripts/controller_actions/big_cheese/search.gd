extends ControllerAction

var _searching:bool = false

func actionEnter(_message:String="")->void:

	corePlayer.animator.playAnimation("rake", 1)
	_searching = false
	coreSound.playSound(
		"res://assets/sound/sfx/character/big_cheese/TL_step_on_rake.mp3")
	
	return
	
func actioneExit()->void:
	return

func actionPhysics(delta:float)->void:
	
	corePlayer.velocity = corePlayer.velocity.lerp(Vector3.ZERO, 6*delta)
	
	if !_searching:
		if corePlayer.animator.animationGetPosition() > 1.3:
			corePlayer.animator.animationSetSpeed(0)
			_searching = true
		
	
	
	if corePlayer.animator.animationDone:
		coreState.actionTransition("idle")
		return
	return
