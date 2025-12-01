extends ControllerAction

var _searching:bool = false
var _headRoot:Sprite3D
var _tween:Tween

var _allSignals:Array[Sprite3D]


func _endESP() -> void:
	
	for sprite in _allSignals:
		var newTween:Tween = get_tree().create_tween()
		
		newTween.tween_property(
			sprite,
			"transparency",
			1,
			0.5
		)
		newTween.play()
		
		await newTween.finished
		sprite.queue_free()
		continue
		
	_allSignals.clear()
	
	
	return

func _initESP() -> void:
	
	var allPlayers:Array[Player] = util.getPlayersOnTeam(superEnum.teams.hider)
	var signalImage:CompressedTexture2D = load("res://assets/images/icons/aerial-signal.svg")
	
	
	for player in allPlayers:
		
		var newSprite:Sprite3D = Sprite3D.new()
		var newTween:Tween = get_tree().create_tween()
		
		newSprite.texture = signalImage
		newSprite.billboard = BaseMaterial3D.BILLBOARD_ENABLED
		newSprite.position = player.global_position
		newSprite.no_depth_test = true
		newSprite.transparency = 1
		
		newTween.tween_property(
			newSprite,
			"transparency",
			0,
			0.5
		)
		
		newTween.play()
		
		global.masterScene.add_child(newSprite)
		
		_allSignals.append(newSprite)
		
		await newTween.finished
		
		newTween.kill()
		
		
		continue
	
	
	return

func _createScanRing(_root:Node3D) -> void:
	coreSound.playSound(
		"res://assets/sound/sfx/hl1/fvox/bell.wav",
		0.8,
		0.2
	)
	
	
	if _tween:
		_tween.kill()
	
	
	_headRoot.pixel_size = 0.1
	_headRoot.transparency = 0
	_headRoot.show()
	
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
	
	await get_tree().create_timer(0.5).timeout
	
	coreSound.playSound(
		"res://assets/sound/sfx/character/big_cheese/TL_step_on_rake.mp3"
		)
		
	await get_tree().create_timer(0.8).timeout
	
	coreSound.playSound("res://assets/sound/sfx/character/big_cheese/scan.wav")
	
	await get_tree().create_timer(1.3).timeout
	
	_initESP()
	
	
	for i in range(5):
		_createScanRing(_headRoot)
		await get_tree().create_timer(0.8).timeout
		
	corePlayer.animator.animationSetSpeed(1)
	
	_endESP()
	
	
	
	
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
