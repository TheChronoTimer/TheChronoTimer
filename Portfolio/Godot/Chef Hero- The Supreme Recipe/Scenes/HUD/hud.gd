extends CanvasLayer

#region Var
#region Funcionamento
@export var Player: Node2D
@export var Target: Node2D
@export var NumPopUp: int = 33
@export var VisibNPCMenu: bool = false
@export var VisibPETMenu: bool = false
#endregion

#region Controle
@onready var Compass = $Compass/Pointer
@onready var Icon = $Compass/Sphere/Icon
@onready var NPCMenu = $"NPC Menu"
@onready var NPCPopUp = $"NPC Menu/Pop-Up"
@onready var PETPopUp = $"PET Menu/Pop-Up"
@onready var ButtonX = $ButtonX
@onready var PETMenu = $"PET Menu"
@onready var PET = $"/root/Main/Animals/PET"
#endregion

#region Auxiliar
var requested_coords = Vector2.ZERO
var pointer_position = Vector2.ZERO
#endregion
#endregion

#region Start
func _ready():
	ButtonX.pressed.connect(_on_ButtonX_pressed)
	_change_npc_menu_icons()

func _physics_process(_delta):
	_set_compass_angle()
	Icon.frame = Global.NPCsearch
	_update_menu_visibility()
	_update_button_x_position()

func _input(_event):
	if _event is InputEventMouseButton and _event.button_index == MOUSE_BUTTON_LEFT and _event.is_pressed():
		_handle_menu_input(_event)
#endregion

#region Signal
func _on_ButtonX_pressed():
	_close_menu()
#endregion

#region Func
func _set_compass_angle():
	if Player and Target:
		var direction = (Player.global_position - Target.global_position).normalized()
		Compass.rotation_degrees = rad_to_deg(direction.angle()) - 135

func _change_npc_menu_icons():
	set_process_input(true)
	for i in range(NumPopUp):
		var icon_name = "Icon" + str(i + 1).pad_zeros(2)
		var icon_node = NPCPopUp.get_node_or_null(icon_name)
		if icon_node:
			icon_node.frame = i

func _close_menu(except = null):
	VisibNPCMenu = except == VisibNPCMenu
	VisibPETMenu = except == VisibPETMenu

func _is_mouse_over_icon(mouse_position: Vector2, icon_node: Node):
	var texture_size: Vector2
	if icon_node is AnimatedSprite2D:
		texture_size = icon_node.sprite_frames.get_frame_texture(icon_node.animation, icon_node.frame).get_size()
	elif icon_node is Sprite2D:
		texture_size = icon_node.texture.get_size()
	else:
		return false
	var icon_scale = icon_node.scale
	var parent_scale = icon_node.get_parent().scale
	var total_scale = parent_scale / icon_scale
	var rect = Rect2(
		icon_node.position - (texture_size * icon_scale) / total_scale,
		2 * (texture_size * icon_scale) / total_scale
	)
	return rect.has_point(mouse_position)

func _set_pet_mode(mode_index):
	if PET:
		match mode_index:
			0:
				PET.modes = PET.Modes.FollowPlayer
			1:
				PET.modes = PET.Modes.Stop
			2:
				PET.modes = PET.Modes.Sleep

func _update_menu_visibility():
	NPCMenu.visible = VisibNPCMenu
	PETMenu.visible = VisibPETMenu
	ButtonX.visible = VisibNPCMenu or VisibPETMenu

func _update_button_x_position():
	var visible_menu = null
	match true:
		VisibNPCMenu:
			visible_menu = NPCPopUp
		VisibPETMenu:
			visible_menu = PETPopUp
		_:
			visible_menu = null
	if visible_menu:
		var rect = visible_menu.get_rect()
		var viewport_size = get_viewport().size / 2
		var pop_up_location = (visible_menu.scale * Vector2(rect.end.x, rect.position.y)) + Vector2(8, 0)
		ButtonX.position = Vector2(viewport_size) + pop_up_location

func _handle_menu_input(_event: InputEvent):
	if VisibPETMenu:
		_handle_pet_menu_input(_event)
	elif VisibNPCMenu:
		_handle_npc_menu_input(_event)

func _handle_pet_menu_input(_event: InputEvent):
	var mouse_position = PETPopUp.get_local_mouse_position()
	var options = ["Follow Player", "Stop", "Sleep"]
	for i in range(options.size()):
		var icon_node = PETPopUp.get_node_or_null(options[i])
		if icon_node and _is_mouse_over_icon(mouse_position, icon_node):
			_set_pet_mode(i)
			_close_menu()
			return

func _handle_npc_menu_input(_event: InputEvent):
	var mouse_position = NPCPopUp.get_local_mouse_position()
	for i in range(NumPopUp):
		var icon_node = NPCPopUp.get_node_or_null("Icon" + str(i + 1).pad_zeros(2))
		if icon_node and _is_mouse_over_icon(mouse_position, icon_node):
			Global.NPCsearch = i
			_close_menu()
			return
#endregion