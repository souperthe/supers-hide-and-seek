@icon("res://assets/images/icons/public-speaker.svg")
class_name ClassHostEvents extends Node

@export var seekTimer:Timer
@export var hideTimer:Timer

var gameData:Dictionary = {
	map = "srs3_school",
	seekers = [1],
	seek_time = 600, # time for seekers to seek
	hide_time = 10, # time for hiders to hide
	use_lms = false
}

@rpc("authority", "call_local", "reliable")
func startGame(desiredData:Dictionary=gameData) -> void:
	
	if !multiplayer.get_remote_sender_id() == 1:
		return
		
	print("starting game...")
	print(desiredData)
	
	Networking.networkRNG.seed = 67420 * 143 # TODO temporary
	
	hideTimer.wait_time = desiredData.hide_time
	seekTimer.wait_time = desiredData.seek_time
	
	gameData = desiredData
	
	
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
		else:
			newPlayer.loadHider(pdata.desired_hider)
	
	
	SignalManager.roundStart.emit()
	hideTimer.start()
	seekTimer.start()
	
	
	return
