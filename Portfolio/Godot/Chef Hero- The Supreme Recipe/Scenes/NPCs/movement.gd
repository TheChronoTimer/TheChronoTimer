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
@export var modes: Modes
@export var target: Node2D
@export var coords: Array[Vector2] = []
@export var tileSize: int = 16
@export var mainScale: float = 4
@export var pixelEdge: int = 0

#Auxiliar
var vert
var horiz
var dir
var desloc = tileSize * mainScale
var ArrSize
var Arr = 0
var WalkAuthoriz = false

func _physics_process(_delta):
	_modes_target()
	if WalkAuthoriz == true:
		dir = to_local(Nav.get_next_path_position()).normalized()
		velocity = dir * speed
		if Nav.is_target_reachable() or !Nav.is_navigation_finished():
			move_and_slide()
			Sprite.play()
		else:
			Sprite.pause()
			Sprite.frame = 0
	else:
		if modes == 0 or modes == 1:
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
	var x = velocity.x
	var y = velocity.y
	match velocity:
		_ when abs(y) > abs(x) and y >= 0:
			Sprite.animation = "Down"
		_ when abs(y) > abs(x) and y < 0:
			Sprite.animation = "Up"
		_ when abs(x) > abs(y) and x >= 0:
			Sprite.animation = "Right"
		_ when abs(x) > abs(y) and x < 0:
			Sprite.animation = "Left"

func _modes_target():
	match modes:
		0, 1:
			if modes == 1:
				target = Player
			vert = abs(target.global_position.y - self.global_position.y)
			horiz = abs(target.global_position.x - self.global_position.x)
			if vert >= desloc+pixelEdge or horiz >= desloc+pixelEdge:
				WalkAuthoriz = true
			else:
				WalkAuthoriz = false
		2, 3:
			vert = abs(coords[Arr].y - self.global_position.y)
			horiz = abs(coords[Arr].x - self.global_position.x)
			if vert > tileSize+pixelEdge or horiz > tileSize+pixelEdge:
				WalkAuthoriz = true
			else:
				WalkAuthoriz = false
