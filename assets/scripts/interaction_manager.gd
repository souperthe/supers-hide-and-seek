@icon("res://addons/plenticons/icons/svg/2d/diamond-white.svg")
class_name InteractionManager extends Node

@export var _corePlayer:Player
#@export var _holdPoint:Node3D

var _interactionProcesses : Array[Interaction]
var _allInteractions : Dictionary[String, Interaction]

var currentBody:RigidBody3D

func _ready() -> void:
	var children:Array[Node] = get_children()
	
	for child in children:
		if !(child is Interaction):
			continue
			
		_allInteractions[child.name.to_lower()] = child
		
		continue
	
	
	return
	
func startProcess(interactor:Interaction) -> void:
	_interactionProcesses.append(interactor)
	return
	
func endProcess(interactor:Interaction) -> void:
	_interactionProcesses.remove_at(
		_interactionProcesses.find(interactor)
	)
	return

func _startInteraction(interactable:Object) -> void:
	
	
	var interactionType:String = interactable.get_class().to_lower()
	
	if !_allInteractions.has(interactionType):
		return
	
	
	var possibleInteractor:Interaction = _allInteractions[interactionType]
	
	if _interactionProcesses.has(possibleInteractor):
		return
	
	if possibleInteractor == null:
		return
		
	possibleInteractor.core = self
	possibleInteractor.corePlayer = _corePlayer
	possibleInteractor.enterInteraction(interactable)
	
	
	return

func handleInteraction(delta:float)->void:
	
	for interaction in _interactionProcesses:
		interaction.interactionProcess(delta)
		continue
	
	var interactRay:RayCast3D = _corePlayer.interactRay
	var interactable:Object = interactRay.get_collider()
	
	
	if interactable == null:
		return
		
	if Input.is_action_just_pressed("player_interact"):
		_startInteraction(interactable)
	
	
	return
