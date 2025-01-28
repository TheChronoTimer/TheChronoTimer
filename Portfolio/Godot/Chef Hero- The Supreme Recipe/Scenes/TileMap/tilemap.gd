extends TileMapLayer

#region Var
#region Funcionamento
@onready var ground = $Ground
#endregion

#region Controle
@export var cost_false: int = 2
@export var cost_true: int = 1
@export var tileset : TileSet
#endregion

#region Auxiliar
var used_rect = get_used_rect()
var cost
var collision_size = 2
#endregion
#endregionpl

#region Start
func _ready():
	_navigation_lock()
	_export_table()

func _process(_delta):
	_update_table()
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
	if not Global.collision_array:
		Global.collision_array = []
		for x in range(used_rect.size.x):
			var row = []
			for y in range(used_rect.size.y):
				row.append(false)
			Global.collision_array.append(row)
	
	_for_xy(used_rect, func(x, y):
		if self.get_cell_source_id(Vector2(x, y)) == -1:
			Global.collision_array[x][y] = false
		else:
			Global.collision_array[x][y] = true
	)

func _update_table():
	var origin = used_rect.position
	var shape = used_rect.size
	_for_xy(used_rect, func(x, y):
		var coord = Vector2(x, y)
		if coord in Global.npc_array:
			self.set_cell(coord, -1)
		var array = Vector2i((x - origin.x + int(shape.x / 2)), (y - origin.y + int(shape.y / 2)))
		if array.x >= 0 and array.y >= 0 and array.x < Global.collision_array.size() and array.y < Global.collision_array[0].size():
			if Global.collision_array[array.x][array.y]:
				self.set_cell(Vector2i(x, y), 53)
	)
#endregion
