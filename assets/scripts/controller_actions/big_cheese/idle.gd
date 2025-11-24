extends ControllerAction


func actionEnter(message:String="")->void:
	
	corePlayer.animator.playAnimation("neutral")
	
	if message == "land":
		corePlayer.animator.playAnimation("slip-forward", 1.5, 2.84)
	
	corePlayer.velocity = Vector3.ZERO
	
	return
	
func actioneExit()->void:
	return
	
func actionPhysics(_delta:float)->void:
	
	if Input.is_action_just_pressed("player_emote"):
		corePlayer.animator.playAnimation("song-and-dance")
		
	if Input.is_action_just_pressed("player_attack"):
		coreState.actionTransition("attack", "enter")
		return
		
	if Input.is_action_just_pressed("player_ability"):
		if get_parent().useAbility():
			return
		
	if Input.is_action_just_pressed("player_jump"):
		coreState.actionTransition("fly_transition", "enter")
		return
		
		
	if !corePlayer.is_on_floor():
		coreState.actionTransition("fall")
		return
	
	if corePlayer.wishDir != Vector3.ZERO:
		coreState.actionTransition("walk")
		return
		
	if corePlayer.animator.animationName != "neutral":
		if corePlayer.animator.animationDone:
			corePlayer.animator.playAnimation("neutral")
		
	
	return
