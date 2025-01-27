extends TileMapLayer

#region Var
#region Funcionamento
@onready var ground = $Ground
#endregion

#region Controle
@export var cost_false: int = 2
@export var cost_true: int = 1
@export var discounted_tiles: Array[int] = [1, 2, 3, 4]
#endregion

#region Auxiliar
var used_rect = get_used_rect()
var cost
var collision_size = 2
#endregion
#endregion

#region Start
func _ready():
	_navigation_lock()
	_export_table()
#endregion
#region Func
func _navigation_lock():
	_for_xy(used_rect, func(x, y):
		for child in get_children():
			if child is TileMapLayer:
				var child_cell = child.get_cell_tile_data(Vector2(x, y))
				if child_cell:
					for i in range(collision_size):
						if child_cell.get_collision_polygons_count(i) > 0:
							var cell_data = self.get_cell_tile_data(Vector2(x, y))
							if cell_data:
								self.set_cell(Vector2i(x, y), -1)
	)

func _for_xy(square: Rect2, callable_function: Callable):
	for x in range(square.position.x, square.end.x):
		for y in range(square.position.y, square.end.y):
			callable_function.call(x, y)

func _export_table():
	
#endregion
