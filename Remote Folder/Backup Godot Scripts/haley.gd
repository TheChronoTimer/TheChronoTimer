extends CharacterBody2D

#Funcionamento
@onready var sprite = $Sprite2D

#Controle
@export var speed: int = 256
@export var frameSpeed: int = 8
@export var NPCDelay: int = 60

#Auxiliar
var direcional = 0
var frame = 0
var walkTick = 0
var NPCTick = 600
var direction = Vector2.ZERO
var backup = Vector2.ZERO

func _ready():
	pass

func _process(_delta):
	walk()
	changeFrame()

func walk():
	velocity = Vector2.ZERO
	
	NPCTick += 1
	if NPCTick >= NPCDelay:
		direction.x = randi_range(0, 2)
		direction.y = randi_range(0, 2)
		
		if direction.x == 1:
			velocity.x += 1
		
		if direction.x == 2:
			velocity.x -= 1
		
		if direction.y == 1:
			velocity.y += 1
		
		if direction.y == 2:
			velocity.y -= 1
		
		velocity = speed * velocity.normalized()
		
		NPCTick = 0
		backup.x = velocity.x
		backup.y = velocity.y
	
	velocity.x = backup.x
	velocity.y = backup.y
	
	move_and_slide()
	
func changeFrame():
	if velocity.y == 0:
		if velocity.x > 0:
			direcional = 2
		if velocity.x < 0:
			direcional = 4
	if velocity.x == 0:
		if velocity.y > 0:
			direcional = 1
		if velocity.y < 0:
			direcional = 3
	
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
