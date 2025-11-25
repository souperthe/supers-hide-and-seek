extends ControllerAction

var _searching:bool = false
var _headRoot:Sprite3D
var _tween:Tween

func _createScanRing(root:Node3D) -> void:
	coreSound.playSound(
		"res://assets/sound/sfx/hl1/fvox/bell.wav"
	)
	
	
	if _tween:
		_tween.kill()
	
	
	_headRoot.pixel_size = 0.1
	_headRoot.transparency = 0
	
	_tween = get_tree().create_tween()
	
	_tween.set_parallel(true)
	
	_tween.tween_property(
		_headRoot,
		"pixel_size",
		128.0,
		0.5*4
	)
	_tween.tween_property(
		_headRoot,
		"transparency",
		1,
		0.8*3
	)
	
	
	return

func actionEnter(_message:String="")->void:

	corePlayer.animator.playAnimation("rake", 1)
	_searching = false
	
	for node in util.getDescendants(corePlayer.modelRoot):
		if node.name == "scan":
			_headRoot = node
			break
		else:
			continue
		continue
	
	await get_tree().create_timer(0.6).timeout
	
	coreSound.playSound(
		"res://assets/sound/sfx/character/big_cheese/TL_step_on_rake.mp3"
		)
		
	await get_tree().create_timer(0.8).timeout
	
	coreSound.playSound("res://assets/sound/sfx/character/big_cheese/scan.wav")
	
	await get_tree().create_timer(0.4).timeout
	
	
	for i in range(5):
		_createScanRing(_headRoot)
		await get_tree().create_timer(0.8).timeout
		
	corePlayer.animator.animationSetSpeed(1)
	
	
	
	
	return
	
func actioneExit()->void:
	return

func actionPhysics(delta:float)->void:
	
	corePlayer.velocity = corePlayer.velocity.lerp(Vector3.ZERO, 6*delta)
	
	if !_searching:
		if corePlayer.animator.animationGetPosition() > 1.3:
			corePlayer.animator.animationSetSpeed(0)
			_searching = true
		
	
	
	if corePlayer.animator.animationDone:
		coreState.actionTransition("idle")
		return
	return
