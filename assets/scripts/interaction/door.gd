extends Interaction

var _foundDoor:Door

func enterInteraction(interactable:Object) -> void:
	
	print(interactable)
	
	
	
	_foundDoor = interactable
	_foundDoor.openEvent.rpc()
	
	
	
	return
