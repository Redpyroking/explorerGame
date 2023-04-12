extends KinematicBody2D

var velocity = Vector2()
var speed = 1200
var jump_velocity = 300
var gravity = 980
var character_id = 0
export(Resource) var character

var buffer_jump_time = 0.0
var coyote_time = 0.0
var attacking = false
var falling = false
var colliding_with_wall = false
var max_health: int

onready var heathbar = get_parent().get_node("CanvasLayer/Control/ProgressBar")

var is_climbing = false
var can_climb = false
var climb_speed = 100

func _ready():
	max_health = character.hp
	heathbar.max_value = max_health
	heathbar.value = max_health

func _physics_process(delta):
	if character == null:
		$function_manager.call("aab",delta)
	else:
		$function_manager.call(character.ability_func,delta)

func hit():
	get_tree().reload_current_scene()

func _on_Wall_body_entered(body):
	colliding_with_wall = true

func _on_Wall_body_exited(body):
	colliding_with_wall = false

func _on_jump_cooldown_timeout():
	is_climbing = false
	$jump_cooldown.wait_time = 0.2
