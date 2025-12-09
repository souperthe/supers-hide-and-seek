@icon("res://assets/images/icons/imp-laugh.svg")
class_name ChaseManager extends Node

@export var _corePlayer: Player

@onready var radiuses: Dictionary[String,Array] = {
	"L3" : [0,15,$L3],
	"L2" : [15,45,$L2],
	"L1" : [45,60,$L1]
}
var inchase: bool = false
var alreadyPlayingChase: bool = false
var killer: Player = null
var playthemes: bool = false

func calcSound(distance: float) -> float:
	
	var K:float = 4.96
	var C:float = -10.26
	
	return (K / (distance - C)) * 4

func chaseSetup() -> void:
	var seekers:Array = Networking.hostEvents.seekers
	for seeker in seekers:
		#var pdata: Dictionary = Networking.players[seeker]
		killer = util.getPlayer(seeker)

func radiusCheck() -> void:
	if not playthemes: return
	if killer == null: return
	if not killer.seeking: return
	
	if killer == _corePlayer:
		pass
		for hiderid: int in Networking.hostEvents.hiders:
			var hider: Player = util.getPlayer(hiderid)
			var dist = (_corePlayer.global_position - hider.global_position).length()
			inchase = dist <= 15 or (inchase and dist <= 60)
			
			if inchase:
				if not alreadyPlayingChase:
					alreadyPlayingChase = true
					radiuses.get("L3").get(2).play()
				radiuses.get("L3").get(2).volume_db = linear_to_db(calcSound(dist))
			else:
				alreadyPlayingChase = false
				radiuses.get("L3").get(2).volume_db = linear_to_db(0)
	else:
		var dist: float = (_corePlayer.global_position - killer.global_position).length()
		for layer: String in radiuses:
			var ldata: Array = radiuses[layer]
			var radius: float = ldata.get(0)
			var upcoming: float = ldata.get(1)
			var sound: AudioStreamPlayer = ldata.get(2)
			if inchase:
				if dist < 60:
					if layer == "L3":
						sound.volume_db = linear_to_db(calcSound(dist))
					else:
						sound.volume_db = linear_to_db(0)
				else:
					alreadyPlayingChase = false
					inchase = false
					sound.volume_db = linear_to_db(0)
			else:
				if dist <= upcoming and dist > radius:
					if layer == "L3":
						inchase = true
						if not alreadyPlayingChase:
							alreadyPlayingChase = true
							sound.play()
					sound.volume_db = linear_to_db(calcSound(dist))
				else:
					sound.volume_db = linear_to_db(0)
