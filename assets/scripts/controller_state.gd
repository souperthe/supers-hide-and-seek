@icon("res://addons/plenticons/icons/svg/symbols/todo-white.svg")
@abstract
class_name ControllerState extends Node

@export var _initalAction:String

var coreManager:ControllerManager
var corePlayer:Player

var currentAction:ControllerAction
var currentActionName:String
var _previousAction:ControllerAction

var _allActions:Dictionary[String, ControllerAction]

func _handleViewmodelRotation(delta:float) -> void:
	var camera:Camera3D = corePlayer.camera
	var viewmodelRoot:Node3D = corePlayer.viewmodelRoot
	var weight:float = 24*delta
	var start:Vector3 = viewmodelRoot.global_rotation
	var goal:Vector3 = camera.global_rotation
	
	var lerped:Vector3 = util.vector3_angleLerp(start, goal, weight)
	var final:Vector3 = Vector3(
		clampf(lerped.x, goal.x-deg_to_rad(16), goal.x+deg_to_rad(16)),
		lerped.y,
		clampf(lerped.z, goal.z-deg_to_rad(45), goal.z+deg_to_rad(45))
	)
	viewmodelRoot.global_rotation = final
	return
	


func controllerInit() -> void:
	
	var children:Array[Node] = get_children()
	
	for child in children:
		
		if !(child is ControllerAction):
			continue
		
		_allActions[child.name.to_lower()] = child
		
		continue
		
	for action in _allActions:
		var foundAction:ControllerAction = _allActions[action]
		
		foundAction.coreState = self
		foundAction.coreSound = corePlayer.sound
		foundAction.corePlayer = corePlayer
		
		
		continue
		
	
	return
	
func actionTransition(actionName:String, message:String="")->void:
	
	_previousAction = currentAction
	currentAction = null
	
	if _previousAction:
		_previousAction.actioneExit()
		
	var foundAction:ControllerAction = _allActions.get(actionName.to_lower())
	
	if foundAction == null:
		currentAction = _previousAction
		return
		
	foundAction.actionEnter(message)
	currentAction = foundAction
	currentActionName = currentAction.name
	
	
	return

@abstract
func controllerStart(_message:String="") -> void
	
func controllerExit() -> void:
	return
	
func controllerProcess(_delta:float) -> void:
	return
	
func controllerPhysics(_delta:float) -> void:
	return

func _actionPhysics(delta:float) -> void:
	if !currentAction:
		return
		
	currentAction.actionPhysics(delta)

	return
	
func _actionProcess(delta:float) -> void:
	if !currentAction:
		return
		
	currentAction.actionProcess(delta)

	return
	
func useAbility(enterState:String="") -> bool:
	if corePlayer.abilityCooldown.time_left > 0:
		return false
	util.oneShotSFX("res://assets/sound/sfx/ui/buttonclick.wav")
	corePlayer.abilityTimer.start()
	corePlayer.abilityCooldown.start()
	if enterState != "":
		actionTransition(enterState)
	return true
