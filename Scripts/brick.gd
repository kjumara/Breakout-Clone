extends RigidBody2D

signal power_up_spawned(power_up_instance)

@export var img = preload("res://Assets/Art/bricks/regular-regular/RegularRed.png")
@export var damaged_img = preload("res://Assets/Art/bricks/regular-damaged/RegularDamagedRed.png")

@export var is_strong_brick = false

var power_up_spawn_scene = preload("res://Scenes/power_up_spawner.tscn")

@onready var sprite_2d = $Sprite2D

func _ready():
	sprite_2d.texture = img
	
func hit():
	if is_strong_brick:
		strong_hit()
	else:
		die()

func strong_hit():
	if sprite_2d.texture == damaged_img:
		die()
	else:
		sprite_2d.texture = damaged_img

func die():
	if randf()>0.85:
		var pu_spawn_instance = power_up_spawn_scene.instantiate()
		pu_spawn_instance.global_position = global_position
		emit_signal("power_up_spawned",pu_spawn_instance)
		
	queue_free()
