extends Area2D

var speed = 500
var motion = Vector2.RIGHT

func _initial(pos,dir):
	global_position = pos
	global_rotation = dir
	motion= Vector2.RIGHT.rotated(dir)

func _physics_process(delta):
	position += speed *motion* delta

func _on_bullet_body_entered(body):
	if body.has_method("hit"):
		body.hit()
		queue_free()
	else:
		queue_free()
