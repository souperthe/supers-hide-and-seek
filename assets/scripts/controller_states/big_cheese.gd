extends ControllerState

func controllerStart(_message:String="") -> void:
	corePlayer.neckOffset.position.y = 1
	actionTransition(_initalAction)
	return
	
func controllerPhysics(delta:float) -> void:
	corePlayer.interactor.handleInteraction(delta)
	return
