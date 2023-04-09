extends TileMap

var deleting_tiles = false
var delete_timer = 0.0
var delete_time = 1.0 # Change this to adjust the hold time required for tile deletion
var selected_tile = 1
var last_deleted_tile_pos = null

func _input(event):
	if event.is_action_pressed("shoot"):
		deleting_tiles = true
		delete_timer = 0.0
	elif event.is_action_released("shoot"):
		deleting_tiles = false
		delete_timer = 0.0
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and event.pressed:
		var tile_pos = world_to_map(get_global_mouse_position())
		if is_valid_tile_pos(tile_pos):
			set_cellv(tile_pos, selected_tile)

func _process(delta):
	if deleting_tiles:
		delete_timer += delta
		var tile_pos = world_to_map(get_global_mouse_position())
		if tile_pos != last_deleted_tile_pos:
			delete_timer = 0.0
			last_deleted_tile_pos = tile_pos
		if delete_timer >= delete_time:
			if get_cellv(tile_pos) != -1 and is_near_player(tile_pos):
				# The player is holding down the "shoot" button and the cursor is over a tile near them
				set_cellv(tile_pos, -1)
	else:
		delete_timer = 0.0
		last_deleted_tile_pos = null

func is_near_player(tile_pos):
	var player_pos = world_to_map(get_parent().get_node("Player").position)
	var dx = abs(tile_pos.x - player_pos.x)
	var dy = abs(tile_pos.y - player_pos.y)
	return max(dx, dy) <= 1

func is_valid_tile_pos(tile_pos):
	# check if the tile position is within the bounds of the TileMap and is not occupied
	return tile_pos.x >= 0 and tile_pos.y >= 0 and tile_pos.x < get_used_rect().size.x and tile_pos.y < get_used_rect().size.y and get_cellv(tile_pos) == -1
