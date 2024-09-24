extends CanvasLayer

#Funcionamento
@export var pointerAngle: float = 0
@export var Player: Node2D
@export var Target: Node2D

#Controle
@onready var Compass = $Compass/Bubble

#Auxiliar
var requested_coords = Vector2.ZERO
var pointer_position = Vector2.ZERO

func _physics_process(_delta):
	_set_compass_angle()

func _set_compass_angle():
	var direction = (Player.global_position - Target.global_position).normalized()
	Compass.rotation_degrees = rad_to_deg(direction.angle()) - 135
