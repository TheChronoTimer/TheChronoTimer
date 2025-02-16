extends TileMapLayer

func _use_tile_data_runtime_update(coords):
	var cell_atlas_coords = self.get_cell_atlas_coords(Vector2i(1, 0))
	for coord in cell_atlas_coords:
		if coords == coord:
			return true
	return false

func _tile_data_runtime_update(coords, tile_data):
	if coords in self.get_cell_atlas_coords(Vector2i(1, 0)):
		tile_data.set_navigation_polygon(0, null)
