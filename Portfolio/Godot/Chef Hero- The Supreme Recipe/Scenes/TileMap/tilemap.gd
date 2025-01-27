extends TileMapLayer

func _ready():
	# Tamanho do retângulo usado pelo TileMap
	var used_rect = get_used_rect()

	# Itera sobre todas as coordenadas usadas no TileMap
	for x in range(used_rect.position.x, used_rect.end.x):
		for y in range(used_rect.position.y, used_rect.end.y):
			
			# Itera sobre os filhos do TileMap
			for child in get_children():
				if child is TileMapLayer:  # Garante que o filho é um TileMap
					var child_cell = child.get_cell_tile_data(Vector2(x, y))  # Obtém o ID do tile na coordenada
					if child_cell:
						if child_cell.get_collision_polygons_count(0) > 0:  # Se o tile existir, há colisão
							# Define o estado de "não caminhável" no layer Ground
							var cell_data = self.get_cell_tile_data(Vector2(x, y))
							if cell_data:  # Verifica se existe um tile na posição atual
								self.set_cell(Vector2i(x, y), -1)
