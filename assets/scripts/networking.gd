@icon("res://assets/images/icons/server-rack.svg")
class_name ClassNetworking extends Node

var lobbyName:String = ""

var currentPeer:MultiplayerPeer
var players : Dictionary = {}
var networkRNG : RandomNumberGenerator = RandomNumberGenerator.new() ## ONLY TO BE USED IN RPC EVENTS

var maxPlayers: int = 20
var localPlayer:Player

var localData := {
	username = "steamuser99",
	steamid = 0,
	desired_seeker = "fredbear",
	desired_hider = "ball_man"
}


@export var lobby:ClassLobby
@export var hostEvents:ClassHostEvents
@export var console:ClassNetworkingConsole

@export var playersHolder:Node3D


const port:int = 8080
const defaultIp:String = "127.0.0.1"

func _init() -> void:
	print("Networking init")
	
	var steamName:String = Steam.getPersonaName()
	networkRNG.seed = 123 # TODO temporary
	
	lobbyName = "SHAS_" + steamName + "'s lobby"
	
	localData.set("username", steamName)
	localData.set("steamid", Steam.getSteamID())
	
	return


func _process(_delta: float) -> void:
	Steam.runNetworkingCallbacks()
	return
