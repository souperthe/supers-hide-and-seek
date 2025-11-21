@icon("res://addons/plenticons/icons/svg/2d/circle-white.svg")
class_name InteractionManager extends Node

@export var _corePlayer:Player
@export var _holdPoint:Node3D

var currentBody:RigidBody3D

func handleInteraction(delta:float)->void:
	
	if currentBody:
		currentBody.global_position = currentBody.global_position.lerp(
			_holdPoint.global_position,
			32*delta
		)
		currentBody.global_rotation = _holdPoint.global_rotation
		
		if Input.is_action_just_pressed("player_interact"):
			
			
			var mouseVelo:Vector2 = Input.get_last_mouse_velocity()
			
			var fling:Vector3 = (_corePlayer._neck.global_transform.basis * Vector3(mouseVelo.x, 0, mouseVelo.y)).normalized()
			
			print(mouseVelo.length())
			
			if mouseVelo.length() < 500:
				fling = Vector3.ZERO
				
			currentBody.linear_velocity = fling*12
			util.setCollisions(currentBody, false)
			currentBody.freeze = false
			currentBody = null
			return
		
		
		return
	
	var interactRay:RayCast3D = _corePlayer.interactRay
	var interactable:Object = interactRay.get_collider()
	
	
	if interactable == null:
		return
		
	if !(interactable is RigidBody3D):
		return
		
	var body:RigidBody3D = interactable
		
	if Input.is_action_just_pressed("player_interact"):
		body.freeze = true
		currentBody = body
		util.setCollisions(body, true)
	
	
	
	return
