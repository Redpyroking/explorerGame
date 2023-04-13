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
	if character:
		$Sprite.animation = character.alias

func _physics_process(delta):
	if character == null:
		$function_manager.call("aab",delta)
	else:
		$function_manager.call(character.ability_func,delta)
	velocity.y += gravity * delta
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed * delta
		get_node("Sprite").flip_h = false
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= speed * delta
		get_node("Sprite").flip_h = true
	if is_on_floor():
		coyote_time = 0.08 # reset coyote time counter when on floor
		if Input.is_action_pressed("jump"):
			velocity.y = -jump_velocity
			can_climb = true
	else:
		coyote_time -= delta # decrement coyote time counter
		if Input.is_action_pressed("jump") and coyote_time > 0:
			velocity.y = -jump_velocity
			can_climb = true
		else:
			can_climb = false
	if Input.is_action_pressed("jump") and buffer_jump_time > 0:
		velocity.y = -jump_velocity
		buffer_jump_time = 0 # reset buffer jump counter
	if colliding_with_wall:
		velocity = move_and_slide(velocity, Vector2.UP)
	else:
		position.x += velocity.x * delta
		position.y += velocity.y * delta
		is_climbing = false
	velocity.x = lerp(velocity.x, 0, delta*8) # decrease friction

func hit():
	get_tree().reload_current_scene()

func _on_Wall_body_entered(body):
	colliding_with_wall = true

func _on_Wall_body_exited(body):
	colliding_with_wall = false

func _on_jump_cooldown_timeout():
	is_climbing = false
	$jump_cooldown.wait_time = 0.2
