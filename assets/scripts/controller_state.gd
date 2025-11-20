@icon("res://addons/plenticons/icons/svg/symbols/todo-white.svg")
@abstract
class_name ControllerState extends Node

@export var _initalAction:String

var currentAction:ControllerAction
var _previousAction:ControllerAction

var _allActions:Dictionary[String, ControllerAction]


func controllerInit() -> void:
	
	var children:Array[Node] = get_children()
	
	for child in children:
		
		if !(child is ControllerAction):
			continue
		
		_allActions[child.name.to_lower()] = child
		
		continue
	
	return
	
func actionTransition(actionName:String)->void:
	
	_previousAction = currentAction
	currentAction = null
	
	if _previousAction:
		_previousAction.actioneExit()
		
	var foundAction:ControllerAction = _allActions.get(actionName.to_lower())
	
	if foundAction == null:
		currentAction = _previousAction
		return
		
	foundAction.actionEnter()
	currentAction = foundAction
	
	
	return

@abstract
func controllerStart(_message:String="") -> void
	
func controllerExit() -> void:
	return
	
func controllerProcess(_delta:float) -> void:
	return
	
func controllerPhysics(_delta:float) -> void:
	return
