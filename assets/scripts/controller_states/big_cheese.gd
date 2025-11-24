extends ControllerState

func controllerStart(_message:String="") -> void:
	corePlayer.neckOffset.position.y = 1
	actionTransition(_initalAction)
	return
	
func controllerPhysics(delta:float) -> void:
	corePlayer.interactor.handleInteraction(delta)
	return
	
	
func useAbility() -> bool:
	if corePlayer.abilityTimer.time_left > 0:
		return false
	corePlayer.abilityTimer.start()
	actionTransition("search")
	return true
