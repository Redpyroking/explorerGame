extends KinematicBody2D

var velocity = Vector2.ZERO
const GRAVITY = 980

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		velocity.y = 0
	velocity = move_and_slide(velocity,Vector2.UP)
	velocity.x = lerp(velocity.x,0,0.01)

func apply_knockback(direction, force):
	velocity = -direction * force

func _on_Area2D_body_entered(body):
	get_parent().get_parent().get_node("CanvasLayer/Control").update_coin()
	queue_free()
