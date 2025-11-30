class_name MasterScene extends Node

func switch_scene(scenepath : String):
	var scene: PackedScene = load(scenepath)
	if scene:
		var clonedScene: Node = scene.instantiate()
		util.clearChildren(self)
		add_child(clonedScene)
