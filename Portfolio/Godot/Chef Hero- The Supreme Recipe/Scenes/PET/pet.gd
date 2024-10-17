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
	Stop,
	Sleep
}
#endregion

#region Controle
@export var speed: int = 128
@export var frameSpeed: int = 5
@export var modes: Modes = Modes.Stop
@export var target: Node2D = null
@export var coords: Array[Vector2] = []
@export var tileSize: int = 16
@export var mainScale: float = 4
@export var pixelDistance: int = 0
@export var distanceLimit: int = 0
@export var runDistance: int = 200
@export var runAllowed: bool = true
#endregion

#region Auxiliar
var dir = Vector2.ZERO
var desloc = tileSize * mainScale
var ArrSize = 0
var Arr = 0
var _tooNear = true
var pixelEdge = pixelDistance
var SitPointingDown = false
var SitMirrored = false
var SitMirroredLock = false
var currentSpeed: int = speed
var backupSpeed: int = speed
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
	_animation()
#endregion

#region Signal
func _on_timer_timeout():
	match modes:
		Modes.FollowTarget, Modes.FollowPlayer:
			Nav.set_target_position(target.global_position)
		Modes.FollowCoords, Modes.FollowCoordsAndStop:
			Nav.set_target_position(coords[Arr])
		Modes.Stop, Modes.Sleep:
			Nav.set_target_position(global_position)
#endregion

#region Func
func _walk():
	var vert: float
	var horiz: float
	var distance: float
	
	match modes:
		Modes.FollowTarget, Modes.FollowPlayer:
			_handle_follow_mode(vert, horiz, distance)
		Modes.FollowCoords, Modes.FollowCoordsAndStop:
			_handle_coords_mode(vert, horiz, distance)
		Modes.Stop, Modes.Sleep:
			_handle_stop_mode()

	if not _tooNear:
		_move_pet(distance)
	else:
		_handle_too_near()

func _handle_follow_mode(vert: float, horiz: float, distance: float):
	if modes == Modes.FollowPlayer:
		target = Player
	vert = abs(target.global_position.y - self.global_position.y)
	horiz = abs(target.global_position.x - self.global_position.x)
	distance = self.global_position.distance_to(target.global_position)
	_tooNear = vert < desloc + pixelEdge and horiz < desloc + pixelEdge
	SitMirrored = (target.global_position.x - self.global_position.x) <= 0

func _handle_coords_mode(vert: float, horiz: float, distance: float):
	vert = abs(coords[Arr].y - self.global_position.y)
	horiz = abs(coords[Arr].x - self.global_position.x)
	distance = self.global_position.distance_to(coords[Arr])
	_tooNear = vert <= tileSize + pixelEdge and horiz <= tileSize + pixelEdge
	SitMirrored = (coords[Arr].x - self.global_position.x) <= 0

func _handle_stop_mode():
	_tooNear = true
	velocity = Vector2.ZERO

func _move_pet(distance: float):
	dir = to_local(Nav.get_next_path_position()).normalized()
	currentSpeed = _calculate_speed(distance)
	velocity = dir * currentSpeed
	if Nav.is_target_reachable() or not Nav.is_navigation_finished():
		move_and_slide()
	pixelEdge = pixelDistance

func _calculate_speed(distance: float) -> int:
	if runAllowed and distance > runDistance and abs(dir.x) > abs(dir.y):
		return backupSpeed * 2
	return backupSpeed

func _handle_too_near():
	velocity = Vector2.ZERO
	pixelEdge = (distanceLimit * mainScale) + pixelDistance
	if not (modes == Modes.FollowTarget or modes == Modes.FollowPlayer):
		if ArrSize > (Arr + 1):
			Arr += 1
		elif modes == Modes.FollowCoords:
			Arr = 0

func _animation():
	var x = velocity.x
	var y = velocity.y
	match true:
		_ when modes == Modes.Stop:
			Sprite.speed_scale = frameSpeed
			if not SitMirroredLock:
				Sprite.flip_h = SitMirrored
				SitMirroredLock = true
			if SitPointingDown:
				_sit_down()
			else:
				_sit_right()
		_ when modes == Modes.Sleep:
			Sprite.speed_scale = 1
			Sprite.animation = "Sleeping"
			Sprite.play()
		_ when x == 0 and y == 0:
			Sprite.speed_scale = frameSpeed
			if not SitMirroredLock:
				Sprite.flip_h = SitMirrored
				SitMirroredLock = true
			if SitPointingDown:
				_sit_down()
			else:
				_sit_right()
		_ when abs(y) > abs(x) and y > 0:
			Sprite.speed_scale = frameSpeed
			_walk_down()
		_ when abs(y) > abs(x) and y < 0:
			Sprite.speed_scale = frameSpeed
			_walk_up()
		_ when abs(x) > abs(y) and x > 0:
			Sprite.speed_scale = frameSpeed
			if runAllowed and currentSpeed > backupSpeed:
				_run_right()
			else:
				_walk_right()
		_ when abs(x) > abs(y) and x < 0:
			Sprite.speed_scale = frameSpeed
			if runAllowed and currentSpeed > backupSpeed:
				_run_left()
			else:
				_walk_left()

func _walk_down():
	Sprite.animation = "Walk Down"
	SitPointingDown = true
	Sprite.flip_h = false
	SitMirroredLock = false
	Sprite.play()

func _walk_up():
	Sprite.animation = "Walk Up"
	SitPointingDown = false
	Sprite.flip_h = false
	SitMirroredLock = false
	Sprite.play()

func _walk_right():
	Sprite.animation = "Walk Right"
	SitPointingDown = false
	Sprite.flip_h = false
	SitMirroredLock = false
	Sprite.play()

func _walk_left():
	Sprite.animation = "Walk Left"
	SitPointingDown = false
	Sprite.flip_h = false
	SitMirroredLock = false
	Sprite.play()

func _run_right():
	Sprite.animation = "Run Right"
	SitPointingDown = false
	Sprite.flip_h = false
	SitMirroredLock = false
	Sprite.play()

func _run_left():
	Sprite.animation = "Run Right"
	SitPointingDown = false
	Sprite.flip_h = true
	SitMirroredLock = false
	Sprite.play()

func _sit_down():
	if Sprite.animation != "Sitting Down":
		Sprite.animation = "Sitting Down"
		Sprite.play()
	elif Sprite.animation == "Sitting Down":
		if Sprite.frame < Sprite.sprite_frames.get_frame_count("Sitting Down") - 1:
			Sprite.play()
		else:
			Sprite.stop()
			Sprite.frame = Sprite.sprite_frames.get_frame_count("Sitting Down") - 1

func _sit_right():
	if Sprite.animation != "Sitting Right" and Sprite.animation != "Sitted Right":
		Sprite.animation = "Sitting Right"
		Sprite.play()
	elif Sprite.animation == "Sitting Right" and Sprite.frame == Sprite.sprite_frames.get_frame_count("Sitting Right") - 1:
		Sprite.animation = "Sitted Right"
		Sprite.play()
#endregion
