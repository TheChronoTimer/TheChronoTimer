extends CharacterBody2D

#Funcionamento
@onready var Sprite = $Sprite
@onready var Nav = $NavigationAgent2D
@onready var TimerClock = $Timer

enum Modes {
	FollowPlayer,
	FollowCoords
}

#Controle
@export var speed: int = 128
@export var frameSpeed: int = 5
@export var player: Node2D
@export var modes: Modes
@export var coords: Vector2 = Vector2(0, 0)
@export var tileSize: int = 16

#Auxiliar
var vert
var horiz
var dir
var desloc

func _physics_process(_delta):
	match modes:
		0:
			vert = abs(player.global_position.y - self.global_position.y)
			horiz = abs(player.global_position.x - self.global_position.x)
			if vert >= tileSize*4 || horiz >= tileSize*4:
				dir = to_local(Nav.get_next_path_position()).normalized()
				velocity = dir * speed
				move_and_slide()
				Sprite.play()
			else:
				Sprite.pause()
				Sprite.frame = 0
		1:
			vert = abs(coords.y - self.global_position.y)
			horiz = abs(coords.x - self.global_position.x)
			if vert >= tileSize || horiz >= tileSize:
				dir = to_local(Nav.get_next_path_position()).normalized()
				velocity = dir * speed
				move_and_slide()
				Sprite.play()
			else:
				#coords.x += 3*desloc
				coords.y += 1*desloc
				#Sprite.pause()
				#Sprite.frame = 0

func _makepath():
	match modes:
		0:
			Nav.target_position = player.global_position
		1:
			Nav.target_position = coords

func _ready():
	TimerClock.timeout.connect(_on_timer_timeout)
	desloc = tileSize * 4
	coords *= desloc

func _on_timer_timeout():
	_makepath()

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
