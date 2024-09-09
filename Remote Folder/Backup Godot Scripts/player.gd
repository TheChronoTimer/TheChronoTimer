extends CharacterBody2D

#Funcionamento
@onready var sprite = $Sprite2D

#Controle
@export var speed: int = 256
@export var frameSpeed: int = 8

#Auxiliar
var direcional = 0
var frame = 0
var walkTick = 0
var collider = 0

func _ready():
	pass

func _process(_delta):
	walk()
	changeFrame()
	if Input.is_action_pressed("Interact"):
		collider = $RayCast2D.get_collider()

func walk():
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

func changeFrame():
	if velocity.y == 0:
		if velocity.x > 0:
			direcional = 1
		if velocity.x < 0:
			direcional = 3
	if velocity.x == 0:
		if velocity.y > 0:
			direcional = 0
		if velocity.y < 0:
			direcional = 2
	
	if velocity.x != 0 || velocity.y != 0:
		walkTick += 1
		if walkTick >= frameSpeed:
			walkTick = 0
			if frame == 3:
				frame = 0
			else:
				frame += 1
	else:
		frame = 0
	
	sprite.set_frame_coords(Vector2i(frame, direcional))
