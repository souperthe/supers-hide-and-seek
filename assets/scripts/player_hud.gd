extends CanvasLayer

@export var _corePlayer:Player
@onready var health: Control = $Health
@onready var timer: Control = $Timer
@onready var chat: Control = $Chat

func _timerEnd() -> void:
	util.oneShotSFX(
		"res://assets/sound/sfx/hl1/fvox/bell.wav"
	)
	return

func _ready() -> void:
	_corePlayer.abilityCooldown.timeout.connect(_timerEnd)
	return
