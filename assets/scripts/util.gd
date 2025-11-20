@icon("res://addons/plenticons/icons/16x/objects/hammer-gray.png")
class_name ClassUtil extends Node


func sfx3D(emitter:Node3D, soundPath:String, soundPitch:float=1, soundVolume:float=1, from:float=0)->void:
	
	var newSound:AudioStreamPlayer3D = AudioStreamPlayer3D.new()
	
	newSound.stream = load(soundPath)
	newSound.pitch_scale = soundPitch
	newSound.volume_linear = soundVolume
	
	emitter.add_child(newSound)
	
	newSound.play(from)
	
	
	await newSound.finished
	
	newSound.queue_free()

	return
