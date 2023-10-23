extends Control



func _on_RestartTimer_timeout():
	if get_tree().change_scene("res://screens/lobby/lobby.tscn") != OK:
		print("problem")
