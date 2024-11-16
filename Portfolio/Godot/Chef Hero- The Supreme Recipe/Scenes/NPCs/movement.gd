extends CharacterBody2D

#region Var
#region Funcionamento
@onready var Sprite = $Sprite
@onready var Nav = $NavigationAgent2D
@onready var TimerClock = $Timer
@onready var Player = $"/root/Main/Player"

enum Modes {
	FollowTarget,
	FollowPlayer,
	FollowCoords,
	FollowCoordsAndStop,
	Stop
}
#endregion

#region Controle
@export var speed: int = 32
@export var frameSpeed: int = 5
@export var modes: Modes
@export var target: Node2D
@export var coords: Array[Vector2] = []
@export var tileSize: int = 16
@export var mainScale: float = 4
@export var pixelDistance: int = 0
@export var distanceLimit: int = 0
#endregion

#region Auxiliar
var vert
var horiz
var dir
var desloc = tileSize * mainScale
var ArrSize
var Arr = 0
var _tooNear = true
var pixelEdge = pixelDistance
#var velocity: Vector2
#endregion
#endregion

#region Start
func _ready():
	TimerClock.timeout.connect(_on_timer_timeout)
	ArrSize = coords.size()
	for i in ArrSize:
		coords[i] *= desloc

func _physics_process(_delta):
	_walk()

func _process(_delta):
	_frame()
#endregion

#region Signal
func _on_timer_timeout():
	_animation()
	match modes:
		0, 1:
			Nav.target_position = target.global_position
		2, 3:
			Nav.target_position = coords[Arr]
#endregion

#region Func
func _walk():
	match modes:
		0, 1:
			if modes == 1:
				target = Player
			vert = abs(target.global_position.y - self.global_position.y)
			horiz = abs(target.global_position.x - self.global_position.x)
			if vert >= desloc+pixelEdge or horiz >= desloc+pixelEdge:
				_tooNear = false
			else:
				_tooNear = true
		2, 3:
			vert = abs(coords[Arr].y - self.global_position.y)
			horiz = abs(coords[Arr].x - self.global_position.x)
			if vert > tileSize+pixelEdge or horiz > tileSize+pixelEdge:
				_tooNear = false
			else:
				_tooNear = true
	if _tooNear == false:
		dir = to_local(Nav.get_next_path_position()).normalized()
		velocity = dir * speed
		if Nav.is_target_reachable() or not Nav.is_navigation_finished():
			#position += velocity * get_physics_process_delta_time()
			move_and_slide()
		pixelEdge = pixelDistance
	else:
		velocity = Vector2.ZERO
		pixelEdge = (distanceLimit*mainScale)+pixelDistance
		if not (modes == 0 or modes == 1):
			if ArrSize > (Arr+1):
				Arr += 1
			else:
				if modes == 2:
					Arr = 0

func _animation():
	Sprite.speed_scale = frameSpeed
	var x = velocity.x
	var y = velocity.y
	match velocity:
		_ when abs(y) > abs(x) and y > 0:
			Sprite.animation = "Down"
		_ when abs(y) > abs(x) and y < 0:
			Sprite.animation = "Up"
		_ when abs(x) > abs(y) and x > 0:
			Sprite.animation = "Right"
		_ when abs(x) > abs(y) and x < 0:
			Sprite.animation = "Left"

func _frame():
	if _tooNear == false:
		if Nav.is_target_reachable() or not Nav.is_navigation_finished():
			Sprite.play()
		else:
			Sprite.pause()
			Sprite.frame = 0
	else:
		if modes == 0 or modes == 1:
			Sprite.pause()
			Sprite.frame = 0
		else:
			if not (ArrSize > (Arr+1)):
				if modes == 3:
					Sprite.pause()
					Sprite.frame = 0
#endregion
