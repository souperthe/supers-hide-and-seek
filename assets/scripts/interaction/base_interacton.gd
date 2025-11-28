@icon("res://addons/plenticons/icons/svg/3d/cube-white.svg")
@abstract
class_name Interaction extends Node


var currentlyInteractable:Object
var core:InteractionManager
var corePlayer:Player


@abstract
func enterInteraction(interactable:Object) -> void



func interactionProcess(delta:float) -> void:
	return
