extends Node2D

#region Var
#region Funcionamento
@onready var Camera = $"/root/Main/Player/Camera2D"
@onready var MapLimits = $TileMap.get_used_rect()
@onready var CellSize = $TileMap.tile_set.tile_size
@onready var MapScale = scale
@onready var HUD = $HUD
@onready var Player = $Player
@onready var NPCs = $"/root/Main/NPCs"
@onready var TimerClock = $HUD/Timer
#endregion

#region Auxiliar
var HUDKey: String
#endregion
#endregion

#region Start
func _ready():
	TimerClock.timeout.connect(_on_timer_timeout)
	Camera.limit_top = (MapLimits.position.y * CellSize.y * MapScale.y) + (MapScale.y * CellSize.y)
	Camera.limit_left = (MapLimits.position.x * CellSize.x * MapScale.x) + (MapScale.x * CellSize.x)
	Camera.limit_bottom = (MapLimits.end.y * CellSize.y * MapScale.y) - (MapScale.y * CellSize.y)
	Camera.limit_right = (MapLimits.end.x * CellSize.x * MapScale.x) - (MapScale.x * CellSize.x)

func _process(_delta):
	_HUD_keys()
	HUD.Target = NPCs.get_node(_reverse_dict_search(Global.NPClist, Global.NPCsearch))
#endregion

#region Signal
func _on_timer_timeout():
	match HUDKey:
		"Compass":
			HUD.VisibNPCMenu = not HUD.VisibNPCMenu
		"Debug":
			print("Debug!")
		"ActionA":
			Player.Pointed = Player.Ray.get_collider()
			Player.PointedBak = Player.Pointed
			if Player.PointedBak == NPCs.get_node("Wizard"):
				print("Hey")
			Player.PointedBak = null
		"ActionB":
			var New = Player.Pointed.duplicate()
			New.global_position = Vector2i.ZERO
			NPCs.add_child(New)
			New.get_node("Timer").start()
			Player.Pointed = null
	HUDKey = ""
#endregion

#region Func
func _HUD_keys():
	if Input.is_anything_pressed():
		if TimerClock.is_stopped():
			TimerClock.start()
	if Input.is_action_pressed("Compass"):
		HUDKey = "Compass"
	if Input.is_action_pressed("Debug"):
		HUDKey = "Debug"
	if Input.is_action_pressed("ActionA"):
		if Player.Ray.is_colliding():
			HUDKey = "ActionA"
	if Input.is_action_pressed("ActionB"):
		if Player.Pointed:
			HUDKey = "ActionB"
	if Input.is_action_pressed("Ctrl"):
		Player.frameSpeed = 15
		Player.speed = 768
	else:
		Player.frameSpeed = 5
		Player.speed = 256
	if Input.is_action_pressed("Esc"):
		HUD.VisibNPCMenu = false

func _reverse_dict_search(where, target: int):
	for key in where.keys():
		if where[key] == target:
			return key
#endregion
