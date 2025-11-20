@icon("res://addons/plenticons/icons/svg/creatures/person-red.svg")
class_name Player extends CharacterBody3D

@export var camera:Camera3D
@export var controller:ControllerManager


func _setupAuthority()->void:
	camera.make_current()
	return


func _ready() -> void:
	if !is_multiplayer_authority():
		return
	_setupAuthority()
	return
