extends Area2D

@export var base_speed = Vector2(300, 150)
@onready var base_pos = global_position

@onready var hit_sound = $Hit_Sound
@onready var death_sound = $Death_Sound

var speed = Vector2(0,0)
var hits = 0

func _physics_process(delta):
	if Input.is_action_just_pressed("launch_ball") and speed.y == 0 :
		hit_sound.pitch_scale = randf_range(3,3.5)
		hit_sound.play()
		speed = base_speed
		if randf()>0.5:
			speed.x = -speed.x
	global_position -= speed*delta
	if global_position.y<10:
		global_position.y=10
		speed.y = -speed.y
	if global_position.x<10:
		global_position.x=10
		speed.x = -speed.x
	if global_position.x>1140:
		global_position.x=1140
		speed.x = -speed.x

func _on_body_entered(body):
	hit_sound.pitch_scale = randf_range(0.75,1.75)
	hit_sound.play()
	speed.y=-speed.y
	if body.is_in_group("paddle"):
		var speeddiffx = (speed.x - base_speed.x)/1000
		var speeddiffy = (speed.y - base_speed.y)/1000
		var diff = body.global_position.direction_to(global_position)
		if diff.x< (-0.75):
			speed.x = 325
		elif diff.x>0.75:
			speed.x = -325
		else:
			pass
	else:
		body.hit()
		hits+=1
		if hits>10:
			speed*=1.1
			hits=0

#deathzone
func _on_area_entered(area):
	death_sound.pitch_scale=randf_range(1,2)
	death_sound.play()
	speed = Vector2(0,0)
	global_position = base_pos
