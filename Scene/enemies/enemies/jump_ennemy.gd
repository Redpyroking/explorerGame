extends "res://Scene/enemies/basic_enemy.gd"

const GRAVITY = 720
const MOVE_SPEED = 75
const DETECTION_RANGE = 60
const COIN = preload("res://Scene/coin/coin.tscn")

onready var wall = get_tree().get_root().find_node("Wall",true,false)
var player
var direction
var is_hit = false

func _ready():
	randomize()
	player = get_parent().get_parent().find_node("Player",true,false)

func _physics_process(delta):
	check_fall(delta)
	direction = (player.global_position - global_position).normalized()
	var distance = player.global_position.distance_to(global_position)
	if distance < DETECTION_RANGE:
		if player.global_position.x < global_position.x:
			velocity.x = -MOVE_SPEED
		else:
			velocity.x = MOVE_SPEED
		if not is_jumping and is_on_floor():
			is_jumping = true
			velocity.y = JUMP_SPEED
	else:
		# Randomly jump if the player is out of range
		if not is_jumping:
			if randi() % 100 == 0:
				is_jumping = true
				velocity.y = JUMP_SPEED
				var move_ran = randi() % 2
				if velocity.x != 0:
					if velocity.x < 0:
						velocity.x = MOVE_SPEED
					else:
						velocity.x = -MOVE_SPEED
				else:
					match move_ran:
						0:
							velocity.x = MOVE_SPEED
						1:
							velocity.x = -MOVE_SPEED
	if velocity.x < 0:
		scale.x = -1
	else:
		scale.x = 1
	velocity = move_and_slide(velocity, Vector2.UP)

func check_fall(delta):
	if is_on_floor() and is_jumping:
		is_jumping = false
		velocity.y = 0
		velocity.x = 0
	elif is_on_ceiling() or !is_on_floor():
		velocity.y += GRAVITY * delta

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

func create_coin():
	var c = COIN.instance()
	get_parent().get_parent().get_node("Coin_box").call_deferred("add_child",c)
	c.global_position = global_position
	c.apply_knockback(Vector2(rand_range(-1,1),rand_range(-1,1)).normalized(),rand_range(3,10))

func _on_knock_time_timeout():
	$knock_time.wait_time = 0.3
