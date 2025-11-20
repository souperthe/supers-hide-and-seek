@icon("res://addons/plenticons/icons/16x/objects/cd-gray.png")
class_name SoundManager extends Node


@export var _corePlayer:Player



func playSound(soundPath:String, soundPitch:float=1, soundVolume:float=1) -> void:
	
	util.sfx3D(
		_corePlayer,
		soundPath,
		soundPitch,
		soundVolume
	)
	
	return
