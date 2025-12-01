class_name MasterScene extends Node

var currentScene: Node

func _init() -> void:
	global.masterScene = self

func _ready() -> void:
	switch_scene("res://assets/scenes/sub/mainmenu.tscn")

func switch_scene(scenepath : String):
	var scene: PackedScene = load(scenepath)
	if scene:
		var clonedScene: Node = scene.instantiate()
		util.clearChildren(self)
		add_child(clonedScene)
		currentScene = clonedScene
