extends CharacterBody2D

#region Var
#region Funcionamento
@onready var Sprite = $Sprite
@onready var Ray = $RayCast2D
@onready var NPCs = $"/root/Main/NPCs"
#endregion

#region Controle
@export var speed: int = 256
@export var frameSpeed: int = 5
#endregion

#region Auxiliar
#endregion
var auxW = 0
var auxA = 0
var auxS = 0
var auxD = 0
var Pointed
var PointedBak
#endregion
#endregion

#region Start
func _physics_process(_delta):
	_walk()

func _process(_delta):
	_animation()
	_frame()
#endregion

#region Func
func _walk():
	velocity = Vector2.ZERO
	if Input.is_action_pressed("Right"):
		velocity.x += 1
	if Input.is_action_pressed("Left"):
		velocity.x -= 1
	if Input.is_action_pressed("Down"):
		velocity.y += 1
	if Input.is_action_pressed("Up"):
		velocity.y -= 1
	velocity = speed * velocity.normalized()
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
