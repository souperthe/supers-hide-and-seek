extends CanvasLayer

@onready var UI: Control = $UI
@onready var videoButton: Button = $UI/ButtonsList/VIDEO
@onready var audioButton: Button = $UI/ButtonsList/AUDIO
@onready var inputButton: Button = $UI/ButtonsList/INPUT

@onready var selected: StyleBoxFlat = preload("res://assets/resources/style/settings.tres")
@onready var unselected: StyleBoxFlat = preload("res://assets/resources/style/settings_unselected.tres")

func _ready() -> void:
	#set_style(audioButton,true)
	pass

func set_style(button : Button, select: bool) -> void:
	pass
