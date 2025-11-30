extends Node

@onready var ui: Control = $UI
@onready var lobbyNameText: RichTextLabel = $UI/LobbyName
@onready var playerList: FlowContainer = $UI/PlayerList

func _ready() -> void:
	lobbyNameText.text = Networking.lobbyName
