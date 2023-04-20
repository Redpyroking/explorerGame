extends "res://Scene/enemies/basic_enemy.gd"

const GRAVITY = 720
const JUMP_SPEED = -300
const MOVE_SPEED = 45
const DETECTION_RANGE = 60

var velocity = Vector2.ZERO
var is_jumping = false

func _physics_process(delta):

	if is_on_floor() and is_jumping:
		is_jumping = false
	
	if is_on_floor():
		velocity.y = 0
	else:
		velocity.y += GRAVITY * delta

	var player = get_parent().get_node("Player")
	var distance = player.global_position.distance_to(global_position)

	if distance < DETECTION_RANGE:
		if player.global_position.x < global_position.x:
			velocity.x = -MOVE_SPEED
		else:
			velocity.x = MOVE_SPEED

		if not is_jumping:
			is_jumping = true
			velocity.y = JUMP_SPEED
	else:
		# Randomly jump if the player is out of range
		if not is_jumping:
			if randi() % 300 == 0:
				is_jumping = true
				velocity.y = JUMP_SPEED
				if randi() % 2 ==0:
					velocity.x += MOVE_SPEED*2
				else:
					velocity.x -= MOVE_SPEED*2

	move_and_slide(velocity, Vector2.UP)

