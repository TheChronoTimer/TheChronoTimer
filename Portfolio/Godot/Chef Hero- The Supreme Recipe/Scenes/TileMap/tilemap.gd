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
	return coords in get_used_cells()

func _tile_data_runtime_update(coords, tile_data):
	if coords in get_used_cells():
		for n_layer in navigation_layers:
			for c_layer in collision_layers:
				if tile_data.get_collision_polygons_count(c_layer) > 0:
					_add_coords_into_global_array(coords)
				_turn_off_navigation(tile_data, coords, n_layer)

func _turn_off_navigation(target, coords, n_layer):
	if coords in Global.collision_array:
		target.set_navigation_polygon(n_layer, null)

func _add_coords_into_global_array(coords):
	var global_coords = coords # + position
	if not global_coords in Global.collision_array:
		Global.collision_array.append(global_coords)