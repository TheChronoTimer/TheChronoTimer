extends CanvasLayer

#Funcionamento
@export var Player: Node2D
@export var Target: Node2D
@export var NumNPCMenu: int = 32
@export var VisibNPCMenu: bool = 0

#Controle
@onready var Compass = $Compass/Pointer
@onready var Icon = $Compass/Sphere/Icon
@onready var NPCMenu = $"NPC Menu/Pop-Up"

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
				var mouse_position = NPCMenu.get_local_mouse_position()
				for i in range(NumNPCMenu):
					var icon_name = "Icon" + str(i + 1).pad_zeros(2)
					var icon_node = NPCMenu.get_node(icon_name)
					if icon_node:
						var texture_size = icon_node.sprite_frames.get_frame_texture(icon_node.animation, icon_node.frame).get_size()
						var rect = Rect2(icon_node.position - texture_size / 2, texture_size)
						if rect.has_point(mouse_position):
							Global.NPCsearch = i
							VisibNPCMenu = 0

func _set_compass_angle():
	var direction = (Player.global_position - Target.global_position).normalized()
	Compass.rotation_degrees = rad_to_deg(direction.angle()) - 135

func _ready():
	set_process_input(true)
	for i in range(NumNPCMenu):
		var icon_name = "Icon" + str(i + 1).pad_zeros(2)
		NPCMenu.get_node(icon_name).frame = i
