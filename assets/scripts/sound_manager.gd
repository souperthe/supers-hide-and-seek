@icon("res://addons/plenticons/icons/16x/objects/cd-gray.png")
class_name SoundManager extends Node


@export var _corePlayer:Player



func playSound(soundPath:String, soundPitch:float=1, soundVolume:float=1) -> void:
	
	util.oneShotSFX3D(
		_corePlayer,
		soundPath,
		soundPitch,
		soundVolume,
		0,
		false
	)
	
	_corePlayer.events.sound.rpc(soundPath, soundPitch, soundVolume)
	
	return
