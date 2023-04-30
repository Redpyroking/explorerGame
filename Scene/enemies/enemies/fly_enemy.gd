extends "res://Scene/enemies/basic_enemy.gd"

const MOVE_SPEED = 80
const DETECTION_RANGE = 200

var is_chasing = false

func _ready():
	randomize()

func _physics_process(delta):
	if is_chasing:
		var direction = (Global.Player.global_position - global_position).normalized()
		velocity = direction * MOVE_SPEED
	else:
		if randi() % 100 == 0:
			velocity = Vector2(rand_range(-1, 1), rand_range(-1, 1)).normalized() * MOVE_SPEED

	move_and_slide(velocity, Vector2.ZERO)

	var player_distance = Global.Player.global_position.distance_to(global_position)
	if player_distance < DETECTION_RANGE:
		$RayCast2D.cast_to = Global.Player.global_position - global_position
		if $RayCast2D.is_colliding():
			is_chasing = false
		else:
			is_chasing = true
	else:
		is_chasing = false
		$RayCast2D.cast_to = Vector2.ZERO
