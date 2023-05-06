extends Node2D

export (PackedScene) var weapon
var is_drilling = false

func _ready():
	change_weapon()

func change_weapon():
	if get_child_count() > 0:
		var w = weapon.instance()
		get_child(0).queue_free()
		add_child(w)
		w.init(get_parent().character.gun)
	else:
		var w = weapon.instance()
		add_child(w)
		w.init(get_parent().character.gun)

func _physics_process(delta):
	look_at(get_global_mouse_position())
	if get_global_mouse_position().x < get_parent().global_position.x:
		scale.y = -1
	else:
		scale.y = 1

func _input(event):
	if Input.is_action_just_pressed("shoot"):
		var weapon = get_child(0)
		weapon.fire(weapon.gun_resource.alias,global_position,global_rotation)
