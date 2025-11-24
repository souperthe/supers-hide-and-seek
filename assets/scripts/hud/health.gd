extends Control


@export var _healthPanel:PanelContainer
@export var _amountExample:Label

var _shakeAmount:float = 0
var _previousPanelPosition:Vector2

func _becomeSeeker(seeker:Seeker) -> void:
	$seekerIcon.show()
	$seekerIcon/TextureRect.texture = seeker.seekerIcon
	$healthPivot.position.x = 130.0
	return
	
func _damageTaken(previousHealth:float, currentHealth:float, damageAmount:float) -> void:
	_showAmount(damageAmount)
	$healthPivot/PanelContainer/Label.text = str(currentHealth)
	_shakeAmount = 10
	return
	
	
func _showAmount(damageAmount:float) -> void:
	
	var newLabel:Label = _amountExample.duplicate()
	
	print(newLabel)
	
	newLabel.show()
	
	newLabel.text = str(damageAmount)
	
	$healthPivot.add_child(newLabel)
	
	newLabel.position.y = -11.538
	
	var newTween:Tween = get_tree().create_tween()
	
	newTween.set_trans(Tween.TRANS_SINE)
	
	newTween.tween_property(
		newLabel,
		"position:y",
		-79.231,
		0.5
		)
		
	newTween.tween_property(
		newLabel,
		"modulate:a8",
		0,
		0.5
	)
	
	
	await newTween.finished
	
	newLabel.queue_free()
	
	
	return


func _ready() -> void:
	$seekerIcon.hide()
	SignalManager.becameSeeker.connect(_becomeSeeker)
	SignalManager.damageTaken.connect(_damageTaken)
	
	_amountExample.hide()
	
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
	
	
