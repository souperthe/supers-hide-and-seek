extends Control

@onready var healthUI : Control = $"../Health"
@onready var timerUI : Control = $"../Timer"
@onready var chatUI : Control = $"../Chat"

func _ready() -> void:
	hide()

func visible_others(visible_bool : bool) -> void:
	healthUI.visible = visible_bool
	chatUI.visible = visible_bool
	timerUI.visible = visible_bool

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		if visible:
			visible_others(true)
			hide()
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			visible_others(false)
			show()
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
