extends Control

onready var time = get_node("")
onready var score = $Label3
func _on_RestartTimer_timeout():
	if get_tree().change_scene("res://levels/level1.tscn") != OK:
		score.set_text()
		print("problem")
