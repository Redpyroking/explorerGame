extends "res://Scene/enemies/basic_enemy.gd"

const GRAVITY = 720
const MOVE_SPEED = 95

onready var wall = get_tree().get_root().find_node("Wall",true,false)
var player
var is_hit = false

func _ready():
	randomize()
	player = get_parent().get_parent().find_node("Player",true,false)

func _physics_process(delta):
	check_fall(delta)
	# Randomly jump
	if not is_jumping and randi() % 100 == 0:
		is_jumping = true
		velocity.y = JUMP_SPEED
		var move_ran = randi() % 2
		if velocity.x != 0:
			if velocity.x < 0:
				velocity.x = MOVE_SPEED
				$AnimatedSprite.flip_h = false
			else:
				velocity.x = -MOVE_SPEED
				$AnimatedSprite.flip_h = true
		else:
			match move_ran:
				0:
					velocity.x = MOVE_SPEED
					$AnimatedSprite.flip_h = false
				1:
					velocity.x = -MOVE_SPEED
					$AnimatedSprite.flip_h = true
	velocity = move_and_slide(velocity, Vector2.UP)

func check_fall(delta):
	if is_on_floor() and is_jumping:
		is_jumping = false
		velocity = Vector2.ZERO
	elif is_on_ceiling() or !is_on_floor():
		velocity.y += GRAVITY * delta
	if is_jumping:
		$AnimatedSprite.frame = 1
	else:
		$AnimatedSprite.frame = 0

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

func _on_Area2D_body_entered(body):
	if body == Global.Player and is_jumping:
		Global.Player.hit()
