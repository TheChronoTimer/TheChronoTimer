extends CharacterBody2D

#Funcionamento
@onready var Sprite = $AnimatedSprite2D

#Controle
@export var speed: int = 256
@export var frameSpeed: int = 5

#Auxiliar
var auxW = 0
var auxA = 0
var auxS = 0
var auxD = 0

func _ready():
	Sprite.play()

func _physics_process(_delta):
	walk()
	frame()
	ctrl()

func walk():
	velocity = Vector2.ZERO
	if Input.is_action_pressed("Right"):
		velocity.x += 1
		auxD = 1
	else:
		auxD = 0
	if Input.is_action_pressed("Left"):
		velocity.x -= 1
		auxA = 1
	else:
		auxA = 0
	if Input.is_action_pressed("Down"):
		velocity.y += 1
		auxS = 1
	else:
		auxS = 0
	if Input.is_action_pressed("Up"):
		velocity.y -= 1
		auxW = 1
	else:
		auxW = 0
	velocity = speed * velocity.normalized()
	move_and_slide()

func frame():
	Sprite.speed_scale = frameSpeed
	if velocity.length() > 0:
		Sprite.play()
		if abs(velocity.y) > abs(velocity.x):
			if velocity.y > 0:
				Sprite.animation = "Walk Down"
			else:
				Sprite.animation = "Walk Up"
		if abs(velocity.y) < abs(velocity.x):
			if velocity.x > 0:
				Sprite.animation = "Walk Right"
			else:
				Sprite.animation = "Walk Left"
	else:
		Sprite.pause()
		Sprite.frame = 0
	if (auxW + auxS + auxA + auxD) == 1:
		if auxA:
			Sprite.animation = "Walk Left"
		if auxD:
			Sprite.animation = "Walk Right"
		if auxW:
			Sprite.animation = "Walk Up"
		if auxS:
			Sprite.animation = "Walk Down"

func ctrl():
	if Input.is_action_pressed("Ctrl"):
		frameSpeed = 15
		speed = 768
	else:
		frameSpeed = 5
		speed = 256
