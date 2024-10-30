extends TileMapLayer

#region Var
#region Funcionamento
#endregion
#region Controle
#endregion
#region Auxiliar
var collision_layers = [0]
var navigation_layers = [0, 1]
#endregion
#endregion

func _use_tile_data_runtime_update(coords):
	if coords in get_used_cells():
		if _has_collision_at(coords):
			return true
	return false

func _tile_data_runtime_update(coords, tile_data):
	if coords in get_used_cells():
		for layer in navigation_layers:
			tile_data.set_navigation_polygon(layer, null)

func _has_collision_at(coords):
	# Ver filhos
	var tile_data = get_cell_tile_data(local_to_map(coords))
	print("Tile ID: ", tile_data.get_id())
	for layer in collision_layers:
		if tile_data.get_collision_polygons_count(layer) > 0: # RETORNANDO SEMPRE 0
			return true
	return false