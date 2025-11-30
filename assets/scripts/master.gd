class_name MasterScene extends Node

func _init() -> void:
	global.masterScene = self

func switch_scene(scenepath : String):
	var scene: PackedScene = load(scenepath)
	if scene:
		var clonedScene: Node = scene.instantiate()
		util.clearChildren(self)
		add_child(clonedScene)
