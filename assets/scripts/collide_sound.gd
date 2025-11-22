@icon("res://addons/plenticons/icons/svg/2d/dotspark-white.svg")
class_name CollideSound extends Node

@export var sound:AudioStream

var _parent:RigidBody3D


func _playSound(body:Node)->void:
	
	if _parent.linear_velocity.length() > 0.5:
		util.sfx3D(
			_parent,
			sound.resource_path
		)
	
	return

func _ready() -> void:
	
	var parent:Node = get_parent()
	
	if !(parent is RigidBody3D):
		return
		
	var realParent:RigidBody3D = parent
	
	print("yea")
	
	realParent.body_entered.connect(_playSound)
	_parent = realParent
	
	
	return
