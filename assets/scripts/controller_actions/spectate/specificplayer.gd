extends ControllerAction

var _spectatePosition:int = 0

func _getAlivePlayers() -> Array[Player]:
	
	var allPlayers:Array[Player]
	var possiblePlayers:Array[Node] = Networking.playersHolder.get_children()
	
	
	for child in possiblePlayers:
		
		if child is Player:
			
			if child.currentTeam == superEnum.teams.spectator:
				continue
				
			allPlayers.append(child)
			
			continue
		else:
			continue
		
		
		continue
	
	
	
	
	return allPlayers
	
func _playerDied(_pid : int) -> void:
	_spectatePosition -= 1
	return
	

func actionEnter(_message:String="")->void:
	corePlayer.firstPerson = false
	corePlayer.cameraArm.spring_length = 5
	_spectatePosition = 0
	
	SignalManager.peerDied.connect(_playerDied)
	return
	
func actioneExit()->void:
	SignalManager.peerDied.disconnect(_playerDied)
	return
	
func actionPhysics(_delta:float)->void:
	var alivePlayers:Array[Player] = _getAlivePlayers()
	var apLength:int = alivePlayers.size()
	
	if apLength == 0:
		coreState.actionTransition("freecam")
		print("nobody to spectate")
		return
		
		
	if _spectatePosition > apLength:
		_spectatePosition = 0
	elif _spectatePosition < 0:
		_spectatePosition = apLength
		
	var desiredPlayer:Player = alivePlayers[_spectatePosition]
	
	corePlayer.position = corePlayer.position.lerp(
		desiredPlayer.position,
		12*_delta
		)
	
	if Input.is_action_just_pressed("player_jump"):
		coreState.actionTransition("freecam")
		return
	
	return
