extends Control

func _becomeSeeker(seeker:Seeker) -> void:
	$Control.show()
	$Control/TextureRect.texture = seeker.seekerIcon
	$PanelContainer.position.x = 95.231
	return


func _ready() -> void:
	SignalManager.becameSeeker.connect(_becomeSeeker)
	return
