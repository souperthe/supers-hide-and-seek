extends Node3D

var _open:bool = false

@export var locked:bool = false
@export var openSound:AudioStream
@export var closeSound:AudioStream


var _usedTime:float = 0

func _on_area_3d_interacted(who: Player) -> void:
	
	var currentTime:float = Time.get_unix_time_from_system()
	var timeDiff:float = currentTime-_usedTime
	
	if timeDiff < 0.2:
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
	
	
	pass # Replace with function body.
