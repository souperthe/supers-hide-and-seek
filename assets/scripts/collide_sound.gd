@icon("res://addons/plenticons/icons/svg/2d/dotspark-white.svg")
class_name CollideSound extends Node

@export var sound:AudioStream

var _parent:RigidBody3D


func _playSound(_body:Node)->void:
	
	if _parent.linear_velocity.length() > 0.5:
		
		util.oneShotSFX3D(
			_parent,
			sound.resource_path,
			1,
			0.2
		)
	
	return

func _ready() -> void:
	
	var parent:Node = get_parent()
	
	if !(parent is RigidBody3D):
		return
		
	var realParent:RigidBody3D = parent
	
	print("yea")
	
	realParent.body_entered.connect(_playSound)
	realParent.contact_monitor = true
	realParent.max_contacts_reported = 1
	realParent.continuous_cd = true
	realParent.can_sleep = false
	realParent.freeze = false
	_parent = realParent
	
	
	return
