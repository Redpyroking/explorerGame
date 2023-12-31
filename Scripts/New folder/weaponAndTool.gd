extends Node2D

export(Resource) var gun_resource 
const bullet = preload("res://Scene/weapon/bullet.tscn")

func fire(weapon_name,pos,rot):
	if gun_resource:
		match weapon_name:
			"rifle":
				create_bullet_at(pos,rot,1)
			"shotgun":
				create_bullet_at(pos,rot+0.2,0.1)
				create_bullet_at(pos,rot,0.1)
				create_bullet_at(pos,rot-0.2,0.1)

func create_bullet_at(pos,rot,time):
	var b = bullet.instance()
	b.get_node("Sprite").texture = gun_resource.bullet
	b._initial($Position2D.global_position,rot,time)
	$bullet_holder.add_child(b)

func init(new_gun_resource):
	gun_resource = new_gun_resource
	$Sprite.texture = gun_resource.sprite
