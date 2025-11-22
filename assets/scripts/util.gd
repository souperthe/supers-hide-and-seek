@icon("res://assets/images/icons/spanner.svg")
class_name ClassUtil extends Node

const _characters:String= 'abcdefghijklmnopqrstuvwxyz12371293192ASJDBJASAEJKFWEJK'


func setCollisions(parentNode:Node3D, disabled:bool=false)->void:
	
	for node in getDescendants(parentNode):
		
		if node is CollisionShape3D:
			node.disabled = disabled
	
	
	return
	
func getDescendants(in_node:Node,arr:=[]) -> Array: 
	arr.push_back(in_node)    
	for child in in_node.get_children(): 
		arr = getDescendants(child,arr)   
	return arr

func clearChildren(node:Node) -> void:
	for child in node.get_children():
		child.queue_free()
	return
	

func generate_word(length:int) -> String:
	var word: String = ""
	var n_char = len(_characters)
	for i in range(length):
		word += _characters[randi()% n_char]
	return word

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
