@icon("res://assets/images/icons/public-speaker.svg")
class_name ClassHostEvents extends Node

@export var seekTimer:Timer
@export var hideTimer:Timer
var hiders: Array[int] = []
var seekers: Array[int] = []

var currentData:Dictionary = {}
var gameData:Dictionary = {
	map = "srs3_school",
	seekers = [1],
	seek_time = 600, # time for seekers to seek
	hide_time = 10, # time for hiders to hide
	use_lms = false
}

func _ready() -> void:
	seekTimer.timeout.connect(endGame.rpc)

@rpc("authority","call_local","reliable")
func endGame(reason: superEnum.endGameReason=superEnum.endGameReason.hidersWin):
	
	if !multiplayer.get_remote_sender_id() == 1:
		return
	
	hiders.clear()
	print("ending game...")
	util.oneShotSFX(
		"res://assets/sound/sfx/buttons/button24.wav"
	)
	
	for seekerid in seekers:
		util.getPlayer(seekerid).seeking = false
	await get_tree().create_timer(3).timeout
	
	Steam.setLobbyJoinable(Networking.lobby.currentLobbyId,true)
	util.clearChildren(Networking.playersHolder)
	global.masterScene.switch_scene("res://assets/scenes/sub/lobby.tscn")
	

@rpc("authority", "call_local", "reliable")
func startGame(desiredData:Dictionary=gameData) -> void:
	
	if !multiplayer.get_remote_sender_id() == 1:
		return
	
	hiders.clear()
	print("starting game...")
	print(desiredData)
	
	Steam.setLobbyJoinable(Networking.lobby.currentLobbyId,false)
	Networking.networkRNG.seed = 67420 * 143 # TODO temporary
	
	hideTimer.wait_time = desiredData.hide_time
	seekTimer.wait_time = desiredData.seek_time
	
	currentData = desiredData
	
	global.masterScene.switch_scene("res://assets/scenes/sub/game.tscn")
	
	var desiredMap: SelectableMap = load("res://assets/resources/maps/%s.tres" % desiredData.map)
	var mapScene: Node3D = desiredMap.mapScene.instantiate()
	global.masterScene.currentScene.map.add_child(mapScene)
	
	for pid: int in Networking.players:
		var pdata: Dictionary = Networking.players[pid]
		var newPlayer: Player = Networking.lobby._playerScene.instantiate()
		newPlayer.set_multiplayer_authority(pid)
		newPlayer.authID = pid
		newPlayer.steamID = pdata["steamid"]
		newPlayer.playerName = pdata["username"]
		newPlayer.name = str(pid)
		
		if pid != multiplayer.get_unique_id():
			newPlayer.position = Vector3.UP*1248
		
		Networking.playersHolder.add_child(newPlayer)
		
		if desiredData.seekers.has(pid):
			newPlayer.loadSeeker(pdata.desired_seeker)
			newPlayer.seeking = true
			seekers.append(pid)
		else:
			newPlayer.loadHider(pdata.desired_hider)
			hiders.append(pid)
	
	
	SignalManager.roundStart.emit()
	hideTimer.start()
	seekTimer.start()
	
	util.oneShotSFX(
		"res://assets/sound/sfx/ambient/alarms/warningbell1.wav"
	)
	return
