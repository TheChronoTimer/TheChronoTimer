extends Node2D

#Funcionamento
@onready var Camera = $Player/Camera2D
@onready var MapLimits = $TileMap.get_used_rect()
@onready var MapCellSize = $TileMap.tile_set.tile_size
@onready var MapScale = scale
@onready var HUD = $HUD
@onready var Player = $Player
@onready var NPCs = $NPCs
@onready var TimerClock = $HUD/Timer

#Auxiliar

func _ready():
	TimerClock.timeout.connect(_on_timer_timeout)

func _process(_delta):
	_limit_camera()
	
	_debug()
	_set_compass_target()

func _debug():
	if Input.is_action_pressed("Debug"):
		if TimerClock.is_stopped():
			TimerClock.start()

func _reverse_dict_search(where, target: int):
	for key in where.keys():
		if where[key] == target:
			return key

func _limit_camera():
	Camera.limit_top = (MapLimits.position.y * MapCellSize.y * MapScale.y) + (MapScale.y * MapCellSize.y)
	Camera.limit_left = (MapLimits.position.x * MapCellSize.x * MapScale.x) + (MapScale.x * MapCellSize.x)
	Camera.limit_bottom = (MapLimits.end.y * MapCellSize.y * MapScale.y) - (MapScale.y * MapCellSize.y)
	Camera.limit_right = (MapLimits.end.x * MapCellSize.x * MapScale.x) - (MapScale.x * MapCellSize.x)

func _set_compass_target():
	HUD.Target = NPCs.get_node(_reverse_dict_search(Global.NPClist, Global.NPCsearch))

func _on_timer_timeout():
	HUD.VisibNPCMenu = not HUD.VisibNPCMenu
