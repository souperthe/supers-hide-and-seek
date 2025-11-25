extends CanvasLayer

@export var _corePlayer:Player


func _timerEnd() -> void:
	util.oneShotSFX(
		"res://assets/sound/sfx/hl1/fvox/bell.wav"
	)
	return

func _ready() -> void:
	_corePlayer.abilityTimer.timeout.connect(_timerEnd)
	return
