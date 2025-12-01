extends ControllerAction

var _alreadyHit:bool = false

func actionEnter(_message:String="")->void:
	
	if _message == "airborne":
		corePlayer.velocity.y = corePlayer.jump_velocity/3
		
	_alreadyHit = false
		
	coreSound.playSound(
		"res://assets/sound/sfx/weapons/iceaxe/iceaxe_swing1.wav",
		randf_range(0.9,1.1)+.1,
		0.5
	)
	
	corePlayer.animator.playAnimation("Fredbear_Knock_Anim", 1.5)
	return
	
func actioneExit()->void:
	return
	
func actionPhysics(delta:float)->void:
	if !_alreadyHit and corePlayer.seeking:
		var knockBack:Vector3 = corePlayer.modelPivot.transform.basis.z*-120
		if corePlayer.hitbox.hitboxDamage("cheesebox", 9500, knockBack):
			_alreadyHit = true
	corePlayer.velocity.y -= corePlayer.gravity * delta
	if corePlayer.is_on_floor():
		corePlayer.velocity.x = lerpf(corePlayer.velocity.x, 0, 6 * delta)
		corePlayer.velocity.z = lerpf(corePlayer.velocity.z, 0, 6 * delta)
	if corePlayer.animator.animationDone:
		coreState.actionTransition("idle")
		return
	return
