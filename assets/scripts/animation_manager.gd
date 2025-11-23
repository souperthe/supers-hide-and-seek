@icon("res://assets/images/icons/film-spool.svg")
class_name AnimationManager extends Node


@export var _corePlayer:Player

var _animator:AnimationPlayer



func playAnimation(animationName:String, speed:float=1, blend:float=-1) -> void:
	if _animator == null:
		return
		
	_animator.play(
		animationName,
		blend,
		speed
	)
	
	return


func animatorSetup() -> void:
	
	var modelDescendants:Array = util.getDescendants(_corePlayer.modelRoot)
	
	for node in modelDescendants:
		if node is AnimationPlayer:
			_animator = node
			break
		else:
			continue
		continue
		
	
		
	
	
	return
