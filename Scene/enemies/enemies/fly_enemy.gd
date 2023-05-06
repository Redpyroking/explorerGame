extends "res://Scene/enemies/basic_enemy.gd"

const MOVE_SPEED = 80
const DETECTION_RANGE = 200
const SHOOTING_RANGE = 100
export (PackedScene) var bullet 
var is_chasing = false
var can_shoot = true

func _ready():
	randomize()

func _physics_process(delta):
	if is_chasing:
		var direction = (Global.Player.global_position - global_position).normalized()
		velocity = direction * MOVE_SPEED
	else:
		if randi() % 100 == 0:
			velocity = Vector2(rand_range(-1, 1), rand_range(-1, 1)).normalized() * MOVE_SPEED
	$AnimatedSprite.rotation_degrees += 500 *delta
	move_and_slide(velocity, Vector2.ZERO)

	var player_distance = Global.Player.global_position.distance_to(global_position)
	if player_distance < SHOOTING_RANGE:
		$RayCast2D.cast_to = Global.Player.global_position - global_position
		is_chasing = false
		velocity = Vector2.ZERO
		if can_shoot:
			shoot()
			$wait_time.start()
			can_shoot = false

	elif player_distance < DETECTION_RANGE:
		$RayCast2D.cast_to = Global.Player.global_position - global_position
		if $RayCast2D.is_colliding():
			is_chasing = false
		else:
			is_chasing = true
	else:
		is_chasing = false
		$RayCast2D.cast_to = Vector2.ZERO

func hit(new_dir):
	health -= 1
	if health < 1:
		create_coin()
		create_coin()
		queue_free()
	else:
		velocity = Vector2.ZERO
		apply_knockback(new_dir,160)
		$knock_time.start()

func _on_knock_time_timeout():
	$knock_time.wait_time = 0.3

func shoot():
	var b = bullet.instance()
	get_parent().get_parent().add_child(b)
	var dir = (global_position - Global.Player.global_position).normalized().angle()
	b._initial(global_position,dir-PI,10)

func _on_wait_time_timeout():
	$wait_time.wait_time = 1
	can_shoot = true
