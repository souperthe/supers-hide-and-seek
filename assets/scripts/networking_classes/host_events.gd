@icon("res://assets/images/icons/public-speaker.svg")
class_name ClassHostEvents extends Node

@export var seekTimer:Timer
@export var hideTimer:Timer
var hiders: Array[int] = []
var seekers: Array[int] = []
var isOver:bool = false

var currentData:Dictionary = {}
var gameData:Dictionary = {
	map = "srs3_school",
	seekers = [1],
	seek_time = 600, # time for seekers to seek
	hide_time = 20, # time for hiders to hide
	use_lms = false
}

func _ready() -> void:
	Networking.networkRNG.randomize() # temp
	
	seekTimer.timeout.connect(endGame.rpc)
	hideTimer.timeout.connect(_on_counting_finished)
	SignalManager.peerDied.connect(_on_peer_died)
	SignalManager.peerLeft.connect(_on_peer_left)

func _on_counting_finished() -> void:
	seekTimer.start()
	util.oneShotSFX(
		"res://assets/sound/sfx/ambient/alarms/city_siren_loop2.wav"
	)
	for seekerid: int in seekers:
		var seeker: Player = util.getPlayer(seekerid)
		seeker.seeking = true
		seeker.freeze = false
		if seeker.is_multiplayer_authority():
			seeker.playerHud.seeking.active = false
			seeker.playerHud.seeking.hide()

func _on_peer_died(pid: int) -> void:
	hiders.erase(pid)
	if multiplayer.is_server():
		if hiders.size() <= 0: endGame.rpc(superEnum.endGameReason.seekersWin)

func _on_peer_left(pid: int) -> void:
	seekers.erase(pid)
	hiders.erase(pid)
	if multiplayer.is_server():
		if seekers.size() <= 0: endGame.rpc(superEnum.endGameReason.seekersLeft)

@rpc("any_peer","call_remote","reliable")
func get_rng_seed() -> int:
	return Networking.networkRNG.seed

@rpc("authority","call_local","reliable")
func endGame(reason: superEnum.endGameReason=superEnum.endGameReason.hidersWin):
	
	if !multiplayer.get_remote_sender_id() == 1:
		return
	
	if isOver: 
		return
	print(reason)
	isOver = true
	
	hideTimer.stop()
	seekTimer.stop()
	hiders.clear()
	seekers.clear()
	print("ending game...")
	util.oneShotSFX(
		"res://assets/sound/sfx/buttons/button24.wav"
	)
	for seekerid: int in seekers:
		util.getPlayer(seekerid).seeking = false
	
	var wintext: String = ""
	match reason:
		superEnum.endGameReason.seekersLeft:
			wintext = "THE SEEKERS HAVE LEFT!"
		superEnum.endGameReason.seekersWin:
			wintext = "THE SEEKERS HAVE WON!"
		superEnum.endGameReason.hidersWin:
			wintext = "THE HIDERS HAVE WON!"
		_:
			wintext = "...uh?"
	Networking.ui.show()
	Networking.ui.reasonLabel.text = wintext
	
	await get_tree().create_timer(5).timeout
	
	Steam.setLobbyJoinable(Networking.lobby.currentLobbyId,true)
	util.clearChildren(Networking.playersHolder)
	Networking.ui.hide()
	global.masterScene.switch_scene("res://assets/scenes/sub/lobby.tscn")
	

@rpc("authority", "call_local", "reliable")
func startGame(desiredData:Dictionary=gameData) -> void:
	
	if !multiplayer.get_remote_sender_id() == 1:
		return
	
	isOver = false
	hiders.clear()
	print("starting game...")
	print(desiredData)
	
	Steam.setLobbyJoinable(Networking.lobby.currentLobbyId,false)
	if not multiplayer.is_server():
		Networking.networkRNG.seed = await RpcAwait.send_rpc(1,get_rng_seed)
	print(Networking.networkRNG.seed)
	
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
			seekers.append(pid)
			newPlayer.loadSeeker(pdata.desired_seeker)
			newPlayer.playerHud.seeking.active = true
			newPlayer.freeze = true
			newPlayer.playerHud.seeking.show()
		else:
			hiders.append(pid)
			newPlayer.loadHider(pdata.desired_hider)
	
	
	SignalManager.roundStart.emit()
	hideTimer.start()
	
	util.oneShotSFX(
		"res://assets/sound/sfx/ambient/alarms/warningbell1.wav"
	)
	return
