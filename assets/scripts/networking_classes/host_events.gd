@icon("res://assets/images/icons/public-speaker.svg")
class_name ClassHostEvents extends Node


var gameData:Dictionary = {
	map = "srs3_school",
	seekers = [1],
	seek_time = 600, # time for seekers to seek
	hide_time = 10, # time for hiders to hide
	use_lms = false
}

@rpc("authority", "call_local", "unreliable")
func startGame(desiredData:Dictionary=gameData) -> void:
	
	if !multiplayer.get_remote_sender_id() == 1:
		return
		
	print("starting game...")
	print(desiredData)

		
		
	
	return
