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
	
	var hiders: Dictionary = Networking.players.duplicate()
	
	for seekerpid in desiredData.seekers:
		var plr : Player = util.getPlayer(seekerpid)
		plr.loadSeeker(Networking.players[seekerpid].desired_seeker)
		hiders.erase(seekerpid)
	
	for hiderpid in hiders:
		var plr : Player = util.getPlayer(hiderpid)
		plr.loadHider(Networking.players[hiderpid].desired_hider)
		
		
	SignalManager.roundStart.emit()
	
	
	return
