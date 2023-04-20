extends TileMap

onready var light = get_parent().get_node("Light2D")
func _process(delta):
	light.texture.noise_offset.x += 1
