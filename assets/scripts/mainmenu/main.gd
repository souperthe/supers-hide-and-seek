extends Control

func _on_networking_type_item_selected(index: int) -> void:
	pass # Replace with function body.

func _on_join_pressed() -> void:
	print("join")
	Networking.console._connectLobby()

func _on_host_pressed() -> void:
	print("create")
	Networking.console._createLobby()

func _on_selectseeker_pressed() -> void:
	hide()
	%menu.seekerPicker.show()

func _on_selecthider_pressed() -> void:
	pass # Replace with function body.

func _on_settings_pressed() -> void:
	pass # Replace with function body.
