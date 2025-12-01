@icon("res://assets/images/icons/imp-laugh.svg")
class_name ChaseManager extends Node

@export var _corePlayer: Player

@onready var radiuses: Dictionary[String,Array] = {
	"L3" : [0,30,$L3],
	"L2" : [30,45,$L2],
	"L1" : [45,60,$L1]
}
var inchase: bool = false
var killer: Player = null

func chaseSetup():
	var seekers:Array = Networking.hostEvents.currentData.get("seekers")
	for seeker in seekers:
		#var pdata: Dictionary = Networking.players[seeker]
		killer = util.getPlayer(seeker)
	

func radiusCheck():
	if killer == null: return
	
	if killer == _corePlayer:
		pass
	else:
		var dist: float = (_corePlayer.global_position - killer.global_position).length()
		for layer: String in radiuses:
			var ldata: Array = radiuses[layer]
			var radius: float = ldata.get(0)
			var upcoming: float = ldata.get(1)
			var sound: AudioStreamPlayer = ldata.get(2)
			if inchase:
				pass
			else:
				if dist <= upcoming and dist > radius:
					sound.volume_db = linear_to_db(1)
				else:
					sound.volume_db = linear_to_db(0)
