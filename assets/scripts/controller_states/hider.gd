extends ControllerState

@export var _tiltPivot:Node3D
@export var _light:SpotLight3D

func controllerStart(_message:String="")->void:
	actionTransition(_initalAction)
	return
	
func controllerProcess(delta:float) -> void:
	
	corePlayer.crouching = Input.is_action_pressed("player_crouch")
	corePlayer.collisionCrouching.disabled = !corePlayer.crouching
	corePlayer.collisionStanding.disabled = corePlayer.crouching
	
	if Input.is_action_just_pressed("player_light"):
		print("help")
		util.sfx("res://assets/sound/sfx/items/flashlight1.wav")
		_light.visible = !_light.visible
		
	handleViewmodelRotation(delta)
	
	
	var neckGoto:float = -float(corePlayer.crouching)*0.75
	
	corePlayer.neckOffset.position.y = lerpf(
		corePlayer.neckOffset.position.y,
		neckGoto,
		12*delta
	)
	
	_tiltPivot.rotation.z = lerpf(
		_tiltPivot.rotation.z,
		-corePlayer.rawDir.x/24,
		6*delta)
	
	return
