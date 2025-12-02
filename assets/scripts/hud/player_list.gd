extends FlowContainer

func add_player(pid: int):
	var pdata: Dictionary = Networking.players[pid]
	var player_button: Button = Button.new()

	player_button.text = pdata.username
	player_button.name = str(pid)
	player_button.icon = util.getPlayerAvatar(pdata.steamid,32)
	Steam.setInGameVoiceSpeaking(pdata.steamid, true)
	add_child(player_button)

func load_players():
	util.clearChildren(self)
	for ingame_player in Networking.players:
		add_player(ingame_player)
	

func left(pid: int):
	get_node(str(pid)).queue_free()

func _ready() -> void :
	#SignalManager.peerJoined.connect(add_player)
	#SignalManager.peerLeft.connect(left)
	SignalManager.updatePeerList.connect(load_players)
	load_players()
