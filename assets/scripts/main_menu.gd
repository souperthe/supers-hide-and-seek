extends Node

var _seekerPath:String = "res://assets/resources/seekers/"

@export var _seekersHolder:FlowContainer
@export var _currentSeeker:Button


func _enterGame() -> void:
	$Control.hide()
	return

func _ready() -> void:
	_loadSeekers()
	SignalManager.lobbySucess.connect(_enterGame)
	SignalManager.hostSucess.connect(_enterGame)
	return
	
	
func _loadSeekers() -> void:
	util.clearChildren(_seekersHolder)
	
	var dirAccess:DirAccess = DirAccess.open(_seekerPath)
	var allFiles:PackedStringArray = dirAccess.get_files()
	
	for file in allFiles:
		var seekerName:String = file.get_basename()
		var loadedSeeker:Seeker = util.getSeeker(seekerName)
		var newButton:Button = Button.new()
		
		newButton.icon = loadedSeeker.seekerIcon
		newButton.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
		newButton.vertical_icon_alignment = VERTICAL_ALIGNMENT_TOP
		newButton.expand_icon = true
		
		newButton.size_flags_vertical = Control.SIZE_EXPAND_FILL
		newButton.size_flags_vertical = Control.SIZE_EXPAND_FILL
		newButton.text = loadedSeeker.seekerName
		
		_seekersHolder.add_child(newButton)
		
		
		var pressed:Callable = func():
			Networking.localData.set(
				"desired_seeker", seekerName
			)
			newButton.release_focus()
			_currentSeeker.icon = loadedSeeker.seekerIcon
			return
		
		
		newButton.pressed.connect(pressed)
		
		continue
	
	
	return
