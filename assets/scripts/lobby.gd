extends Node

@onready var ui: Control = $UI
@onready var lobbyNameText: RichTextLabel = $UI/LobbyName
@onready var playerList: FlowContainer = $UI/PlayerList

func _ready() -> void:
	lobbyNameText.text = Networking.lobbyName

func _on_start_pressed() -> void:
	Networking.hostEvents.startGame.rpc()

func _on_back_pressed() -> void:
	Networking.lobby.clientDisconnect()
