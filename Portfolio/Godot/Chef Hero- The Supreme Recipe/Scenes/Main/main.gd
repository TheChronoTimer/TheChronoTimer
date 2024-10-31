extends Node2D

#region Var
#region Funcionamento
@onready var Camera = $"/root/Main/Player/Camera2D"
@onready var MapLimits = $TileMap.get_used_rect()
@onready var CellSize = $TileMap.tile_set.tile_size
@onready var MapScale = scale
@onready var HUD = $HUD
@onready var Player = $Player
@onready var PET = $"/root/Main/Animals/PET"
@onready var NPCs = $"/root/Main/NPCs"
@onready var TimerHUD = $Timers/TimerHUD
#endregion

#region Auxiliar
var HUDKey: String
var CloneLocation
#endregion
#endregion

#region Start
func _ready():
	TimerHUD.timeout.connect(_on_timerhud_timeout)
	Camera.limit_top = (MapLimits.position.y * CellSize.y * MapScale.y) + (MapScale.y * CellSize.y)
	Camera.limit_left = (MapLimits.position.x * CellSize.x * MapScale.x) + (MapScale.x * CellSize.x)
	Camera.limit_bottom = (MapLimits.end.y * CellSize.y * MapScale.y) - (MapScale.y * CellSize.y)
	Camera.limit_right = (MapLimits.end.x * CellSize.x * MapScale.x) - (MapScale.x * CellSize.x)

func _process(_delta):
	_HUD_keys()
	match Global.NPCsearch:
		32:
			HUD.Target = PET
		_:
			HUD.Target = NPCs.get_node(_reverse_dict_search(Global.NPClist, Global.NPCsearch))
#endregion

#region Signal
func _on_timerhud_timeout():
	match HUDKey:
		"Compass": #N
			_close_menu(HUD.VisibNPCMenu)
			HUD.VisibNPCMenu = not HUD.VisibNPCMenu
		"Debug": #K
			print("Debug!")
		"ActionA": #C
			Player.Pointed = Player.Ray.get_collider()
			Player.PointedBak = Player.Pointed
			CloneLocation = Player.Pointed.get_parent()
			if Player.PointedBak == CloneLocation.get_node("Wizard"):
				print("Hey")
			Player.PointedBak = null
		"ActionB": #X
			var New = Player.Pointed.duplicate()
			New.global_position = Vector2i.ZERO
			CloneLocation.add_child(New)
			New.get_node("Timer").start()
			Player.Pointed = null
		"Pet Mode": #M
			_close_menu(HUD.VisibPETMenu)
			HUD.VisibPETMenu = not HUD.VisibPETMenu
	HUDKey = ""
#endregion

#region Func
func _HUD_keys():
	if Input.is_action_pressed("Compass"):
		HUDKey = "Compass"
		_timer_start()
	if Input.is_action_pressed("Debug"):
		HUDKey = "Debug"
		_timer_start()
	if Input.is_action_pressed("ActionA"):
		if Player.Ray.is_colliding():
			HUDKey = "ActionA"
			_timer_start()
	if Input.is_action_pressed("ActionB"):
		if Player.Pointed:
			HUDKey = "ActionB"
			_timer_start()
	if Input.is_action_pressed("Ctrl"):
		Player.frameSpeed = Global.DefaultFrameSpeed*3
		Player.speed = Global.DefaultSpeed*3
	else:
		Player.frameSpeed = Global.DefaultFrameSpeed
		Player.speed = Global.DefaultSpeed
	if Input.is_action_pressed("Esc"):
		_close_menu()
	if Input.is_action_pressed("Pet Mode"):
		HUDKey = "Pet Mode"
		_timer_start()
func _reverse_dict_search(where, target: int):
	for key in where.keys():
		if where[key] == target:
			return key

func _timer_start():
	if TimerHUD.is_stopped():
		TimerHUD.start()

func _close_menu(except = null):
	if except != HUD.VisibNPCMenu:
		HUD.VisibNPCMenu = false
	if except != HUD.VisibPETMenu:
		HUD.VisibPETMenu = false
#endregion
