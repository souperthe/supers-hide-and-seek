extends Interaction

var _foundDoor:Door

func enterInteraction(interactable:Object) -> void:
	
	
	
	_foundDoor = interactable
	_foundDoor.openEvent.rpc()
	
	
	
	return
