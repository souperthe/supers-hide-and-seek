extends CanvasLayer

@export var masterScene : MasterScene
@onready var main: Control = $menu/Main
@onready var seekerPicker: Control = $menu/SeekerPicker

func _enterGame() -> void:
	#hide()
	masterScene.switch_scene("res://assets/objects/lobby.tscn")
	return

func _ready() -> void:
	SignalManager.lobbySucess.connect(_enterGame)
	SignalManager.hostSucess.connect(_enterGame)
	return
