@icon("res://assets/images/icons/aerial-signal.svg")
class_name ClassRPCEvents extends Node

var _networkTransform:Transform3D


@export var _light:SpotLight3D
@export var _corePlayer:Player
@export var _voiceEmitter:AudioStreamPlayer3D

@rpc("any_peer", "call_local", "reliable")
func damageEvent(amount:float, knockback:Vector3) -> void:
	if multiplayer.get_unique_id() != _corePlayer.authID:
		return
		
	var damager:int = multiplayer.get_remote_sender_id()
	var damagerPlayer:Player = util.getPlayer(damager)
		
		
	_corePlayer.takeDamage(amount, knockback)
	
	
	return

@rpc("authority", "call_remote", "reliable")
func imReady() -> void:
	var sender:int = multiplayer.get_remote_sender_id()
	
	
	Networking.localPlayer.synchronizer.set_visibility_for(sender, true)
	
	
	return

@rpc("authority", "call_local", "reliable")
func setupGrabbable(nodePath:String, collisions:bool) -> void:
	
	var senderID:int = multiplayer.get_remote_sender_id()
	var desiredNode:Node = get_node(nodePath)
	
	if desiredNode == null:
		return
		
	desiredNode.set_multiplayer_authority(senderID)
	
	util.setCollisions(desiredNode, collisions)
	
	
	
	return

@rpc("authority", "call_remote", "unreliable")
func updateTransform(newTransform:Transform3D, modelrootRot:Vector3)->void:
	_networkTransform = newTransform
	_corePlayer.transform = newTransform
	_corePlayer.modelPivot.rotation = modelrootRot
	return
	
@rpc("any_peer", "call_remote", "reliable")
func setLight(visible:bool) -> void:
	_light.visible = visible
	return
	
@rpc("authority", "call_local", "reliable")
func callDead() -> void:
	_corePlayer.modelRoot.hide()
	_corePlayer.collisionStanding.disabled = true
	_corePlayer.collisionCrouching.disabled = true
	_corePlayer.currentTeam = superEnum.teams.spectator
	_corePlayer.health = 0
	_voiceEmitter.stop()
	SignalManager.peerDied.emit(_corePlayer.authID)
	
	if Networking.localPlayer == _corePlayer:
		_corePlayer.controller.changeState("spectate")
	
	
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
		updateTransform.rpc(_corePlayer.transform, _corePlayer.modelPivot.rotation)
	
	return
	
@rpc("authority", "call_remote", "unreliable")
func animationSeek(timePosition:float) -> void:
	_corePlayer.animator.animationSeek(timePosition)
	return
	
@rpc("authority", "call_remote", "unreliable")
func animationSpeed(speed:float) -> void:
	_corePlayer.animator.animationSetSpeed(speed)
	return
	
@rpc("authority", "call_remote", "unreliable")
func animation(desiredAnimation:String, speed:float=1, seek:float=0) -> void:
	
	
	_corePlayer.animator.playAnimation(
		desiredAnimation,
		speed,
		seek,
		true
	)
	
	return

@rpc("authority", "call_remote", "unreliable")
func sound(soundPath:String, soundPitch:float=1, soundVolume:float=1)->void:
	
	util.oneShotSFX3D(
		_corePlayer,
		soundPath,
		soundPitch,
		soundVolume
	)
	
	return
