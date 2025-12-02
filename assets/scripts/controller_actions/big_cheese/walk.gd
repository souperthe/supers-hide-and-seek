extends ControllerAction

var _stepTime:float = 0

func actionEnter(_message:String="")->void:
	
	corePlayer.animator.playAnimation("walk", 1.5)
	_stepTime = 0
	
	coreSound.playSound(
		"res://assets/resources/rnd_sound/cog_step.tres",
		1,
		0.5
		)
	
	return
	
func actioneExit()->void:
	return

func actionPhysics(delta:float)->void:
	
	if Input.is_action_just_pressed("player_jump"):
		coreState.actionTransition("fly_transition", "enter")
		return
		
	if Input.is_action_just_pressed("player_attack"):
		coreState.actionTransition("attack", "enter")
		return
	
	if corePlayer.wishDir == Vector3.ZERO:
		coreState.actionTransition("idle")
		return
		
	corePlayer.modelPivot.rotation.y = atan2(
		-corePlayer.wishDir.x,
		-corePlayer.wishDir.z
	)
	
	if !corePlayer.is_on_floor():
		coreState.actionTransition("fall")
		return
	
	
	corePlayer.velocity = corePlayer.wishDir * (corePlayer.walk_speed/1.5)
	
	_stepTime += corePlayer.animator._animator.speed_scale * delta
	
	if Input.is_action_just_pressed("player_ability"):
		if coreState.useAbility("search"):
			return
	
	if _stepTime > 0.8:
		coreSound.playSound(
			"res://assets/resources/rnd_sound/cog_step.tres",
			1,
			0.5
			)
		_stepTime = 0
	
	
	return
