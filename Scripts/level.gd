extends Node2D

@export var next_level: PackedScene = null

@onready var LIFE1 = $HUD/LIFE1
@onready var LIFE2 = $HUD/LIFE2
@onready var LIFE3 = $HUD/LIFE3

@onready var bricks = $Bricks

@onready var printed_end = false

@onready var ball = $Ball
@onready var base_ball_size = ball.scale

@onready var paddle = $Paddle
@onready var base_paddle_size = paddle.scale

@onready var losing_scene = preload("res://Scenes/losing_scene.tscn")
@onready var ball_scene = preload("res://Scenes/ball.tscn")
func _process(delta):
	var brickCount = get_tree().get_node_count_in_group("brick")
	if brickCount <1:
		finished_level()
	elif brickCount < 5:
		moveTowardBrick()
	if paddle.scale.y < base_paddle_size.y:
		paddle.scale.y = base_paddle_size.y
		multiball()
	if paddle.scale.y > base_paddle_size.y:
		paddle.scale.y = base_paddle_size.y
		ball.scale *= .80*base_ball_size
		if ball.scale<.5*base_ball_size:
			ball.scale = base_ball_size*.5
	if paddle.scale.x > 2*base_paddle_size.x:
		paddle.scale.x = 2*base_ball_size.x
	if paddle.scale.x < .25*base_paddle_size.x:
		paddle.scale.x = .25*base_paddle_size
	
func _on_death_zone_entered(area):
	if area.is_in_group("bonus_ball"):
		area.queue_free()
	else:
		ball.scale = base_ball_size
		paddle.scale = base_paddle_size
		if LIFE3.visible:
			print("uh nuh")
			LIFE3.visible = false
		elif LIFE2.visible:
			print("uwu")
			LIFE2.visible = false
		elif LIFE1.visible:
			print("NOAW")
			LIFE1.visible = false
		else:
			lose()
		
func lose():
	ball.queue_free()
	get_tree().change_scene_to_file("res://Scenes/losing_scene.tscn")
	
func finished_level():
	if next_level != null:
		get_tree().change_scene_to_packed(next_level)
	else:
		get_tree().change_scene_to_file("res://Scenes/win_scene.tscn")


func _on_power_up_spawned(power_up_instance):
	add_child(power_up_instance)
	
func multiball():
	var ball_instance = ball_scene.instantiate()
	ball_instance.global_position = ball.global_position
	ball_instance.speed =ball.speed*1.1
	ball_instance.add_to_group("bonus_ball")
	var ball_instance2 = ball_scene.instantiate()
	ball_instance2.global_position = ball.global_position
	ball_instance2.speed = ball.speed*1.2
	ball_instance2.add_to_group("bonus_ball")
	add_child(ball_instance)
	add_child(ball_instance2)

func moveTowardBrick():
	var direction = 0
	var brick1 = get_tree().get_first_node_in_group("brick")
	if  ball.global_position.x > brick1.global_position.x:
		direction = 1
	elif ball.global_position.x < brick1.global_position.x:
		direction = -1
	ball.speed.x += direction
		
