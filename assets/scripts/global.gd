@icon("res://addons/plenticons/icons/16x/objects/globe-gray.png")
class_name classGlobal extends Node

var look_sensitivity : float = 0.006
var masterScene : MasterScene


func _init() -> void:
	print("starting game")
	return
	
func _ready() -> void:
	Steam.steamInit(
		480, true
	)
	return


func _process(_delta: float) -> void:
	Steam.run_callbacks()
	return
