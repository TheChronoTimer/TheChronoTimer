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

func _ready():
	var full_rect = get_used_rect()
	for n_layer in navigation_layers:
		for c_layer in collision_layers:
			for x in range(full_rect.position.x, full_rect.end.x):
				for y in range(full_rect.position.y, full_rect.end.y):
					var coords = Vector2(x, y)
					if get_used_cells():
						var tile_data = get_cell_tile_data(coords)
						if tile_data and tile_data.get_collision_polygons_count(c_layer) > 0:
							_add_coords_into_global_array(coords)
	

func _add_coords_into_global_array(coords):
	var global_coords = coords + position
	if not global_coords in Global.collision_array:
		Global.collision_array.append(global_coords)