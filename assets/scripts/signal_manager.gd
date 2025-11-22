@icon("res://assets/images/icons/aerial-signal.svg")
class_name ClassSignalManager extends Node

@warning_ignore_start("unused_signal")
@warning_ignore("unused_signal")

signal peerJoined(pid:int)
signal peerLeft(pid:int)

signal updatePeerList()

signal lobbyFailed
signal lobbySucess

signal hostSucess
