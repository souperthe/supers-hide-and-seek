class_name Notebook extends Node3D

@onready var sprite: Sprite3D = $Sprite

func _ready() -> void:
	sprite.frame = Networking.networkRNG.randi_range(0,6)
