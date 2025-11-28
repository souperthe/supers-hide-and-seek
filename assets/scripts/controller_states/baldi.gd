extends ControllerState

func controllerStart(_message:String="") -> void:
	corePlayer.animator.animatorSetup()
	corePlayer.neckOffset.position.y = 1
	actionTransition(_initalAction)
