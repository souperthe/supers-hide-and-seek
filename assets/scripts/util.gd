@icon("res://assets/images/icons/spanner.svg")
class_name ClassUtil extends Node

const _characters:String= 'abcdefghijklmnopqrstuvwxyz12371293192ASJDBJASAEJKFWEJK'

func getPlayerAvatar(pid: int, size: int) -> ImageTexture:
	var sizedata: int
	match size:
		32:
			sizedata = Steam.getSmallFriendAvatar(pid)
		64:
			sizedata = Steam.getMediumFriendAvatar(pid)
		128:
			sizedata = Steam.getLargeFriendAvatar(pid)
		_:
			push_warning("invalid profile size. setting to 32.")
			return getPlayerAvatar(pid,32)
	
	var image_data: Dictionary = Steam.getImageRGBA(sizedata)
	var image_buffer: PackedByteArray = image_data["buffer"]
	var player_avatar: Image = Image.create_from_data(size,size,false,Image.FORMAT_RGBA8,image_buffer)
	if player_avatar.get_size().x > size or player_avatar.get_size().y > size:
		player_avatar.resize(size,size)
	
	var avatar_texture: ImageTexture = ImageTexture.create_from_image(player_avatar)
	return avatar_texture
	
	
func getPlayersOnTeam(desiredTeam:superEnum.teams) -> Array[Player]:
	
	var foundPlayers:Array[Player]
	var allPlayers:Array[Node] = Networking.playersHolder.get_children()
	
	
	for player in allPlayers:
		if player is Player:
			
			if player.currentTeam != desiredTeam:
				continue
				
			foundPlayers.append(player)
			
			
			continue
		else:
			continue
		continue
	
	
	return foundPlayers

func getPlayer(pid:int) -> Player:
	
	var allPlayers:Array = Networking.playersHolder.get_children()
	
	for player in allPlayers:
		
		if (player is Player):
			
			if player.authID == pid:
				
				return player
				
		continue
	
	
	return null

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
	

func lingerNode(node : Node, time: float):
	await get_tree().create_timer(time).timeout
	node.queue_free()

func generate_word(length:int) -> String:
	var word: String = ""
	var n_char = len(_characters)
	for i in range(length):
		word += _characters[randi()% n_char]
	return word

func oneShotSFX3D(emitter:Node3D, soundPath:String, soundPitch:float=1, soundVolume:float=1, from:float=0)->void:
	var newSound:AudioStreamPlayer3D = AudioStreamPlayer3D.new()
	newSound.stream = load(soundPath)
	newSound.pitch_scale = soundPitch
	newSound.volume_linear = soundVolume
	newSound.attenuation_filter_db = 0.0
	emitter.add_child(newSound)
	newSound.play(from)
	await newSound.finished
	newSound.queue_free()
	return
	
func oneShotSFX(soundPath:String, soundPitch:float=1, soundVolume:float=1, from:float=0)->void:
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
	
	
func setShadows(rootNode:Node3D, shadowMode:GeometryInstance3D.ShadowCastingSetting) -> void:
	
	for node in getDescendants(rootNode):
		
		if node is GeometryInstance3D:
			node.cast_shadow = shadowMode
			
			if shadowMode == GeometryInstance3D.ShadowCastingSetting.SHADOW_CASTING_SETTING_SHADOWS_ONLY:
				node.set_layer_mask_value(1, false)
				node.set_layer_mask_value(2, true)
		
		
		continue
	
	return
	



var _seekerPath:String = "res://assets/resources/seekers/"
var _hiderPath:String = "res://assets/resources/hiders/"

func dictionaryRandom(dictionary: Dictionary) -> Variant:
	var random_key : Variant = dictionary.keys().pick_random()
	
	return dictionary[random_key]

func getHider(hiderName:String) -> Hider:
	var trueName:String = hiderName.to_lower()
	var hiderPath:String = _hiderPath + trueName + ".tres"
	
	if !FileAccess.file_exists(hiderPath):
		return null
		
	var foundHider:Hider = load(hiderPath) as Hider
	
	return foundHider

func getSeeker(seekerName:String) -> Seeker:
	var trueName:String = seekerName.to_lower()
	var seekerPath:String = _seekerPath + trueName + ".tres"
	
	if !FileAccess.file_exists(seekerPath):
		return null
		
	var foundSeeker:Seeker = load(seekerPath) as Seeker

	return foundSeeker
