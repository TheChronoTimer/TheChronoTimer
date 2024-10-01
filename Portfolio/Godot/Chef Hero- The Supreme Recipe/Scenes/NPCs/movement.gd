extends CharacterBody2D

#Funcionamento
@onready var Sprite = $Sprite
@onready var Nav = $NavigationAgent2D
@onready var TimerClock = $Timer
@onready var Player = $"/root/Main/Player"

enum Modes {
	FollowTarget,
	FollowPlayer,
	FollowCoords,
	FollowCoordsAndStop
}

#Controle
@export var speed: int = 128
@export var frameSpeed: int = 5
@export var target: Node2D
@export var modes: Modes
@export var coords: Array[Vector2] = []
@export var tileSize: int = 16
@export var mainScale: float = 4

#Auxiliar
var vert
var horiz
var dir
var desloc = tileSize * mainScale
var ArrSize
var Arr = 0
var ver = 0

func _physics_process(_delta):
	match modes:
		0, 1:
			if modes == 0:
				target = Player
			vert = abs(target.global_position.y - self.global_position.y)
			horiz = abs(target.global_position.x - self.global_position.x)
			if vert >= desloc || horiz >= desloc:
				ver = 1
			else:
				ver = 0
		2, 3:
			vert = abs(coords[Arr].y - self.global_position.y)
			horiz = abs(coords[Arr].x - self.global_position.x)
			if vert > tileSize || horiz > tileSize:
				ver = 1
			else:
				ver = 0
	
	if ver == 1:
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
				if modes == 2:
					Arr = 0
				if modes == 3:
					Sprite.pause()
					Sprite.frame = 0

func _ready():
	TimerClock.timeout.connect(_on_timer_timeout)
	ArrSize = coords.size()
	for i in ArrSize:
		coords[i] *= desloc

func _on_timer_timeout():
	match modes:
		0, 1:
			Nav.target_position = target.global_position
		2, 3:
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
