extends Area2D

func _on_paddle_touched(body):
	#Easiest to change body scale y and then use that information in level script, as y scale will never be altered in this game.
	body.scale.y *= 1.5
	queue_free()
