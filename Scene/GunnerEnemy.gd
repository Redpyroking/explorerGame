extends "res://Scene/BaseEnemytscn.gd"

const SHOOT_COOLDOWN = 0.1

var is_player_nearby = false
var shoot_cooldown = 0.0
export(PackedScene) var Bullet 
export (bool) var is_looking_left = false


func _ready():
	motion.x = 0

func _physics_process(delta):
	if $GunCast.is_colliding():
		if shoot_cooldown <= 0 and !is_dead:
			shoot()
			shoot_cooldown = SHOOT_COOLDOWN
		else:
			shoot_cooldown -= delta
	if is_looking_left:
		$Body.flip_h = true
		$Hand.scale.x = -1
		$GunCast.scale.x = -1
	else:
		$Body.flip_h = false
		$Hand.scale.x = 1
		$GunCast.scale.x = 1

func shoot():
	var bullet = Bullet.instance()
	$Hand/gun.add_child(bullet)
	bullet.set_collision_mask_bit(1,false)
	bullet.set_collision_mask_bit(0,true)
	bullet._initial($Hand/gun.global_position-Vector2(0,2), 0)
