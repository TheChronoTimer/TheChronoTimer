extends CharacterBody2D

#Funcionamento
@onready var Sprite = $AnimatedSprite2D

#Controle
@export var speed: int = 256

#Auxiliar
var horiz = 0

func _ready():
	Sprite.play()

func _physics_process(_delta):
	walk()
	frame()

func walk():
	velocity = Vector2.ZERO
	if Input.is_action_pressed("Right"):
		velocity.x += 1
		horiz = 1
	if Input.is_action_pressed("Left"):
		velocity.x -= 1
		horiz = 0
	if Input.is_action_pressed("Down"):
		velocity.y += 1
	if Input.is_action_pressed("Up"):
		velocity.y -= 1
	velocity = speed * velocity.normalized()
	move_and_slide()

func frame():
	if velocity.length() > 0:
		if horiz == 0:
			Sprite.animation = "Walk Left"
		else:
			Sprite.animation = "Walk Right"
	else:
		if horiz == 0:
			Sprite.animation = "Idle Left"
		else:
			Sprite.animation = "Idle Right"
