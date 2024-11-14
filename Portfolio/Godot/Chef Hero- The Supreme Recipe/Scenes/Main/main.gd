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
var CellX
var CellY
var LimitTop
var LimitLeft
var LimitBottom
var LimitRight
#endregion
#endregion

#region Start
func _ready():
	TimerHUD.timeout.connect(_on_timerhud_timeout)
	_variables()
	_camera()

func _process(_delta):
	_baking()
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
			print("Debug Mode!")
			PET.get_node("NavigationAgent2D").debug_enabled = true
			#for NPC in NPCs.get_children():
			#	NPC.get_node("NavigationAgent2D").debug_enabled = true
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

func _baking():
	var nav_region = $NavigationRegion2D
	nav_region.bake_navigation_polygon()
	#fazer região navegável
	#cozinhar

func _camera():
	Camera.limit_top = LimitTop
	Camera.limit_left = LimitLeft
	Camera.limit_bottom = LimitBottom
	Camera.limit_right = LimitRight

func _variables():
	CellX = (MapScale.x * CellSize.x)
	CellY = (MapScale.y * CellSize.y)
	LimitTop = (MapLimits.position.y * CellY) + CellY
	LimitLeft = (MapLimits.position.x * CellX) + CellX
	LimitBottom = (MapLimits.end.y * CellY) - CellY
	LimitRight = (MapLimits.end.x * CellX) - CellX
#endregion
