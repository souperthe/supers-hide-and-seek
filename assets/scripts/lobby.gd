extends Node

@onready var ui: Control = $UI
@onready var lobbyNameText: RichTextLabel = $UI/LobbyName
@onready var playerList: FlowContainer = $UI/PlayerList

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	lobbyNameText.text = Networking.lobbyName
	SignalManager.peerJoined.connect(_on_peer_joined)
	for pid in Networking.players:
		_on_peer_joined(pid)
	#if multiplayer.get_unique_id() == 1:
		#_on_peer_joined(1)

func _on_peer_joined(pid : int) -> void:
	var voice:  VoiceEmitter = VoiceEmitter.new()
	var audiovoice : AudioStreamPlayer = AudioStreamPlayer.new()
	voice.set_multiplayer_authority(pid)
	voice.name = str(pid)
	voice.targetEmitter = audiovoice
	voice._mutedSprite = $UI/MutedMic
	audiovoice.name = "Voice"
	audiovoice.bus = &"Voice"
	voice.add_child(audiovoice)
	add_child(voice)
	
func _on_peer_left(pid):
	pass

func _on_start_pressed() -> void:
	Networking.hostEvents.startGame.rpc()

func _on_back_pressed() -> void:
	Networking.lobby.clientDisconnect()
