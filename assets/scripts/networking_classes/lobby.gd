@icon("res://assets/images/icons/mesh-network.svg")
class_name ClassLobby extends Node

@export var _connectables:ClassLobbyConnectables
@export var _playerScene:PackedScene

var currentLobbyId:int = 0
var _attemptingJoin:bool = false

func _ready() -> void:
	multiplayer.peer_connected.connect(_connectables.peerJoined)
	multiplayer.peer_disconnected.connect(_connectables.peerLeft)
	multiplayer.connected_to_server.connect(_connectables.lobbyConnected)
	
	Steam.lobby_created.connect(_connectables.lobbyCreated)
	Steam.lobby_joined.connect(_connectables.lobbyJoined)
	return
	
@rpc("authority", "call_local", "reliable")
func removeData(pid:int) -> void:
	if multiplayer.get_remote_sender_id() != 1:
		return
		
	Networking.players.erase(pid)
	Networking.hostEvents.hiders.erase(pid)
	Networking.hostEvents.seekers.erase(pid)
	SignalManager.updatePeerList.emit()
	return

@rpc("any_peer","call_remote","reliable")
func sendData(data:Dictionary, pid:int)->void:
	
	if !(Networking.players.has(pid)):
		
		data["pid"] = pid
		Networking.players[pid] = data
		
		SignalManager.peerJoined.emit(pid)
		SignalManager.updatePeerList.emit()
		
		#var newPlayer:Player = _playerScene.instantiate()
		#
		#newPlayer.set_multiplayer_authority(pid)
		#newPlayer.authID = pid
		#newPlayer.steamID = data["steamid"]
		#newPlayer.playerName = data["username"]
		#newPlayer.name = str(pid)
		#
		#
		#if pid != multiplayer.get_unique_id():
			#newPlayer.position = Vector3.UP*1248
		
		#Networking.playersHolder.add_child(newPlayer)
		
		#if pid == 1:
			#newPlayer.loadSeeker(data["desired_seeker"])
		#else:
			#newPlayer.loadHider("ball_man")
		#newPlayer.loadHider("ball_man")
		
	if !multiplayer.is_server():
		return
		
	for player in Networking.players:
		sendData.rpc(
			Networking.players[player],
			player
			)
	return

func clientDisconnect():
	currentLobbyId = 0
	Networking.players.clear()
	Networking.currentPeer = null
	multiplayer.multiplayer_peer = null
	global.masterScene.switch_scene("res://assets/scenes/sub/mainmenu.tscn")
	util.clearChildren(Networking.playersHolder)

func createLobby(lobbyType:superEnum.lobbyType, visibility:Steam.LobbyType = Steam.LobbyType.LOBBY_TYPE_INVISIBLE) -> void:
	
	if _attemptingJoin:
		return
	
	_attemptingJoin = true
	
	Steam.allowP2PPacketRelay(true)
	Steam.initRelayNetworkAccess()
	
	match(lobbyType):
		superEnum.lobbyType.steam: # STEAM
			#Networking.peer = SteamMultiplayerPeer.new()
			#N#Networking.peer.create_lobby(visibility,Networking.max_players)
			#Steam.setLobbyJoinable(Networking.lobby_id,true)
			#multiplayer.multiplayer_peer = Networking.peer
			if Networking.lobby.currentLobbyId != 0:
				return
			
			Steam.createLobby(visibility, Networking.maxPlayers)
			
		superEnum.lobbyType.lan: #LOCAL
			
			var newPeer:ENetMultiplayerPeer = ENetMultiplayerPeer.new()
			Networking.currentPeer = newPeer
			
			var error:Error = newPeer.create_server(Networking.port,Networking.maxPlayers)
			
			if error:
				Networking.currentPeer = null
				return
				
			multiplayer.multiplayer_peer = newPeer
			Networking.lobby.sendData(
				Networking.localData,
				multiplayer.get_unique_id()
				)
			SignalManager.hostSucess.emit()
			_attemptingJoin = false
	
	
	
	
	return

func joinLobby(lobbyType:superEnum.lobbyType, ip:String) -> void:
	
	if _attemptingJoin:
		return
	
	_attemptingJoin = true
	
	Steam.allowP2PPacketRelay(true)
	Steam.initRelayNetworkAccess()
	
	match(lobbyType):
		superEnum.lobbyType.steam:
			var lobbyId:int = int(ip)
			
			if currentLobbyId != 0:
				return
				
			Steam.joinLobby(lobbyId)
			return
		superEnum.lobbyType.lan:
			var newPeer:ENetMultiplayerPeer = ENetMultiplayerPeer.new()
			
			Networking.currentPeer = newPeer
			var error : Error = newPeer.create_client(ip,Networking.port)
			
			if error:
				Networking.currentPeer = null
				return
				
			multiplayer.multiplayer_peer = newPeer
			_attemptingJoin = false
			return
	
	return
