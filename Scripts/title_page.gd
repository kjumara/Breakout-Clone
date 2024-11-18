extends Control

@export var level_1: PackedScene = null

func _on_start_pressed():
	if level_1:
		get_tree().change_scene_to_packed(level_1)
	else:
		print("Level Not Set")
		_on_quit_pressed()

func _on_quit_pressed():
	get_tree().quit()


func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/title_page.tscn")
