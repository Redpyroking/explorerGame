extends KinematicBody2D

const GRAVITY = 300
var motion = Vector2()
var is_dead = false

func _ready():
	motion.x = 70

func _physics_process(delta):
	fall(delta)
	move_and_slide(motion,Vector2.UP)

func fall(delta):
	if !is_on_floor():
		motion.y = GRAVITY
	else:
		move(delta)

func move(delta):
	if $RayCast2D.is_colliding():
		motion.x = -motion.x
		scale.x = -scale.x

func hit():
	is_dead = true
	$AnimationPlayer.play("die")
	set_collision_layer_bit(1,false)
	set_collision_mask_bit(0,false)
	set_collision_mask_bit(2,false)

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "die":
		queue_free()


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.hit()
