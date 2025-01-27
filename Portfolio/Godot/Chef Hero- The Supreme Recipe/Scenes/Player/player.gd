extends CharacterBody2D

#region Var
#region Funcionamento
@onready var Sprite = $Sprite
@onready var Ray = $RayCast2D
#endregion

#region Controle
@export var speed: int = 256
@export var frameSpeed: int = 5
#endregion

#region Auxiliar
var Pointed
var PointedBak
#var velocity: Vector2
#endregion
#endregion

#region Start
func _ready():
	Global.DefaultFrameSpeed = frameSpeed
	Global.DefaultSpeed = speed

func _physics_process(_delta):
	_walk()

func _process(_delta):
	_animation()
	_frame()
#endregion

#region Func
func _walk():
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	input_vector.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	
	velocity = input_vector.normalized() * speed
	move_and_slide()

func _animation():
	Sprite.speed_scale = frameSpeed
	var x = velocity.x
	var y = velocity.y
	match velocity:
		_ when abs(y) > abs(x) and y > 0:
			Sprite.animation = "Walk Down"
			Sprite.flip_h = false
			Ray.rotation_degrees = 0
		_ when abs(y) > abs(x) and y < 0:
			Sprite.animation = "Walk Up"
			Sprite.flip_h = false
			Ray.rotation_degrees = 180
		_ when abs(x) > abs(y) and x > 0:
			Sprite.animation = "Walk Right"
			Sprite.flip_h = false
			Ray.rotation_degrees = -90
		_ when abs(x) > abs(y) and x < 0:
			Sprite.animation = "Walk Left"
			Sprite.flip_h = true
			Ray.rotation_degrees = 90

func _frame():
	if velocity.length() > 0:
		Sprite.play()
	else:
		Sprite.pause()
		Sprite.frame = 0
#endregion
