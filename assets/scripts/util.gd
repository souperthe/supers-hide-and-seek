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
	
func sfx(soundPath:String, soundPitch:float=1, soundVolume:float=1, from:float=0)->void:
	var newSound:AudioStreamPlayer = AudioStreamPlayer.new()
	newSound.stream = load(soundPath)
	newSound.pitch_scale = soundPitch
	newSound.volume_linear = soundVolume
	self.add_child(newSound)
	newSound.play(from)
	await newSound.finished
	newSound.queue_free()
	return
	
func vector3_angleLerp(start:Vector3, goal:Vector3, weight:float) -> Vector3:
	var vec:Vector3 = Vector3(
		lerp_angle(start.x, goal.x, weight),
		lerp_angle(start.y, goal.y, weight),
		lerp_angle(start.z, goal.z, weight)
	)
	return vec
