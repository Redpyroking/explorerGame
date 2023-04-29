extends "res://Scene/enemies/basic_enemy.gd"

const MOVE_SPEED = 50
const DETECTION_RANGE = 170

var velocity = Vector2.ZERO
var is_chasing = false

func _ready():
	randomize()

func _physics_process(delta):
	if is_chasing:
		var player = get_parent().get_node("Player")
		var direction = (player.global_position - global_position).normalized()
		var ray_cast = get_world_2d().direct_space_state.intersect_ray(global_position, player.global_position, [], 2)
		if ray_cast.empty() or ray_cast.collider.name == "Wall":
			velocity = direction * MOVE_SPEED
		else:
			is_chasing = false
	else:
		if randi() % 100 == 0:
			velocity = Vector2(rand_range(-MOVE_SPEED, MOVE_SPEED), rand_range(-MOVE_SPEED, MOVE_SPEED))

	move_and_slide(velocity, Vector2.ZERO)

	var player_distance = get_parent().get_node("Player").global_position.distance_to(global_position)
	if player_distance < DETECTION_RANGE:
		is_chasing = true
	else:
		is_chasing = false
