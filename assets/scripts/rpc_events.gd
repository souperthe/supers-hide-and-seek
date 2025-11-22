@icon("res://assets/images/icons/aerial-signal.svg")
class_name ClassRPCEvents extends Node

var _networkTransform:Transform3D


@export var _light:SpotLight3D
@export var _corePlayer:Player

@rpc("authority", "call_remote", "unreliable")
func updateTransform(newTransform:Transform3D)->void:
	_networkTransform = newTransform
	_corePlayer.transform = newTransform
	return
	
@rpc("any_peer", "call_remote", "reliable")
func setLight(visible:bool) -> void:
	_light.visible = visible
	return
	
@rpc("any_peer", "call_local", "reliable")
func sendMessage(message:String) -> void:
	var senderID:int = multiplayer.get_remote_sender_id()
	
	SignalManager.chatMessage.emit(senderID, message)
	
	
	return


func _ready() -> void:
	set_multiplayer_authority(
		_corePlayer.authID
	)
	return

func _physics_process(_delta: float) -> void:
	if !is_multiplayer_authority():
		return
	
	if _networkTransform != _corePlayer.transform:
		updateTransform.rpc(_corePlayer.transform)
	
	return

@rpc("authority", "call_remote", "unreliable")
func sound(soundPath:String, soundPitch:float=1, soundVolume:float=1)->void:
	
	util.sfx3D(
		_corePlayer,
		soundPath,
		soundPitch,
		soundVolume
	)
	
	return
