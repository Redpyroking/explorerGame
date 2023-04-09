extends KinematicBody2D

var velocity = Vector2()
var speed = 1200
var jump_velocity = 300
var gravity = 980
var character_id = 0
export(Array,Resource) var characters_group

var buffer_jump_time = 0.0
var coyote_time = 0.0
var attacking = false
var falling = false

func _ready():
	for character in characters_group:
		if character != null:
			character.set_stat(1)

func _physics_process(delta):
	velocity.y += gravity * delta
	set_fall_animation()
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed * delta
		$Sprite.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= speed * delta
		$Sprite.flip_h = true
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			velocity.y = -jump_velocity
	else:
		coyote_time -= delta # decrement coyote time counter
		if Input.is_action_pressed("ui_up") and coyote_time > 0:
			velocity.y = -jump_velocity
	if Input.is_action_pressed("ui_up") and buffer_jump_time > 0:
		velocity.y = -jump_velocity
		buffer_jump_time -= delta # decrement buffer jump counter
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.x = lerp(velocity.x, 0, delta*8) # decrease friction

func _input(event):
	if event is InputEventKey and event.is_pressed():
		if event.scancode == KEY_TAB:
			switch_character()
		elif event.scancode == KEY_SPACE:
			attacking = true

func set_fall_animation():
	if !attacking:
		if !is_on_floor() and velocity.y > 0:
			falling = true
		else:
			if falling:
				falling = false

func switch_character():
	character_id += 1
	if character_id >= characters_group.size():
		character_id = 0
	var new_character = characters_group[character_id].instance()
	get_parent().add_child(new_character)
	self.queue_free()

func hit():
	get_tree().reload_current_scene()
