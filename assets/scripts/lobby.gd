extends Node

@onready var ui: Control = $UI
@onready var lobbyNameText: RichTextLabel = $UI/LobbyName
@onready var playerList: FlowContainer = $UI/PlayerList
@onready var littleguys: Node2D = $littleguys
@export var littleguyScene: PackedScene

func _ready() -> void:
	lobbyNameText.text = Networking.lobbyName

#func _on_peer_joined(pid : int) -> void:
	#pass
#func _on_peer_left(pid):
	#pass

func _on_start_pressed() -> void:
	Networking.hostEvents.startGame.rpc()

func _on_back_pressed() -> void:
	Networking.lobby.clientDisconnect()
