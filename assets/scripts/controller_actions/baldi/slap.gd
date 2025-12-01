extends ControllerAction

var slapLength: float = 0
var slapPower: float = 20
var direction: Vector3


var _attacked:bool = false

func actionEnter(_message:String="")->void:
	coreSound.playSound(
		"res://assets/resources/rnd_sound/baldislap.tres",
		1,
		1
		)
	corePlayer.animator.playAnimation("slap")
	slapLength = 0.3
	_attacked = false

func actioneExit()->void:
	pass

func actionPhysics(delta:float)->void:
	slapLength -= delta
	
	if !_attacked and corePlayer.seeking:
		var knockBack:Vector3 = corePlayer.modelPivot.transform.basis.z*-120
		if corePlayer.hitbox.hitboxDamage("cheesebox", 9500, knockBack, false):
			_attacked = true
	
	corePlayer.hitbox.openDoors("cheesebox")
	
	if corePlayer.wishDir != Vector3.ZERO:
		direction = corePlayer.wishDir
		corePlayer.modelPivot.rotation.y = atan2(
			-corePlayer.wishDir.x,
			-corePlayer.wishDir.z
		)
		
	if Input.is_action_just_pressed("player_jump"):
		coreState.actionTransition("jump","jump")
		return
	
	corePlayer.velocity.x = direction.x * slapPower
	corePlayer.velocity.z = direction.z * slapPower
	
	if slapLength <= 0:
		coreState.actionTransition("idle","reset")
	
	if !corePlayer.is_on_floor():
		coreState.actionTransition("jump")
