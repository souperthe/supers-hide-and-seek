extends ControllerAction

func actionEnter(_message:String="")->void:
	return
	
func actioneExit()->void:
	return
	
func actionProcess(_delta:float)->void:
	
	var speed:float = corePlayer.walk_speed*2
	
	if Input.is_action_pressed("player_sprint"):
		speed *= 2
		
		
	var goto:Vector3 = corePlayer.cameraDir*speed
	
	corePlayer.position += (goto*_delta)
	
	
	return
