@icon("res://assets/images/icons/magick-trick.svg")
class_name ClassNetworkingConsole extends Node

func _connectLobby()->void:
	Networking.lobby.joinLobby(
		superEnum.lobbyType.lan,
		Networking.defaultIp
	)
	return
	
func _createLobby()->void:
	print("help")
	Networking.lobby.createLobby(
		superEnum.lobbyType.lan,
	)
	return


func _ready() -> void:
	Console.add_command("connect_lobby", _connectLobby)
	Console.add_command("create_lobby", _createLobby)
	return
