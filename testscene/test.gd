extends Node2D

export (PackedScene) var jump_enemy
onready var timer = $Timer

func _ready():
	randomize()
	$Timer.start()

func _physics_process(delta):
	if $Timer.is_stopped():
		$Timer.wait_time = 1
		$Timer.start()

func _on_Timer_timeout():
	$Timer.wait_time = rand_range(1,3)
	var j = jump_enemy.instance()
	var rand_pos = Vector2(rand_range(0,300),rand_range(0,300))
	var wall_tile = $Wall.get_cellv($Wall.world_to_map(rand_pos))
	
	if wall_tile == -1 and $Enemy_box.get_child_count() < 10:
		j.global_position = rand_pos
		$Enemy_box.add_child(j)
		
	$Timer.wait_time = 1
	$Timer.start()
