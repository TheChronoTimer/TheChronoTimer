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
	return coords in get_used_cells()

func _tile_data_runtime_update(coords, tile_data):
	if coords in get_used_cells():
		for layer in range(2):  # Itera sobre as camadas
			if tile_data.get_collision_polygons_count(layer):  # Verifica se há colisão na camada
				tile_data.set_navigation_polygon(layer, null)  # Remove o polígono de navegação