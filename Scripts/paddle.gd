extends CharacterBody2D

@export var speed = 200;

func _physics_process(delta):
	velocity = Vector2(0,0)
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed
	if Input.is_action_pressed("move_right"):
		velocity.x = speed
		
	move_and_slide()
	
	if global_position.x>1050:
		global_position.x=1050
	if global_position.x<100:
		global_position.x=100
