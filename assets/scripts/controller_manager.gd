@icon("res://addons/plenticons/icons/svg/objects/coins-white.svg")
class_name ControllerManager extends Node

@export var corePlayer:Player

var currentState:ControllerState
var run:bool = true


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
		
		foundState.corePlayer = corePlayer
		foundState.coreManager = self
		
		foundState.controllerInit()
		
		continue
		
	changeState("hider")
	
	
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
		
	print(foundState)
		
	foundState.controllerStart()
	currentState = foundState
	
	
	return


func _process(delta: float) -> void:
	
	if !corePlayer.is_multiplayer_authority():
		return
	
	if !run:
		return
		
	if !currentState:
		return
		
	currentState.controllerProcess(delta)
	currentState._actionProcess(delta)
	
	return
	
func _physics_process(delta: float) -> void:
	
	if !corePlayer.is_multiplayer_authority():
		return
	
	if !run:
		return
		
	if !currentState:
		return
		
	currentState.controllerPhysics(delta)
	currentState._actionPhysics(delta)
	
	return
