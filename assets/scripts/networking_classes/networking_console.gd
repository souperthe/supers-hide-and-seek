@icon("res://assets/images/icons/magick-trick.svg")
class_name ClassNetworkingConsole extends Node

func _connectLobby(code:String="")->void:
	
	if code != "":
		Networking.lobby.joinLobby(
			superEnum.lobbyType.steam,
			code
		)
		return

	
	
	Networking.lobby.joinLobby(
		superEnum.lobbyType.lan,
		Networking.defaultIp
	)
	return
	
func _createLobby(type:String = "lan")->void:
	print("help")
	if type.to_lower() == "steam":
		Networking.lobby.createLobby(
			superEnum.lobbyType.steam,
		)
		return
	Networking.lobby.createLobby(
		superEnum.lobbyType.lan,
	)
	return


func _ready() -> void:
	Console.add_command("connect_lobby", _connectLobby, ["steam lobby code"])
	Console.add_command("create_lobby", _createLobby, ["lobby type ex: steam, lan"])
	return
