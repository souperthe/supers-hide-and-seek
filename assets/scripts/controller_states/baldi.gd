extends ControllerState


@onready var teleporterHolder: Node3D = $TeleportWrappers
var teleporterScene: PackedScene = preload("res://assets/objects/characters/baldi/teleporter.tscn")
var explosion:PackedScene = preload("res://assets/objects/explosion_vfx.tscn")
var Teleporters:Array[TeleportWrapper] = []
var maxTeleporters: int = 4

@rpc("authority","call_local","reliable")
func spawn_teleporter(spawnPos: Vector3) -> void:
	var newteleporter = teleporterScene.instantiate()
	teleporterHolder.add_child(newteleporter)
	newteleporter.global_position = spawnPos
	Teleporters.append(newteleporter)
	if is_multiplayer_authority():
		corePlayer.seekerHud.get_node("BaldiHUD").add_notebook(newteleporter)

@rpc("authority","call_local","reliable")
func delete_teleporter() -> void:
	var oldestteleporter : TeleportWrapper = Teleporters.pop_front()
	var explode:Node3D = explosion.instantiate()
	teleporterHolder.add_child(explode)
	explode.global_position = oldestteleporter.global_position
	util.lingerNode(explode,2)
	oldestteleporter.queue_free()

func _on_teleport_request(pos: Vector3) -> void:
	corePlayer.global_position = pos
	actionTransition("teleport")

func controllerStart(_message:String="") -> void:
	corePlayer.animator.animatorSetup()
	corePlayer.neckOffset.position.y = 1.5
	actionTransition(_initalAction)
	SignalManager.baldi_requestTP.connect(_on_teleport_request)

func controllerPhysics(_delta:float) -> void:
	
	if Input.is_action_just_pressed("player_alt_ability"):
		corePlayer.seekerHud.get_node("BaldiHUD").switch_visible()
	
	if Input.is_action_just_pressed("player_ability"):
		if useAbility():
			if Teleporters.size() >= 4:
				delete_teleporter.rpc()
				corePlayer.seekerHud.get_node("BaldiHUD").list.get_child(0).queue_free()
			spawn_teleporter.rpc(corePlayer.modelRoot.global_position + Vector3(0,0.1,0))
