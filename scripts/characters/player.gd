extends CharacterBody2D

const SPEED = 200.0
const ACCELERATION = 20.0
const FRICTION = 40.0

var DIRECTION = "DOWN"

func _ready():
	$AnimationPlayer.play()
	$AnimationPlayer.current_animation = "idle_down"

func _physics_process(delta):
	input_movement(delta)
	sprite_animation_selector()

func sprite_animation_selector():
	match DIRECTION:
		"WALK_DOWN": 
			$AnimationPlayer.current_animation =  "walk_down"
		"WALK_UP":
			$AnimationPlayer.current_animation =  "walk_up"
		"WALK_RIGHT":
			$AnimationPlayer.current_animation =  "walk_right"
		"WALK_LEFT":
			$AnimationPlayer.current_animation =  "walk_left"
		"IDLE_DOWN": 
			$AnimationPlayer.current_animation =  "idle_down"
		"IDLE_UP":
			$AnimationPlayer.current_animation =  "idle_up"
		"IDLE_RIGHT":
			$AnimationPlayer.current_animation =  "idle_right"
		"IDLE_LEFT":
			$AnimationPlayer.current_animation =  "idle_left"

func input_movement(delta):
	var input_dir = Vector2()
	
	input_dir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_dir.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	var _velocity = input_dir.normalized()
	
	velocity = _velocity.move_toward(input_dir * SPEED, ACCELERATION * delta) * SPEED
	
	
	if velocity.x < 0:
		DIRECTION = "WALK_LEFT"
	if velocity.x > 0:
		DIRECTION = "WALK_RIGHT"	
	if velocity.y > 0:
		DIRECTION = "WALK_DOWN"
	if velocity.y < 0:
		DIRECTION = "WALK_UP"	
	if velocity.y == 0 and velocity.x == 0:
		DIRECTION = DIRECTION.replace("WALK","IDLE")
	
	
	
	move_and_slide()
