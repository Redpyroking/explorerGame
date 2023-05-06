extends Area2D

var speed = 500
var motion = Vector2.RIGHT

func _initial(pos,dir,time):
	global_position = pos
	global_rotation = dir
	motion= Vector2.RIGHT.rotated(dir)
	$Timer.wait_time = time

func _physics_process(delta):
	position += speed *motion* delta

func _on_bullet_body_entered(body):
	if body.has_method("hit"):
		if body == Global.Player:
			body.hit()
		else:
			var dir = (global_position - body.global_position).normalized()
			body.hit(dir)
		queue_free()
	else:
		queue_free()

func _on_Timer_timeout():
	queue_free()
