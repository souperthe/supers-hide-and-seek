@icon("res://addons/plenticons/icons/svg/creatures/person-red.svg")
class_name Player extends CharacterBody3D

var playerName:String = "steamuser99"
var authID:int = 1
var steamID:int = 1


var health:float = 100
var maxHealth:float = 100

var currentTeam:superEnum.teams = superEnum.teams.hider

@export var camera:Camera3D
@export var cameraArm:SpringArm3D

@export var controller:ControllerManager
@export var sound:SoundManager
@export var interactor:InteractionManager
@export var events:ClassRPCEvents
@export var animator:AnimationManager
@export var hitbox:HitboxManager
@export var voiceEmitter:VoiceEmitter
@export var playerHud:CanvasLayer
@export var seekerHud:CanvasLayer

@export var abilityTimer:Timer
@export var abilityCooldown:Timer

@export var synchronizer:MultiplayerSynchronizer


@export var _neck:Node3D

@export var viewmodelRoot:Node3D
@export var modelRoot:Node3D
@export var modelPivot:Node3D

@export var wallRay:RayCast3D

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



func takeDamage(amount:float, knockback:Vector3) -> void:
	print(amount)
	
	var previousHealth:float = health
	
	health -= amount
	
	
	velocity = knockback
	
	if health <= 0:
		health = 0
		events.callDead.rpc()
	
	SignalManager.damageTaken.emit(previousHealth, health, amount)
	sound.playSound("res://assets/resources/rnd_sound/player_hurt.tres")
	return
	
	
func loadHider(hiderName:String) -> void:
	var desiredHider:Hider = util.getHider(hiderName)
	
	if desiredHider == null:
		return
		
	currentTeam = superEnum.teams.hider
	firstPerson = true
	
	util.clearChildren(seekerHud)
	util.clearChildren(modelRoot)
	$Voice.pitch_scale = 1
	
	var hiderModel:Node3D = desiredHider.hiderModel.instantiate()
	hiderModel.scale = desiredHider.modelScale
	
	modelRoot.add_child(hiderModel)
	
	
	animator.animatorSetup()
	
	if is_multiplayer_authority():
	
		cameraArm.spring_length = 0
		util.setShadows(
			modelRoot,
			GeometryInstance3D.ShadowCastingSetting.SHADOW_CASTING_SETTING_SHADOWS_ONLY
		)
	
	
		controller.changeState("hider")
		
		
	return


func loadSeeker(seekerName:String) -> void:
	var desiredSeeker:Seeker = util.getSeeker(seekerName)
	
	if desiredSeeker == null:
		return
		
	#print(desiredSeeker.seekerQuote)`
	
	firstPerson = desiredSeeker.useFirstPerson
	
		
	_neck.rotation = Vector3.ZERO
	neckOffset.rotation = Vector3.ZERO
	modelRoot.rotation = Vector3.ZERO
	modelPivot.rotation = Vector3.ZERO
	rotation = Vector3.ZERO
	
	util.clearChildren(seekerHud)
	util.clearChildren(modelRoot)
	
		
	var seekerModel:Node3D = desiredSeeker.seekerModel.instantiate()
	seekerModel.scale = desiredSeeker.seekerSize
	
	$Voice.pitch_scale = 0.8
	
	
	modelRoot.add_child(seekerModel)
	
	animator.animatorSetup()
	
	if is_multiplayer_authority():
		if desiredSeeker.seekerHUD:
			var chosenSeekerHud:Control = desiredSeeker.seekerHUD.instantiate()
			chosenSeekerHud.corePlayer = self
			seekerHud.add_child(chosenSeekerHud)
			seekerHud.show()
	
		if !firstPerson:
			cameraArm.spring_length = 5
		else:
			cameraArm.spring_length = 0
			util.setShadows(
				modelRoot,
				GeometryInstance3D.ShadowCastingSetting.SHADOW_CASTING_SETTING_SHADOWS_ONLY
			)
	
	
		controller.changeState(desiredSeeker.stateName)
	

	
	
	
	currentTeam = superEnum.teams.seeker
	
	SignalManager.becameSeeker.emit(desiredSeeker)
	
	
	return

func getSpeed()->float:
	
	if crouching:
		return walk_speed/2
	
	return walk_speed

func _setupOthers() -> void:
	$playerHud.queue_free()
	$seekerHud.queue_free()
	return

func _setupAuthority()->void:
	camera.clear_current()
	
	Networking.localPlayer = self
	
	
	camera.make_current()
	camera.current = true
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	
	util.setShadows(
		modelRoot,
		GeometryInstance3D.ShadowCastingSetting.SHADOW_CASTING_SETTING_SHADOWS_ONLY
		)
	
	#$modelHolder/Player.cast_shadow = GeometryInstance3D.ShadowCastingSetting.SHADOW_CASTING_SETTING_SHADOWS_ONLY
	
	$Talking.pixel_size = 0
	
	Console.add_command("load_seeker", loadSeeker, ["Seeker Name"], 1)
	#Console.add_command("SERVER_seeker",local_loadSeeker,["Seeker Name"],1)
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
	
	if Input.is_action_just_pressed("mute_mic"):
		voiceEmitter.muted = not voiceEmitter.muted
		playerHud.get_node("Chat/MutedMic").visible = voiceEmitter.muted
		print("muted: %s" % voiceEmitter.muted)
	
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			
			_neck.rotate_x(-event.relative.y * global.look_sensitivity)
			_neck.rotation.x = clamp(_neck.rotation.x, deg_to_rad(-90), deg_to_rad(90))
			
			if firstPerson:
				rotate_y(-event.relative.x * global.look_sensitivity)
			else:
				neckOffset.rotate_y(-event.relative.x * global.look_sensitivity)
			
	return
