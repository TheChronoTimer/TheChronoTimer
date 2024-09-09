extends Node2D

#Funcionamento
@onready var camera = $Player/Camera2D
@onready var mapLimits = $TileMap.get_used_rect()
@onready var mapCellSize = $TileMap.tile_set.tile_size
@onready var MapScale = scale

func _process(_delta):
	limitCamera()

func limitCamera():
	camera.limit_top = (mapLimits.position.y * mapCellSize.y * MapScale.y) + (MapScale.y * mapCellSize.y)
	camera.limit_left = (mapLimits.position.x * mapCellSize.x * MapScale.x) + (MapScale.x * mapCellSize.x)
	camera.limit_bottom = (mapLimits.end.y * mapCellSize.y * MapScale.y) - (MapScale.y * mapCellSize.y)
	camera.limit_right = (mapLimits.end.x * mapCellSize.x * MapScale.x) - (MapScale.x * mapCellSize.x)
