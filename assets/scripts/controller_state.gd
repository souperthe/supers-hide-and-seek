@icon("res://addons/plenticons/icons/svg/symbols/todo-white.svg")
@abstract
class_name ControllerState extends Node

var currentAction:ControllerAction

@abstract
func controllerStart(_message:String)->void
	
