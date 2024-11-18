extends Area2D

func _on_paddle_touched(body):
	body.scale.x *= 0.75
	queue_free()
	
