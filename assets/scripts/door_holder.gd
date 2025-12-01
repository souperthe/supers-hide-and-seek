extends Node3D

var _open:bool = false

@export var locked:bool = false
@export var openSound:AudioStream
@export var closeSound:AudioStream

@export var _hinge:Node3D

@export var _brokenScene:PackedScene


var _usedTime:float = 0
var _hingeTween:Tween

func _on_area_3d_interacted(who: Player) -> void:
	
	var currentTime:float = Time.get_unix_time_from_system()
	var timeDiff:float = currentTime-_usedTime
	
	if timeDiff < 0.15:
		return
	
	_usedTime = Time.get_unix_time_from_system()
	
	if locked:
		util.oneShotSFX3D(
			self,
			"res://assets/sound/sfx/doors/door_locked2.wav"
		)
		return
	
	_open = !_open
	print(_open)
	
	if _hingeTween:
		_hingeTween.kill()
		
	var positionDiffrence:Vector3= (self.global_position - who.global_position).normalized()
	var swingDirection:float = positionDiffrence.dot(global_transform.basis.z)
	
	swingDirection = clampf(swingDirection*100, -1, 1)
	
	_hingeTween = get_tree().create_tween()
	
	var tweenTime:float = 0.3
	
	if _open:
		
		if who.currentTeam == superEnum.teams.hider:
		
			SignalManager.baldi_doorOpen.emit(
				$Hinge/CSGBox3D.global_position
				)
	
		_hingeTween.tween_property(
			_hinge,
			"rotation_degrees",
			Vector3(0, 90*swingDirection, 0),
			tweenTime
		)
		
		util.oneShotSFX3D(
			_hinge,
			openSound.resource_path
		)
		
	else:
	
		
		_hingeTween.tween_property(
			_hinge,
			"rotation_degrees",
			Vector3(0, 0, 0),
			tweenTime
		)
		
	
	_hingeTween.play()
	
	if !_open:
		await _hingeTween.finished
		
		if _open:
			return
			
		
			
		util.oneShotSFX3D(
			_hinge,
			closeSound.resource_path
		)
	
	
	pass # Replace with function body.


func _on_collision_broken(who: Player) -> void:
	if _hingeTween:
		_hingeTween.kill()
		
	if locked:
		return
		
		
		
	var flingToward:Vector3 = who.modelPivot.global_transform.basis.z
	var brokenDoor:RigidBody3D = _brokenScene.instantiate()
	brokenDoor.position = $Hinge/CSGBox3D.global_position
	brokenDoor.rotation = $Hinge/CSGBox3D.global_rotation
	
	global.masterScene.add_child(brokenDoor)
	
	brokenDoor.linear_velocity = flingToward*-36
	
	util.oneShotSFX3D(
		brokenDoor,
		"res://assets/resources/rnd_sound/break_door.tres"
	)
	
	
	$Hinge.queue_free()
	pass # Replace with function body.


func _on_collision_force_open(who: Player) -> void:
	if _open:
		return
		
	if locked:
		return
		
	$Hinge/Area3D.openEvent.rpc()
	pass # Replace with function body.
