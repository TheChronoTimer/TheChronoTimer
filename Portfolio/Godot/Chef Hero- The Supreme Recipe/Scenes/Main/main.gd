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
@onready var Cat = $"/root/Main/Animals/Cat"
@onready var NPCs = $"/root/Main/NPCs"
@onready var Animals = $"/root/Main/Animals"
@onready var TimerHUD = $Timers/TimerHUD
#endregion

#region Controle
@export var BakingFrequency: int = 15
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
		33:
			HUD.Target = Cat
		_:
			HUD.Target = NPCs.get_node(_reverse_dict_search(Global.NPClist, Global.NPCsearch))
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
		"CtrlC": #Ctrl+C
			Player.Pointed = Player.Ray.get_collider()
			Player.PointedBak = Player.Pointed
			CloneLocation = Player.Pointed.get_parent()
			if Player.PointedBak == CloneLocation.get_node("Wizard"):
				print("Hey")
			Player.PointedBak = null
		"CtrlV": #Ctrl+V
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
		"ActionA": #C
			pass
		"ActionB": #X
			pass
		"Inventory": #E/I
			_close_menu(HUD.VisibInvMenu)
			HUD.VisibInvMenu = not HUD.VisibInvMenu
	HUDKey = ""
#endregion

#region Func
func _HUD_keys():
	var actions = []
	for action in InputMap.get_actions():
		if not action.begins_with("ui_"):
			actions.append(str(action))

	for action in actions:
		if Input.is_action_just_pressed(action):
			match action:
				"CtrlC":
					if Player.Ray.is_colliding():
						HUDKey = action
						_timer_start()
						return
				"CtrlV":
					if Player.Pointed:
						HUDKey = action
						_timer_start()
						return
				"Esc":
					_close_menu()
					return
				"Ctrl":
					pass
				"Hotkey Up":
					if Global.Hotkey == 0:
						Global.Hotkey = 9
					else:
						Global.Hotkey -= 1
				"Hotkey Down":
					if Global.Hotkey == 9:
						Global.Hotkey = 0
					else:
						Global.Hotkey += 1
				_:
					if _is_integer(action):
						if int(action) == 0:
							Global.Hotkey = 9
						else:
							Global.Hotkey = int(action) - 1
					else:
						HUDKey = action
						_timer_start()
					return
	_ctrl()

func _round_to_dec(num, digit):
	var section = (round(num * pow(10, digit - 1)) - round(num * pow(10, digit))) / 10
	if section >= 5:
		return round(num * pow(10, digit)) / pow(10, digit)
	else:
		return floor(num * pow(10, digit)) / pow(10, digit)

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
	if except != HUD.VisibCatMenu:
		HUD.VisibCatMenu = false
	if except != HUD.VisibInvMenu:
		HUD.VisibInvMenu = false

func _camera():
	Camera.limit_top = LimitTop
	Camera.limit_left = LimitLeft
	Camera.limit_bottom = LimitBottom
	Camera.limit_right = LimitRight

func _variables():
	CellX = (MapScale.x * CellSize.x)
	CellY = (MapScale.y * CellSize.y)
	LimitTop = (MapLimits.position.y * CellY) - CellY
	LimitLeft = (MapLimits.position.x * CellX) - CellX
	LimitBottom = (MapLimits.end.y * CellY) + CellY
	LimitRight = (MapLimits.end.x * CellX) + CellX

func _for_xy(square: Rect2, callable_function: Callable):
	for x in range(square.position.x, square.end.x):
		for y in range(square.position.y, square.end.y):
			callable_function.call(x, y)

func _ctrl():
	if Input.is_action_pressed("Ctrl"):
		Player.frameSpeed = Global.DefaultFrameSpeed * 3
		Player.speed = Global.DefaultSpeed * 3
	else:
		Player.frameSpeed = Global.DefaultFrameSpeed
		Player.speed = Global.DefaultSpeed

func _is_integer(value: String):
	for letter in value:
		if letter < "0" or letter > "9":
			return false
	return true
#endregion
