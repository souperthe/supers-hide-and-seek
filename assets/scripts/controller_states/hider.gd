extends ControllerState

@export var _tiltPivot:Node3D
@export var _light:SpotLight3D

var _canCrouch:bool = false


func controllerStart(_message:String="")->void:
	corePlayer.neckOffset.position.y = 0
	actionTransition(_initalAction)
	return
	
func controllerProcess(delta:float) -> void:
	
	corePlayer.crouching = Input.is_action_pressed("player_crouch")
	
	if corePlayer.is_on_floor():
		_canCrouch = true
	
	if corePlayer.is_on_floor() and Input.is_action_just_pressed("player_crouch"):
		if _canCrouch:
			corePlayer.position.y -= 0.8
		
	if Input.is_action_just_released("player_crouch"):
		if _canCrouch:
			corePlayer.position.y += 0.8
		if !corePlayer.is_on_floor():
			_canCrouch = false
	
	corePlayer.collisionCrouching.disabled = !corePlayer.crouching
	corePlayer.collisionStanding.disabled = corePlayer.crouching
	
	if Input.is_action_just_pressed("player_light"):
		print("help")
		util.oneShotSFX("res://assets/sound/sfx/items/flashlight1.wav")
		_light.visible = !_light.visible
		corePlayer.events.setLight.rpc(_light.visible)
		corePlayer.events.sound.rpc("res://assets/sound/sfx/items/flashlight1.wav")
		
	_handleViewmodelRotation(delta)
	corePlayer.interactor.handleInteraction(delta)
	
	
	#var neckGoto:float = -float(corePlayer.crouching)*0.75
	#
	#corePlayer.neckOffset.position.y = lerpf(
		#corePlayer.neckOffset.position.y,
		#neckGoto,
		#12*delta
	#)
	
	_tiltPivot.rotation.z = lerpf(
		_tiltPivot.rotation.z,
		-corePlayer.rawDir.x/24,
		6*delta)
	
	return
