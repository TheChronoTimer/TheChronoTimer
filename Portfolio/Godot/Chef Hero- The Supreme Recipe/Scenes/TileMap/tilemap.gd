extends TileMapLayer

func _ready():
	for layer in get_children():
		if layer.name != "Ground":
			for tile in layer.get_tiles():
				if tile.has_collision():
					set_navigation_layer_enabled(0, false)
					set_navigation_layer_enabled(1, false)
				else:
					set_navigation_layer_enabled(0, tile.has_collision())
					set_navigation_layer_enabled(1, tile.has_collision())

func _process(_delta):
	pass
