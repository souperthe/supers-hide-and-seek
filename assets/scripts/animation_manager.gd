@icon("res://assets/images/icons/film-spool.svg")
class_name AnimationManager extends Node


@export var _corePlayer:Player

var _animator:AnimationPlayer

var animationDone:bool = false
var animationName:String = ""



func _animationFinished(_animationName:String) -> void:
	print("animation done")
	animationDone = true
	return


func playAnimation(desiredAnimation:String, speed:float=1, seek:float=0, blend:float=-1) -> void:
	if _animator == null:
		return
		
	if _animator.current_animation == desiredAnimation:
		return
		
	animationName = desiredAnimation
		
	_animator.play(
		desiredAnimation,
		blend,
		speed
	)
	_animator.seek(seek)
	
	animationDone = false
	
	_corePlayer.events.animation.rpc(
		desiredAnimation,
		speed,
		seek,
		blend
	)
	
	return
	
	


func animatorSetup() -> void:
	
	if _animator:
		_animator.animation_finished.disconnect(_animationFinished)
	
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
