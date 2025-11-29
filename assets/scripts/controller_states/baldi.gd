extends ControllerState


@onready var notebookNode: Node3D = $Notebooks
var notebookScene: PackedScene = preload("res://assets/objects/characters/baldi/notebook.tscn")
var explosion:PackedScene = preload("res://assets/objects/explosion_vfx.tscn")
var notebooks:Array[Notebook] = []
var maxNotebooks: int = 4

@rpc("authority","call_local","reliable")
func spawn_notebook(spawnPos: Vector3) -> void:
	var newNotebook = notebookScene.instantiate()
	notebookNode.add_child(newNotebook)
	newNotebook.global_position = spawnPos
	notebooks.append(newNotebook)
	if is_multiplayer_authority():
		corePlayer.seekerHud.get_node("BaldiHUD").add_notebook(newNotebook)

@rpc("authority","call_local","reliable")
func delete_notebook() -> void:
	var oldestNotebook : Notebook = notebooks.pop_front()
	var explode:Node3D = explosion.instantiate()
	notebookNode.add_child(explode)
	explode.global_position = oldestNotebook.global_position
	util.lingerNode(explode,2)
	oldestNotebook.queue_free()

func controllerStart(_message:String="") -> void:
	corePlayer.animator.animatorSetup()
	corePlayer.neckOffset.position.y = 1.5
	actionTransition(_initalAction)
	

func controllerPhysics(_delta:float) -> void:
	if Input.is_action_just_pressed("player_alt_ability"):
		corePlayer.seekerHud.get_node("BaldiHUD").switch_visible()
	
	if Input.is_action_just_pressed("player_ability"):
		if useAbility():
			if notebooks.size() >= 4:
				delete_notebook.rpc()
				corePlayer.seekerHud.get_node("BaldiHUD").list.get_child(0).queue_free()
			spawn_notebook.rpc(corePlayer.modelRoot.global_position + Vector3(0,2,0))
