extends CharacterBody2D

#Funcionamento
@onready var Sprite = $Sprite
@onready var Ray = $RayCast2D
@onready var TimerClock = $Timer
@onready var NPCs = $"/root/Main/NPCs"

#Controle
@export var speed: int = 256
@export var frameSpeed: int = 5

#Auxiliar
var auxW = 0
var auxA = 0
var auxS = 0
var auxD = 0
var Pointed
var Pointed2

func _physics_process(_delta):
	_walk()
	_frame()
	_ctrl()
	_ActionA()
	_ActionB()

func _walk():
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

func _frame():
	Sprite.speed_scale = frameSpeed
	
	if velocity.length() > 0:
		Sprite.play()
		if abs(velocity.y) > abs(velocity.x):
			if velocity.y > 0:
				Sprite.animation = "Walk Down"
				Sprite.flip_h = false
				Ray.rotation_degrees = 0
			else:
				Sprite.animation = "Walk Up"
				Sprite.flip_h = false
				Ray.rotation_degrees = 180
		if abs(velocity.y) < abs(velocity.x):
			if velocity.x > 0:
				Sprite.animation = "Walk Right"
				Sprite.flip_h = false
				Ray.rotation_degrees = -90
			else:
				Sprite.animation = "Walk Left"
				Sprite.flip_h = true
				Ray.rotation_degrees = 90
	else:
		Sprite.pause()
		Sprite.frame = 0
	
	var sum = (auxW + auxS + auxA + auxD)
	match sum:
		0:
			pass
		auxA:
			Sprite.animation = "Walk Left"
			Sprite.flip_h = true
		auxD:
			Sprite.animation = "Walk Right"
			Sprite.flip_h = false
		auxW:
			Sprite.animation = "Walk Up"
			Sprite.flip_h = false
		auxS:
			Sprite.animation = "Walk Down"
			Sprite.flip_h = false

func _ctrl():
	if Input.is_action_pressed("Ctrl"):
		frameSpeed = 15
		speed = 768
	else:
		frameSpeed = 5
		speed = 256

func _ready():
	TimerClock.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	var New = Pointed.duplicate()
	New.global_position = Vector2i.ZERO
	get_parent().get_node("NPCs").add_child(New)
	print(NPCs.get_node("Willy").get_children())
	print(Pointed.get_children())
	print(New.get_children())
	print(New.Player)
	Pointed = null

func _ActionA():
	if Ray.is_colliding() && Input.is_action_pressed("ActionA"):
		Pointed = Ray.get_collider()
		Pointed2 = Pointed
		if Pointed2 == NPCs.get_node("Wizard"):
			print("Hey")
		Pointed2 = null

func _ActionB():
	if Input.is_action_pressed("ActionB") and Pointed:
		if TimerClock.is_stopped():
			TimerClock.start()
