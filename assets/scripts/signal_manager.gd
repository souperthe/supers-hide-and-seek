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
signal roundStart


signal peerDied(pid:int)


signal chatMessage(sender:int, message:String)
signal becameSeeker(seeker:Seeker)
signal damageTaken(previousHealth:float, currentHealth:float, damageAmount:float)

signal baldi_requestTP(pos:Vector3)
signal baldi_doorOpen(pos:Vector3)
