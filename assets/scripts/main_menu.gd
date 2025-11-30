extends CanvasLayer

@onready var main: Control = $menu/Main
@onready var seekerPicker: Control = $menu/SeekerPicker

func _enterGame() -> void:
	#hide()
	global.masterScene.switch_scene("res://assets/scenes/sub/lobby.tscn")
	return

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	SignalManager.lobbySucess.connect(_enterGame)
	SignalManager.hostSucess.connect(_enterGame)
	return
