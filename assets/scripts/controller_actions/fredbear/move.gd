extends ControllerAction

var _stepTime:float = 0

func actionEnter(_message:String="")->void:
	
	corePlayer.animator.playAnimation("Fredbear_Walk_Anim")
	_stepTime = 0
	
	
	return
	
func actioneExit()->void:
	return

func actionPhysics(delta:float)->void:

	if corePlayer.wishDir == Vector3.ZERO:
		coreState.actionTransition("idle")
		return
		
	if Input.is_action_just_pressed("player_jump"):
		coreState.actionTransition("jump", "jump")
		return
		
	if !corePlayer.is_on_floor():
		coreState.actionTransition("jump")
		return
		
	var desiredRotation:float = atan2(
		-corePlayer.wishDir.x,
		-corePlayer.wishDir.z
	)
	
	corePlayer.modelPivot.rotation.y = lerp_angle(
		corePlayer.modelPivot.rotation.y,
		desiredRotation,
		10*delta
	)
	
	var speed:float = corePlayer.walk_speed/2
	var running:bool = Input.is_action_pressed("player_sprint") and get_parent().runTimer > 0
	
	
	if running:
		corePlayer.animator.playAnimation("Fredbear_Run_Anim", 1.5)
		speed = corePlayer.walk_speed*3.2
	else:
		corePlayer.animator.playAnimation("Fredbear_Walk_Anim")
		
		
	
	corePlayer.velocity = corePlayer.wishDir * speed
	_stepTime += corePlayer.velocity.length() * delta
	
	if _stepTime > 2.8:
		var volume:float = 0.3
		
		if running:
			volume = 0.2
			
		coreSound.playSound(
			"res://assets/resources/rnd_sound/fredbear_step.tres",
			1,
			volume
			)
			
		_stepTime = 0
	
	
	return
