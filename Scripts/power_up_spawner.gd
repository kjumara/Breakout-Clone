extends Node2D

var increase_paddle_size_power = preload("res://Scenes/powerup_double_paddle_size.tscn")
var reduce_paddle_size_power = preload("res://Scenes/powerup_reduce_paddle_size.tscn")
var reduce_ball_size_power = preload("res://Scenes/powerup_reduce_ball_size.tscn")
var multiball_power = preload("res://Scenes/powerup_multiball.tscn")
var power_up_scenes = [increase_paddle_size_power, reduce_paddle_size_power, reduce_ball_size_power, multiball_power]

@onready var sound1 = $Sound1
@onready var sound2 = $Sound2

#Note: Once Powerups are built, this spawner will cause powerups to appear on a random interval.
#The powerups will show up completely randomly. There will be a bunch of different places it can spawn from.
#But the Y position will aways be from the top.
func _ready():
	var sound = randi_range(0,1)
	var pitch = randf_range(1,2)
	if sound == 0:
		sound1.pitch_scale = pitch
		sound1.play()
	else:
		sound2.pitch_scale = pitch
		sound2.play()
	var rand_power = power_up_scenes.pick_random()
	var power_up_instance = rand_power.instantiate()
	add_child(power_up_instance)
	
func _physics_process(delta):
	global_position.y += 100*delta
	if global_position.y > 700:
		queue_free()
