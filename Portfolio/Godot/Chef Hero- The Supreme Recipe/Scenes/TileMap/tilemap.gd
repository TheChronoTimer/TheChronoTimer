extends TileMapLayer

#region Var
#region Funcionamento
#endregion
#region Controle
#endregion
#region Auxiliar
#endregion
#endregion

func _use_tile_data_runtime_update(coords):
	if coords in get_used_cells():
		if has_collision_at(coords): # THIS FUCKING LINE
			return true
	return false

func _tile_data_runtime_update(coords, tile_data):
	if coords in get_used_cells():
		tile_data.set_navigation_polygon(0, null)
		tile_data.set_navigation_polygon(1, null)