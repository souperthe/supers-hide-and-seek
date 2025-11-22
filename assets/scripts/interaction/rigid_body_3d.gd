extends Interaction

@export var _holdPoint:Node3D

func enterInteraction(interactable:Object) -> void:
	
	var rigidBody:RigidBody3D = interactable
	
	
	core.startProcess(self)
	currentlyInteractable = rigidBody
	
	corePlayer.events.setAuthority.rpc(rigidBody.get_path())
	
	#rigidBody.freeze = true
	
	util.setCollisions(rigidBody, true)
	
	
	return
	
func interactionProcess(delta:float) -> void:
	
	var rigidBody:RigidBody3D = currentlyInteractable
	
	rigidBody.linear_velocity = Vector3.ZERO
	
	rigidBody.global_position = rigidBody.global_position.lerp(
		_holdPoint.global_position,
		24*delta
		)
	rigidBody.global_rotation = _holdPoint.global_rotation
	
	if Input.is_action_just_pressed("player_rightclick"):
		rigidBody.freeze = false
		
		rigidBody.linear_velocity = corePlayer.camera.global_transform.basis.z*-15
		
		
		core.endProcess(self)
		util.setCollisions(rigidBody, false)
		return
	
	if Input.is_action_just_pressed("player_interact"):
		
		var flingDiffrence:Vector3 = _holdPoint.global_position - rigidBody.global_position
		
		print(flingDiffrence)
		
		
		rigidBody.freeze = false
		rigidBody.linear_velocity = flingDiffrence*24
		core.endProcess(self)
		util.setCollisions(rigidBody, false)
		return
	
	
	return
