class_name TeleporterUI extends Control

@onready var sprite = $Sprite
var TeleporterPart : TeleportWrapper

func _ready() -> void:
	sprite.frame = TeleporterPart.sprite.frame
