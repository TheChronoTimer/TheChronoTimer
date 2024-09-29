extends CanvasLayer

#Funcionamento
@export var Player: Node2D
@export var Target: Node2D
@export var NumPopUp: int = 32
@export var VisibNPCMenu: bool = 0

#Controle
@onready var Compass = $Compass/Pointer
@onready var Icon = $Compass/Sphere/Icon
@onready var NPCMenu = $"NPC Menu"
@onready var PopUp = $"NPC Menu/Pop-Up"
@onready var ButtonX = $"NPC Menu/ButtonX"

#Auxiliar
var requested_coords = Vector2.ZERO
var pointer_position = Vector2.ZERO

func _physics_process(_delta):
	_set_compass_angle()
	Icon.frame = Global.NPCsearch
	if VisibNPCMenu == true:
		NPCMenu.show()
	else:
		NPCMenu.hide()

func _input(event):
	if VisibNPCMenu == true:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				var mouse_position = PopUp.get_local_mouse_position()
				for i in range(NumPopUp):
					var icon_node = PopUp.get_node("Icon" + str(i + 1).pad_zeros(2))
					if icon_node:
						var texture_size = icon_node.sprite_frames.get_frame_texture(icon_node.animation, icon_node.frame).get_size()
						var rect = Rect2(icon_node.position - texture_size / 2, texture_size)
						if rect.has_point(mouse_position):
							Global.NPCsearch = i
							VisibNPCMenu = false
							return

func _set_compass_angle():
	var direction = (Player.global_position - Target.global_position).normalized()
	Compass.rotation_degrees = rad_to_deg(direction.angle()) - 135

func _ready():
	ButtonX.pressed.connect(_on_ButtonX_pressed)
	_change_npc_menu_icons()

func _change_npc_menu_icons():
	set_process_input(true)
	for i in range(NumPopUp):
		var icon_name = "Icon" + str(i + 1).pad_zeros(2)
		PopUp.get_node(icon_name).frame = i

func _on_ButtonX_pressed():
	VisibNPCMenu = not VisibNPCMenu
