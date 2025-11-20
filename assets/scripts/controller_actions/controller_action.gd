@icon("res://addons/plenticons/icons/svg/2d/double-chevron-right-white.svg")
@abstract
class_name ControllerAction extends Node


var coreState:ControllerState
var corePlayer:Player


@abstract
func actionEnter(_message:String="")->void

@abstract
func actioneExit()->void

func actionProcess(_delta:float)->void:
	return

func actionPhysics(_delta:float)->void:
	return
