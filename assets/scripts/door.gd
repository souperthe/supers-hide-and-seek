@icon("res://addons/plenticons/icons/16x/objects/door-red.png")
class_name Door extends Area3D



signal interacted(who:Player)


@rpc("any_peer", "call_local", "reliable")
func openEvent() -> void:
	var sender:int = multiplayer.get_remote_sender_id()
	var senderPlayer:Player = util.getPlayer(sender)
	
	print(senderPlayer)
	interacted.emit(senderPlayer)
	
	
	return
