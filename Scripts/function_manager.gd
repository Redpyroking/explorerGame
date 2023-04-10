extends Node

onready var parent = get_parent()

func aaa(delta):
	if !parent.is_climbing:
		parent.velocity.y += parent.gravity * delta
		if Input.is_action_pressed("ui_right"):
			parent.velocity.x += parent.speed * delta
			parent.get_node("Sprite").flip_h = false
		elif Input.is_action_pressed("ui_left"):
			parent.velocity.x -= parent.speed * delta
			parent.get_node("Sprite").flip_h = true
		if parent.is_on_floor():
			parent.coyote_time = 0.08 # reset coyote time counter when on floor
			if Input.is_action_pressed("jump"):
				parent.velocity.y = -parent.jump_velocity
				parent.can_climb = true
		else:
			parent.coyote_time -= delta # decrement coyote time counter
			if Input.is_action_pressed("jump") and parent.coyote_time > 0:
				parent.velocity.y = -parent.jump_velocity
				parent.can_climb = true
			else:
				parent.can_climb = false
		if Input.is_action_pressed("jump") and parent.buffer_jump_time > 0:
			parent.velocity.y = -parent.jump_parent.velocity
			parent.buffer_jump_time = 0 # reset buffer jump counter
	else:
		if Input.is_action_pressed("jump"):
			if parent.colliding_with_wall:
				parent.velocity.y = -parent.jump_parent.velocity
				$jump_cooldown.start()
			else:
				parent.can_climb = false
		if Input.is_action_pressed("ui_up"):
			parent.velocity.y = -parent.climb_speed
		elif Input.is_action_pressed("ui_down"):
			parent.velocity.y = parent.climb_speed
		else:
			parent.velocity.y = 0
		parent.velocity.x = 0

	if parent.colliding_with_wall:
		parent.velocity = parent.move_and_slide(parent.velocity, Vector2.UP)
	else:
		parent.position.x += parent.velocity.x * delta
		parent.position.y += parent.velocity.y * delta
		parent.is_climbing = false
	parent.velocity.x = lerp(parent.velocity.x, 0, delta*8) # decrease friction

func aab(delta):
	parent.velocity.y += parent.gravity * delta
	if Input.is_action_pressed("ui_right"):
		parent.velocity.x += parent.speed * delta
		parent.get_node("Sprite").flip_h = false
	elif Input.is_action_pressed("ui_left"):
		parent.velocity.x -= parent.speed * delta
		parent.get_node("Sprite").flip_h = true
	if parent.is_on_floor():
		parent.coyote_time = 0.08 # reset coyote time counter when on floor
		if Input.is_action_pressed("jump"):
			parent.velocity.y = -parent.jump_velocity
			parent.can_climb = true
	else:
		parent.coyote_time -= delta # decrement coyote time counter
		if Input.is_action_pressed("jump") and parent.coyote_time > 0:
			parent.velocity.y = -parent.jump_velocity
			parent.can_climb = true
		else:
			parent.can_climb = false
	if Input.is_action_pressed("jump") and parent.buffer_jump_time > 0:
		parent.velocity.y = -parent.jump_parent.velocity
		parent.buffer_jump_time = 0 # reset buffer jump counter
