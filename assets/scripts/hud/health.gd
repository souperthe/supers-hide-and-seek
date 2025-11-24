extends Control


@export var _healthPanel:PanelContainer

var _shakeAmount:float = 0
var _previousPanelPosition:Vector2

func _becomeSeeker(seeker:Seeker) -> void:
	$seekerIcon.show()
	$seekerIcon/TextureRect.texture = seeker.seekerIcon
	$healthPivot.position.x = 130.0
	return
	
func _damageTaken(previousHealth:float, currentHealth:float, damageAmount:float) -> void:
	$healthPivot/PanelContainer/Label.text = str(currentHealth)
	_shakeAmount = 10
	return


func _ready() -> void:
	$seekerIcon.hide()
	SignalManager.becameSeeker.connect(_becomeSeeker)
	SignalManager.damageTaken.connect(_damageTaken)
	
	_previousPanelPosition = _healthPanel.position
	return
	
	
func _process(delta: float) -> void:
	
	_shakeAmount = lerpf(_shakeAmount, 0, 3 * delta)
	
	var shakeAddition:Vector2 = Vector2(
		randf_range(-_shakeAmount, _shakeAmount),
		randf_range(_shakeAmount, -_shakeAmount)
	)
	
	_healthPanel.position = _previousPanelPosition + shakeAddition
	return
	
	
