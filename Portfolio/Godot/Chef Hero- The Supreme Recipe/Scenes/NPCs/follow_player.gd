extends CharacterBody2D

#Funcionamento
@onready var Sprite = $Sprite
@onready var Nav = $NavigationAgent2D
@onready var TimerClock = $Timer

enum Modes {
	FollowPlayer,
	FollowCoords,
	FollowCoordsAndStop
}

#Controle
@export var speed: int = 128
@export var frameSpeed: int = 5
@export var player: Node2D
@export var modes: Modes
@export var coords: Array[Vector2] = []
@export var tileSize: int = 16

#Auxiliar
var vert
var horiz
var dir
var desloc = tileSize*4
var ArrSize
var Arr = 0


func _physics_process(_delta):
	match modes:
		0:
			vert = abs(player.global_position.y - self.global_position.y)
			horiz = abs(player.global_position.x - self.global_position.x)
		1, 2:
			vert = abs(coords[Arr].y - self.global_position.y)
			horiz = abs(coords[Arr].x - self.global_position.x)
	if vert >= desloc || horiz >= desloc:
		dir = to_local(Nav.get_next_path_position()).normalized()
		velocity = dir * speed
		move_and_slide()
		Sprite.play()
	else:
		if modes == 0:
			Sprite.pause()
			Sprite.frame = 0
		else:
			if ArrSize > (Arr+1):
				Arr += 1
			else:
				if modes == 1:
					Arr = 0
				if modes == 2:
					Sprite.pause()
					Sprite.frame = 0

func _ready():
	TimerClock.timeout.connect(_on_timer_timeout)
	ArrSize = coords.size()
	for i in ArrSize:
		coords[i] *= desloc

func _on_timer_timeout():
	match modes:
		0:
			Nav.target_position = player.global_position
		1, 2:
			Nav.target_position = coords[Arr]

func _process(_delta):
	Sprite.speed_scale = frameSpeed
	
	if velocity.length() > 0:
		if abs(velocity.y) > abs(velocity.x):
			if velocity.y >= 0:
				Sprite.animation = "Down"
			else:
				Sprite.animation = "Up"
		if abs(velocity.y) < abs(velocity.x):
			if velocity.x >= 0:
				Sprite.animation = "Right"
			else:
				Sprite.animation = "Left"
