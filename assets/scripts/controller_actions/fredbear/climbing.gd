extends ControllerAction

var _climbSpeed:float = 0

func actionEnter(_message:String="")->void:
	corePlayer.animator.playAnimation("Fredbear_Climb_Up_Anim", 0)
	#core.plr.model.look_at(core.plr.model.global_position+_isOnLedge.get_collision_normal())\
	corePlayer.modelPivot.look_at(
		corePlayer.global_position+(-corePlayer.wallRay.get_collision_normal())
	)
	_climbSpeed = corePlayer.velocity.length()
	
	print(_climbSpeed)
	
	if _climbSpeed < corePlayer.walk_speed/1.5:
		_climbSpeed = corePlayer.walk_speed/1.5
		
	corePlayer.velocity = Vector3.ZERO
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
		
	_climbSpeed = lerpf(
		_climbSpeed,
		corePlayer.walk_speed/2,
		0.5*delta
	)
	
	
	corePlayer.animator.animationSetSpeed(
		(-_climbSpeed * corePlayer.rawDir.y)/5
	)
	
	corePlayer.velocity.y = -corePlayer.rawDir.y * _climbSpeed
	return
