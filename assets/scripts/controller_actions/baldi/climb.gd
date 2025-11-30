extends ControllerAction

var _climbSpeed:float = 0

func actionEnter(_message:String="")->void:
	corePlayer.animator.playAnimation("climb", 0)
	_climbSpeed = corePlayer.walk_speed/1.5
	
	corePlayer.modelPivot.look_at(
		corePlayer.global_position+(-corePlayer.wallRay.get_collision_normal())
	)
		
	corePlayer.velocity = Vector3.ZERO
	return
	
func actioneExit()->void:
	return
	
func actionPhysics(delta:float)->void:
	
	if !corePlayer.wallRay.is_colliding():
		var fling:Vector3 = corePlayer.modelPivot.global_transform.basis.z * _climbSpeed
		corePlayer.velocity = -fling
		coreState.actionTransition("idle","reset")
		return
	
	if Input.is_action_just_pressed("player_jump"):
		coreState.actionTransition("jump", "noclimb")
		var fling:Vector3 = corePlayer.modelPivot.global_transform.basis.z * 6
		corePlayer.velocity.x = fling.x
		corePlayer.velocity.z = fling.z
		return
		
	#if corePlayer.is_on_floor():
		#coreState.actionTransition("idle")
		#return
		
	_climbSpeed = lerpf(
		_climbSpeed,
		corePlayer.walk_speed/2,
		0.5*delta
	)
	
	
	#corePlayer.animator.animationSetSpeed(
		#(-_climbSpeed * corePlayer.rawDir.y)/5
	#)
	
	corePlayer.velocity.y = -corePlayer.rawDir.y * _climbSpeed
	return
