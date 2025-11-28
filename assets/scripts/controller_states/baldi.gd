extends ControllerState


@onready var notebookNode: Node3D = $Notebooks
var notebookScene: PackedScene = preload("res://assets/objects/characters/baldi/notebook.tscn")
var notebooks:Array[Notebook] = []
var maxNotebooks: int = 4
var explosion:PackedScene = preload("res://assets/objects/explosion_vfx.tscn")

func controllerStart(_message:String="") -> void:
	corePlayer.animator.animatorSetup()
	corePlayer.neckOffset.position.y = 1.5
	actionTransition(_initalAction)

func controllerPhysics(_delta:float) -> void:
	if Input.is_action_just_pressed("player_alt_ability"):
		corePlayer.seekerHud.get_node("BaldiHUD").switch_visible()
	
	if Input.is_action_just_pressed("player_ability"):
		if notebooks.size() >= 4:
			var oldestNotebook : Notebook = notebooks.pop_front()
			
			
			var explode:Node3D = explosion.instantiate()
			notebookNode.add_child(explode)
			explode.global_position = oldestNotebook.global_position
			util.lingerNode(explode,2)
			
			corePlayer.seekerHud.get_node("BaldiHUD").list.get_child(0).queue_free()
			oldestNotebook.queue_free()
		if useAbility():
			var newNotebook = notebookScene.instantiate()
			notebookNode.add_child(newNotebook)
			corePlayer.seekerHud.get_node("BaldiHUD").add_notebook(newNotebook)
			newNotebook.global_position = corePlayer.modelRoot.global_position + Vector3(0,2,0)
			notebooks.append(newNotebook)
