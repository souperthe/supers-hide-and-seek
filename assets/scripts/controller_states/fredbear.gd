extends ControllerState

var runTimer:float = 10

func controllerStart(_message:String="") -> void:
	corePlayer.neckOffset.position.y = 1
	actionTransition(_initalAction)
	return
	
func controllerPhysics(delta:float) -> void:
	if Input.is_action_just_pressed("player_ability"):
		if useAbility():
			return
	runTimer -= delta*2
	return

func useAbility() -> bool:
	if corePlayer.abilityTimer.time_left > 0:
		return false
	runTimer = 18
	corePlayer.abilityTimer.start()
	return true
