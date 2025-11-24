@icon("res://addons/plenticons/icons/svg/creatures/person-red.svg")
class_name Player extends CharacterBody3D

var playerName:String = "steamuser99"
var authID:int = 1
var steamID:int = 1

var currentTeam:superEnum.teams = superEnum.teams.hider

@export var camera:Camera3D
@export var cameraArm:SpringArm3D

@export var controller:ControllerManager
@export var sound:SoundManager
@export var interactor:InteractionManager
@export var events:ClassRPCEvents
@export var animator:AnimationManager

@export var synchronizer:MultiplayerSynchronizer


@export var _neck:Node3D

@export var viewmodelRoot:Node3D
@export var modelRoot:Node3D

@export var neckOffset:Node3D

@export var collisionStanding:CollisionShape3D
@export var collisionCrouching:CollisionShape3D

@export var interactRay:RayCast3D

var cameraInput:bool = true

var cameraDir:Vector3
var wishDir:Vector3
var rawDir:Vector2

var useMovement:bool = true

var gravity:float = 42.0

var jump_velocity : float = 12.0

var crouching:bool = false

var firstPerson:bool = true

const walk_speed : float = 12.1
const sprint_speed : float = 18.1
const ground_accel : float = 12.0
const ground_decel : float = 20.0
const ground_friction : float = 3.5

# Air movement settings. Need to tweak these to get the feeling dialed in.
const air_cap : float = 0.85 # Can surf steeper ramps if this is higher, makes it easier to stick and bhop
const air_accel : float= 800.0
const air_move_speed : float = 500.0

const swim_up_speed : float = 10.0
const climb_speed : float = 7.0


func loadSeeker(seekerName:String) -> void:
	var desiredSeeker:Seeker = util.getSeeker(seekerName)
	
	if desiredSeeker == null:
		return
		
	#print(desiredSeeker.seekerQuote)`
	
	firstPerson = desiredSeeker.useFirstPerson
	
	if !firstPerson:
		cameraArm.spring_length = 5
		
	util.clearChildren(modelRoot)
	
	rotation = Vector3.ZERO
		
	var seekerModel:Node3D = desiredSeeker.seekerModel.instantiate()
	seekerModel.scale = desiredSeeker.seekerSize
	
	
	modelRoot.add_child(seekerModel)
	
	animator.animatorSetup()
	
	controller.changeState(desiredSeeker.stateName)
	

	
	
	
	currentTeam = superEnum.teams.seeker
	
	
	return


func getSpeed()->float:
	
	if crouching:
		return walk_speed/2
	
	return walk_speed

func _setupOthers() -> void:
	$playerHud.queue_free()
	$modelHolder/Player.cast_shadow = GeometryInstance3D.ShadowCastingSetting.SHADOW_CASTING_SETTING_ON
	return

func _setupAuthority()->void:
	camera.clear_current()
	
	Networking.localPlayer = self
	
	
	camera.make_current()
	camera.current = true
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	$modelHolder/Player.cast_shadow = GeometryInstance3D.ShadowCastingSetting.SHADOW_CASTING_SETTING_SHADOWS_ONLY
	
	$Talking.pixel_size = 0
	
	Console.add_command("load_seeker", loadSeeker, ["Seeker Name"], 1)
	return


func _ready() -> void:
	animator.animatorSetup()
	if !is_multiplayer_authority():
		_setupOthers()
		return
	_setupAuthority()
	return
	
func _process(_delta: float) -> void:
	if !is_multiplayer_authority():
		return
	rawDir = Input.get_vector("player_left", "player_right", "player_up", "player_down")
	cameraDir = (_neck.global_transform.basis * Vector3(rawDir.x, 0, rawDir.y)).normalized()
	
	var _movementDir:Vector3 = (global_transform.basis * Vector3(rawDir.x, 0, rawDir.y)).normalized()
	
	if !firstPerson:
		_movementDir = (neckOffset.global_transform.basis * Vector3(rawDir.x, 0, rawDir.y)).normalized()
	
	
	wishDir = Vector3(_movementDir.x, 0, _movementDir.z)
	return
	
func _physics_process(_delta: float) -> void:
	if !is_multiplayer_authority():
		return
		
	if useMovement:
		move_and_slide()
	return
	
func _unhandled_input(event: InputEvent) -> void:
	if !is_multiplayer_authority():
		return
		
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			
			_neck.rotate_x(-event.relative.y * global.look_sensitivity)
			_neck.rotation.x = clamp(_neck.rotation.x, deg_to_rad(-90), deg_to_rad(90))
			
			if firstPerson:
				rotate_y(-event.relative.x * global.look_sensitivity)
			else:
				neckOffset.rotate_y(-event.relative.x * global.look_sensitivity)
			
	return
