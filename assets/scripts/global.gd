@icon("res://addons/plenticons/icons/16x/objects/globe-gray.png")
class_name classGlobal extends Node

var look_sensitivity : float = 0.006
var masterScene : MasterScene


var microphoneInput : AudioStreamPlayer
var microphoneMuted: bool = false


func _init() -> void:
	print("starting game")
	return
	
func _ready() -> void:
	Steam.steamInit(
		480, true
	)
	
	microphoneInput = AudioStreamPlayer.new()
	microphoneInput.bus = "Microphone"
	microphoneInput.stream = AudioStreamMicrophone.new()
	add_child(microphoneInput)
	microphoneInput.play()
	return


func _process(_delta: float) -> void:
	Steam.run_callbacks()
	return
