@icon("res://assets/images/icons/plug.svg")
class_name ClassLobbyConnectables extends Node


func peerJoined(pid:int) -> void:
	print(pid)
	#print(Networking.players)
	#if multiplayer.is_server():
		#Networking.hostEvents.sync_rng.rpc_id(Networking.networkRNG.seed)
		#if Networking.players.size() > Networking.max_players:
			#print("kick?")
			#Networking.connection.kickPlayer(pid)
	return
	
func peerLeft(pid:int) -> void:
	SignalManager.peerLeft.emit(pid)
	
	var plr: Player = util.getPlayer(pid)
	if plr:
		plr.queue_free()
	
	if multiplayer.is_server():
		print("%s has left" % pid)
		Networking.lobby.removeData.rpc(pid)
	
	if pid == 1:
		Networking.lobby.clientDisconnect()
		print("HOST DISCONNECT")
	
	return
	
func lobbyCreated(result:superEnum.steamResult, newLobbyId:int)->void:
	var resultMessage:String = superEnum.steamResult.find_key(result)
	
	if result != superEnum.steamResult.RESULT_OK:
		OS.alert(resultMessage, "ERROR!")
		return
		
	var newPeer:SteamMultiplayerPeer = SteamMultiplayerPeer.new()
	
	newPeer.debug_level = SteamMultiplayerPeer.DebugLevel.DEBUG_LEVEL_PEER
	newPeer.host_with_lobby(newLobbyId)
		
	Networking.currentPeer = newPeer
	multiplayer.multiplayer_peer = newPeer
	
	Networking.lobby.currentLobbyId = newLobbyId
	
	print("created a lobby: %s" % newLobbyId)
	print(resultMessage)
	
	var hostId:int = Networking.localData.get("steamid")
	
	Steam.setLobbyJoinable(newLobbyId, true)
	Steam.setLobbyData(newLobbyId, "name", Networking.lobbyName)
	Steam.setLobbyData(newLobbyId, "captain", str(hostId))
	
	Networking.lobby.sendData(
		Networking.localData,
		multiplayer.get_unique_id()
		)
		
	SignalManager.hostSucess.emit()
	
	return

func lobbyConnected()->void:
	print("connected to server")
	
	#Networking.connection.sendPlayerData.rpc_id(1,global.player_data,multiplayer.get_unique_id())
	
	Networking.lobby.sendData.rpc_id(
		1,
		Networking.localData,
		multiplayer.get_unique_id()
	)
	
	SignalManager.lobbySucess.emit()
	return
	
	
func lobbyFailed():
	SignalManager.lobbyFailed.emit()
	return
	
func lobbyJoined(this_lobby_id: int, _permissions: int, _locked: bool, _response: superEnum.ChatRoomEnterResponse) -> void:
	# If joining was successful
	if Steam.getLobbyOwner(this_lobby_id) == Networking.localData["steamid"]:
		print("dont join your own lobby")
		return
		
	print("joining lobby..")

	var peer:SteamMultiplayerPeer = SteamMultiplayerPeer.new()
	Networking.lobby.currentLobbyId = this_lobby_id
	peer.debug_level = SteamMultiplayerPeer.DEBUG_LEVEL_PEER
	peer.connect_to_lobby(this_lobby_id)
		
	multiplayer.multiplayer_peer = peer
	Networking.currentPeer = peer
	return
