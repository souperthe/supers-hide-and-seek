extends ControllerAction

var _movingSpeed:float = 0
var _canClimb:bool = false

func actionEnter(message:String="")->void:
	_canClimb = true
	_movingSpeed = corePlayer.velocity.length()
	if message == "jump":
		corePlayer.animator.playAnimation("Fredbear_Jump_Start_Anim")
		corePlayer.velocity.y = corePlayer.jump_velocity*1.5
		coreSound.playSound(
			"res://assets/sound/sfx/weapons/iceaxe/iceaxe_swing1.wav",
			randf_range(0.9,1.1)-.3,
			0.5
		)
	elif message == "noclimb":
		corePlayer.animator.playAnimation("Fredbear_Jump_Start_Anim")
		corePlayer.velocity.y = corePlayer.jump_velocity*1
		_canClimb = false
	else:
		corePlayer.animator.playAnimation("Fredbear_Jump_Start_Anim", 1, 0.375)
	return
	
func actioneExit()->void:
	return

func actionPhysics(delta:float)->void:
	
	corePlayer.velocity.y -= (corePlayer.gravity) * delta
	
	var desiredRotation:float = atan2(
		-corePlayer.wishDir.x,
		-corePlayer.wishDir.z
	)
	
	if Input.is_action_just_pressed("player_attack"):
		coreState.actionTransition("punch", "airborne")
		return
	
	if corePlayer.is_on_floor():
		coreState.actionTransition("idle", "land")
		return
	
	if corePlayer.wishDir != Vector3.ZERO:
		var direction:Vector3 = corePlayer.modelPivot.global_transform.basis.z
		
		corePlayer.velocity.x = -direction.x * _movingSpeed
		corePlayer.velocity.z = -direction.z * _movingSpeed
		
		
		corePlayer.modelPivot.rotation.y = lerp_angle(
			corePlayer.modelPivot.rotation.y,
			desiredRotation,
			6*delta
		)
		
		if corePlayer.wallRay.is_colliding() and _canClimb:
			coreState.actionTransition("climbing")
			return
	return
