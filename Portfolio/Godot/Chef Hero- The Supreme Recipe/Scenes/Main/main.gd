extends Node2D

#region Var
#region Funcionamento
@onready var Camera = $"/root/Main/Player/Camera2D"
@onready var MapLimits = $TileMap.get_used_rect()
@onready var CellSize = $TileMap.tile_set.tile_size
@onready var MapScale = scale
@onready var HUD = $HUD
@onready var Player = $Player
@onready var Dog = $"/root/Main/Animals/Dog"
@onready var NPCs = $"/root/Main/NPCs"
@onready var TimerHUD = $Timers/TimerHUD
#@onready var nav_region = $NavigationRegion2D
#endregion

#
@export var BakingFrequency: int = 15
#

#region Auxiliar
var HUDKey: String
var CloneLocation
var CellX
var CellY
var LimitTop
var LimitLeft
var LimitBottom
var LimitRight
var BakingCounter: int = 0
#endregion
#endregion

#region Start
func _ready():
	TimerHUD.timeout.connect(_on_timerhud_timeout)
	_variables()
	_camera()

func _process(_delta):
	_HUD_keys()
	match Global.NPCsearch:
		32:
			HUD.Target = Dog
		_:
			HUD.Target = NPCs.get_node(_reverse_dict_search(Global.NPClist, Global.NPCsearch))
	_check_npc_obstacles()
#endregion

#region Signal
func _on_timerhud_timeout():
	match HUDKey:
		"Compass": #B
			_close_menu(HUD.VisibNPCMenu)
			HUD.VisibNPCMenu = not HUD.VisibNPCMenu
		"Debug": #K
			print("Debug Mode!")
			Dog.get_node("NavigationAgent2D").debug_enabled = true
			for NPC in NPCs.get_children():
				NPC.get_node("NavigationAgent2D").debug_enabled = true
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
		"Dog Mode": #M
			_close_menu(HUD.VisibDogMenu)
			HUD.VisibDogMenu = not HUD.VisibDogMenu
		"Cat Mode": #N
			_close_menu(HUD.VisibCatMenu)
			HUD.VisibCatMenu = not HUD.VisibCatMenu
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
	if Input.is_action_pressed("Dog Mode"):
		HUDKey = "Dog Mode"
		_timer_start()
	if Input.is_action_pressed("Cat Mode"):
		HUDKey = "Cat Mode"
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
	if except != HUD.VisibDogMenu:
		HUD.VisibDogMenu = false

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


func _check_npc_obstacles():
	if Global.npc_array == []:
		Global.npc_array.resize(Global.NPClist.size())
	
	for i in Global.NPClist.size():
		var NPCcoords = Vector2i(NPCs.get_node(_reverse_dict_search(Global.NPClist, i)).global_position/64)
		NPCcoords.y *= -1
		Global.npc_array[i] = NPCcoords
	print(Global.npc_array)
#endregion
