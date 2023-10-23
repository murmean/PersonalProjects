extends Area2D


func _on_Uzi_body_entered(body):
	if body.is_in_group("Player"):
		queue_free()
