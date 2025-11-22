extends Control

@export var textEdit:LineEdit
@export var chatLabel:Label
@export var _panel:PanelContainer

func _getMessage(sender:int, message:String) -> void:
	
	var senderData:Dictionary = Networking.players[sender]
	var senderName:String = senderData.get("username")
	
	if sender == 1:
		senderName += " (HOST)"
	
	
	var additionText:String = "\n" + senderName + ": " + message
	
	chatLabel.text = chatLabel.text + additionText
	
	util.sfx("res://assets/sound/sfx/tools/ifm/ifm_snap.wav")
	
	return
	
	
	
func _textSubmitted(newText:String) -> void:
	Networking.localPlayer.events.sendMessage.rpc(newText)
	textEdit.text = ""
	textEdit.release_focus()
	_panel.hide()
	textEdit.hide()
	return
	
func _ready() -> void:
	SignalManager.chatMessage.connect(_getMessage)
	textEdit.text_submitted.connect(_textSubmitted)
	
	chatLabel.text = ""
	_panel.hide()
	textEdit.hide()
	return
	
func _process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("player_chat"):
		var current_focus_owner:Control = get_viewport().gui_get_focus_owner()
		if current_focus_owner != textEdit:
			_panel.show()
			textEdit.show()
			textEdit.grab_focus()
	return
