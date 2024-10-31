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

func _tile_data_runtime_update(coords, tile_data):
	if coords in get_used_cells():
		for n_layer in navigation_layers:
			for c_layer in collision_layers:
				if tile_data.get_collision_polygons_count(c_layer) > 0:
					tile_data.set_navigation_polygon(n_layer, null)
			for child in get_children():
				if child is TileMapLayer:
					child._tile_data_runtime_update(coords, tile_data)