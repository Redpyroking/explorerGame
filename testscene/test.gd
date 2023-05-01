extends Node2D
#
#export (PackedScene) var jump_enemy
#export (PackedScene) var fly_enemy
#onready var timer = $Timer
#
#func _ready():
#	randomize()
#	$Timer.start()
#
#func _physics_process(delta):
#	if $Timer.is_stopped():
#		$Timer.wait_time = 1
#		$Timer.start()
#
#func _on_Timer_timeout():
#	$Timer.wait_time = rand_range(1,3)
#	var j = jump_enemy.instance()
#	var k = fly_enemy.instance()
#	var rand_pos_k = Vector2(rand_range(100,300),rand_range(100,300))
#	var rand_pos_j = Vector2(rand_range(100,300),rand_range(100,300))
#	var wall_tile_k = $Wall.get_cellv($Wall.world_to_map(rand_pos_k))
#	var wall_tile_j = $Wall.get_cellv($Wall.world_to_map(rand_pos_j))
#
#	if wall_tile_k == -1 and $Enemy_box.get_child_count() < 10:
#		j.global_position = rand_pos_k
#		$Enemy_box.add_child(j)
#	if wall_tile_j == -1 and $Enemy_box.get_child_count() < 20:
#		k.global_position = rand_pos_j
#		$Enemy_box.add_child(k)
#
#	$Timer.wait_time = 1
#	$Timer.start()
