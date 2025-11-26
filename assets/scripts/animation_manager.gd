@icon("res://assets/images/icons/film-spool.svg")
class_name AnimationManager extends Node


@export var _corePlayer:Player

var _animator:AnimationPlayer

var animationDone:bool = false
var animationName:String = ""
var animationBlend:float = -1



func _animationFinished(_animationName:String) -> void:
	#print("animation done")
	animationDone = true
	return
	
func animationSetSpeed(speed:float) -> void:
	
	if _animator == null:
		return
		
	if _animator.speed_scale == speed:
		return
		
	_animator.speed_scale = speed
	
	_corePlayer.events.animationSpeed.rpc(speed)
	
	return
	
func animationSeek(timePosition:float) -> void:
	
	if _animator == null:
		return
		
		
	_animator.seek(timePosition)
	
	
	_corePlayer.events.animationSeek.rpc(timePosition)
	
	return
	
func animationGetPosition() -> float:
	if _animator == null:
		return 0
	return _animator.get_current_animation_position()


func playAnimation(desiredAnimation:String, speed:float=1, seek:float=0, sending:bool=false) -> void:
	if _animator == null:
		return
		
	if _animator.current_animation == desiredAnimation:
		return
		
	animationName = desiredAnimation
		
	_animator.play(
		desiredAnimation,
		animationBlend,
	)
	_animator.speed_scale = speed
	_animator.seek(seek)
	
	animationDone = false
	
	if !sending:
	
		_corePlayer.events.animation.rpc(
			desiredAnimation,
			speed,
			seek,
		)
	
	return
	
	


func animatorSetup() -> void:
	
	if _animator:
		_animator.animation_finished.disconnect(_animationFinished)
		
	_animator = null
	animationName = ""
	animationDone = false
	
	var modelDescendants:Array = util.getDescendants(_corePlayer.modelRoot)
	
	for node in modelDescendants:
		if node is AnimationPlayer:
			_animator = node
			break
		else:
			continue
		continue
		
	if _animator == null:
		return
		
	_animator.animation_finished.connect(_animationFinished)
		
	
		
	
	
	return
