@icon("res://addons/plenticons/icons/svg/objects/coins-white.svg")
class_name ControllerManager extends Node

var currentState:ControllerState
var _previousState:ControllerState

var _allStates:Dictionary[String, ControllerState]


func _ready() -> void:
	
	var children:Array[Node] = get_children()
	
	for child in children:
		
		if !(child is ControllerState):
			continue
		
		_allStates[child.name.to_lower()] = child
		
		continue
		
	for state in _allStates:
		
		var foundState:ControllerState = _allStates.get(state)
		
		foundState.controllerInit()
		
		continue
	
	
	return



func changeState(desiredState:String)->void:
	
	_previousState = currentState
	currentState = null
	
	if _previousState:
		_previousState.controllerExit()
		
	var foundState:ControllerState = _allStates.get(desiredState.to_lower())
	
	if foundState == null:
		currentState = _previousState
		return
		
	foundState.controllerStart()
	currentState = foundState
	
	
	return
