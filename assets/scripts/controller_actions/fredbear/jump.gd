extends ControllerAction

var _movingSpeed:float = 0

func actionEnter(message:String="")->void:
	_movingSpeed = corePlayer.velocity.length()
	if message == "jump":
		corePlayer.animator.playAnimation("Fredbear_Jump_Start_Anim")
		corePlayer.velocity.y = corePlayer.jump_velocity*1.5
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
	
	if corePlayer.is_on_floor():
		coreState.actionTransition("idle")
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
	return
