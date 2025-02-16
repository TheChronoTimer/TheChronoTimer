extends Node2D

#Funcionamento
@onready var Layer = $TileMapLayer
@onready var UsedRect = Layer.get_used_rect()
@onready var CellSize = Layer.tile_set.tile_size
@export var CENA: PackedScene

func _ready():
	#SetLimits()
	var level_navigation_map = get_world_2d().get_navigation_map()
	NavigationServer2D.map_set_edge_connection_margin(level_navigation_map, 8.0)
	$NavigationRegion2D.bake_navigation_polygon(true)

func SetLimits():
	var limit_top = UsedRect.position.y
	var limit_left = UsedRect.position.x
	var limit_bottom = UsedRect.end.y
	var limit_right = UsedRect.end.x
	var horiz = limit_right - limit_left
	var vert = limit_bottom - limit_top
	for i in horiz:
		for j in vert:
			if Layer.get_cell_atlas_coords(Vector2i(i, j)).x == 1:
				var novo = CENA.instantiate()
				novo.position.x = (i + limit_left) * CellSize.x + (CellSize.x/2)
				novo.position.y = (j + limit_top) * CellSize.y + (CellSize.y/2)
				add_child(novo)
