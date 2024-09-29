extends Node2D

#Funcionamento
@onready var Camera = $Player/Camera2D
@onready var MapLimits = $TileMap.get_used_rect()
@onready var MapCellSize = $TileMap.tile_set.tile_size
@onready var MapScale = scale
@onready var HUD = $HUD
@onready var Player = $Player
@onready var NPCs = $NPCs

var TargetID = 6

func _process(_delta):
	limitCamera()
	_debug()

func _debug():
	if Input.is_action_pressed("Debug"):
		print(Player.position)
		_npc_selection()

func _npc_selection():
	HUD.Target = NPCs.get_node(_reverse_dict_search(Global.NPClist, TargetID))
	Global.NPCsearch = TargetID

func _reverse_dict_search(where, target: int):
	for key in where.keys():
		if where[key] == target:
			return key

func limitCamera():
	Camera.limit_top = (MapLimits.position.y * MapCellSize.y * MapScale.y) + (MapScale.y * MapCellSize.y)
	Camera.limit_left = (MapLimits.position.x * MapCellSize.x * MapScale.x) + (MapScale.x * MapCellSize.x)
	Camera.limit_bottom = (MapLimits.end.y * MapCellSize.y * MapScale.y) - (MapScale.y * MapCellSize.y)
	Camera.limit_right = (MapLimits.end.x * MapCellSize.x * MapScale.x) - (MapScale.x * MapCellSize.x)
