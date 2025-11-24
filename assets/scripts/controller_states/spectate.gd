extends ControllerState



func controllerStart(_message:String="") -> void:
	corePlayer.useMovement = false
	actionTransition(_initalAction)
	return
