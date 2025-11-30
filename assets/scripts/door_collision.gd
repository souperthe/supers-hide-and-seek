class_name DoorCollision extends StaticBody3D



var destroyed:bool = false

signal broken(who:Player)



@rpc("any_peer", "call_local", "reliable")
func breakEvent():
	if destroyed:
		return
	var sender:int = multiplayer.get_remote_sender_id()
	var senderPlayer:Player = util.getPlayer(sender)
	broken.emit(senderPlayer)
	destroyed = true
	return
