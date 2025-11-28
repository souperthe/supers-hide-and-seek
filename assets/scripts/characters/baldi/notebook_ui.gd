class_name NotebookUI extends Control

@onready var sprite = $Sprite
var notebookPart : Notebook

func _ready() -> void:
	sprite.frame = notebookPart.sprite.frame
