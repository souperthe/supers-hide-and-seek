extends ControllerAction

var _climbSpeed:float = 0

var _stepTime:float = 0

func actionEnter(_message:String="")->void:
	corePlayer.animator.playAnimation("Fredbear_Climb_Up_Anim", 0)
	#core.plr.model.look_at(core.plr.model.global_position+_isOnLedge.get_collision_normal())\
	corePlayer.modelPivot.look_at(
		corePlayer.global_position+(-corePlayer.wallRay.get_collision_normal())
	)
	_climbSpeed = Vector3(corePlayer.velocity.x,0,corePlayer.velocity.z).length()
	
	print(_climbSpeed)
	
	if _climbSpeed < corePlayer.walk_speed/1.5:
		_climbSpeed = corePlayer.walk_speed/1.5
		
	corePlayer.velocity = Vector3.ZERO
	_stepTime = 0
	return
	
func actioneExit()->void:
	return
	
func actionPhysics(delta:float)->void:
	
	if !corePlayer.wallRay.is_colliding():
		var fling:Vector3 = corePlayer.modelPivot.global_transform.basis.z * _climbSpeed
		corePlayer.velocity = -fling
		coreState.actionTransition("move")
		return
	
	if Input.is_action_just_pressed("player_jump"):
		coreState.actionTransition("jump", "no_climb")
		var fling:Vector3 = corePlayer.modelPivot.global_transform.basis.z * 6
		corePlayer.velocity.x = fling.x
		corePlayer.velocity.z = fling.z
		return
		
	if corePlayer.is_on_floor():
		coreState.actionTransition("idle")
		return
		
	_climbSpeed = lerpf(
		_climbSpeed,
		corePlayer.walk_speed/2,
		0.5*delta
	)
	
	
	corePlayer.animator.animationSetSpeed(
		(-_climbSpeed * corePlayer.rawDir.y)/5
	)
	
	corePlayer.velocity.y = -corePlayer.rawDir.y * _climbSpeed
	
	_stepTime += corePlayer.velocity.length() * delta
	if _stepTime > 1.8:
		var volume:float = 0.15
			
		coreSound.playSound(
			"res://assets/resources/rnd_sound/fredbear_step.tres",
			1.2,
			volume
			)
			
		_stepTime = 0
	return
