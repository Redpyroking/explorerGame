extends KinematicBody2D

const JUMP_SPEED = -300
var velocity = Vector2.ZERO
export var health = 2
var is_jumping = false
var stun_time = 1.0

func _ready():
	randomize()

func hit(new_dir):
	health -= 1
	if health < 1:
		queue_free()

func apply_knockback(direction, force):
	velocity = -direction * force


