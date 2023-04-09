extends Node2D

const bullet = preload("res://Scene/weapon/bullet.tscn")
export (PackedScene) var weapon
var is_drilling = false

func _ready():
	change_weapon(weapon)

func change_weapon(new_weapon:PackedScene):
	if get_child_count() > 0:
		weapon = new_weapon
		get_child(0).queue_free()
		add_child(weapon.instance())
	else:
		add_child(weapon.instance())

func _physics_process(delta):
	if !is_drilling:
		look_at(get_global_mouse_position())
	if get_global_mouse_position().x < get_parent().global_position.x:
		get_parent().get_node("body").flip_h = true
		scale.y = -1
	else:
		get_parent().get_node("body").flip_h = false
		scale.y = 1

func _input(event):
	if Input.is_action_just_pressed("shoot"):
		if get_child(0).alias == "rifle":
			var b = bullet.instance()
			b._initial(get_child(0).global_position,get_child(0).global_rotation)
			get_child(0).get_node("bullet_holder").add_child(b)
		elif get_child(0).alias == "drill":
			get_child(0).get_node("AnimationPlayer").play("drill")
			is_drilling = true
	elif Input.is_action_just_released("shoot"):
		if get_child(0).alias == "drill":
			get_child(0).get_node("AnimationPlayer").play("RESET")
			is_drilling = false
#		b.set_as_toplevel(true)
