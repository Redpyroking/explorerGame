extends Node

onready var parent = get_parent()

func aaa(delta):#Wall Climbing
	if Input.is_action_just_pressed("climb") and parent.colliding_with_wall and !parent.is_on_floor():
			parent.is_climbing = !parent.is_climbing
			parent.velocity = Vector2()
			parent.falling = false
	if parent.is_climbing:
		if Input.is_action_pressed("jump"):
			if parent.colliding_with_wall:
				parent.velocity.y = -parent.jump_velocity
				parent.get_node("jump_cooldown").start()
			else:
				parent.can_climb = false
		if Input.is_action_pressed("ui_up"):
			parent.velocity.y = -parent.climb_speed
		elif Input.is_action_pressed("ui_down"):
			parent.velocity.y = parent.climb_speed
		else:
			parent.velocity.y = 0
		parent.velocity.x = 0

var direction = 1
func aab(delta):
	# If the "climb" key is pressed, perform a dash
	if Input.is_action_just_pressed("climb"):
		# Determine the direction of the dash based on the sprite's flip_h property
		if parent.get_node("Sprite").flip_h:
			direction = -1
		else:
			direction = 1
		
		# Add the dash velocity in the correct direction
		parent.velocity.x += 500 * direction
