extends Node

@onready var main: Control = $Main
@onready var seekerPicker: Control = $SeekerPicker

func _enterGame() -> void:
	$Main.hide()
	$SeekerPicker.hide()
	return

func _ready() -> void:
	SignalManager.lobbySucess.connect(_enterGame)
	SignalManager.hostSucess.connect(_enterGame)
	return
