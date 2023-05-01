extends KinematicBody2D

const JUMP_SPEED = -300
var velocity = Vector2.ZERO
export var health = 2
var is_jumping = false

const COIN = preload("res://Scene/coin/coin.tscn")

func _ready():
	randomize()

func hit(new_dir):
	health -= 1
	if health < 1:
		queue_free()

func apply_knockback(direction, force):
	velocity = -direction * force

func create_coin():
	var c = COIN.instance()
	get_parent().get_parent().get_node("Coin_box").call_deferred("add_child",c)
	c.global_position = global_position
	c.apply_knockback(Vector2(rand_range(-1,1),rand_range(-1,1)).normalized(),rand_range(6,16))

