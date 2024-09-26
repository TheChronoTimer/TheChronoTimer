extends CanvasLayer

#Funcionamento
@export var Player: Node2D
@export var Target: Node2D

#Controle
@onready var Compass = $Compass/Pointer
@onready var Icon = $Compass/Sphere/Icon

#Auxiliar
var requested_coords = Vector2.ZERO
var pointer_position = Vector2.ZERO

func _physics_process(_delta):
	_set_compass_angle()
	Icon.frame = Global.NPCsearch

func _set_compass_angle():
	var direction = (Player.global_position - Target.global_position).normalized()
	Compass.rotation_degrees = rad_to_deg(direction.angle()) - 135
