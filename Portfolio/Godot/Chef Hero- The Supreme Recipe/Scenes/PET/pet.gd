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
@export var speed: int = 128
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
var SitPointingDown = false
var SitMirrored = false
var SitMirroredLock = false
var SitCommand = false
var oldModesState
#endregion
#endregion

#region Start
func _ready():
	TimerClock.timeout.connect(_on_timer_timeout)
	ArrSize = coords.size()
	for i in ArrSize:
		coords[i] *= desloc
	oldModesState = modes

func _physics_process(_delta):
	_walk()

func _process(_delta):
	_animation()
	_frame()
#endregion

#region Signal
func _on_timer_timeout():
	match modes:
		0, 1:
			Nav.target_position = target.global_position
		2, 3:
			Nav.target_position = coords[Arr]
		4:
			Nav.target_position = self.global_position
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
			if (target.global_position.x - self.global_position.x) > 0:
				SitMirrored = false
			else:
				SitMirrored = true
		2, 3:
			vert = abs(coords[Arr].y - self.global_position.y)
			horiz = abs(coords[Arr].x - self.global_position.x)
			if vert > tileSize+pixelEdge or horiz > tileSize+pixelEdge:
				_tooNear = false
			else:
				_tooNear = true
			if (coords[Arr].x - self.global_position.x) > 0:
				SitMirrored = false
			else:
				SitMirrored = true
	if SitCommand == true:
		modes = 4
	else:
		modes = oldModesState

	if _tooNear == false:
		dir = to_local(Nav.get_next_path_position()).normalized()
		velocity = dir * speed
		if Nav.is_target_reachable() or not Nav.is_navigation_finished():
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
	if SitCommand == false:
		match velocity:
			_ when x == 0 and y == 0:
				if SitMirroredLock == false:
					if SitMirrored == true:
						Sprite.flip_h = true
					else:
						Sprite.flip_h = false
					SitMirroredLock = true
				if SitPointingDown == true:
					Sprite.animation = "Sitting Down"
				else:
					Sprite.animation = "Sitting Right"
			_ when abs(y) > abs(x) and y > 0:
				Sprite.animation = "Walk Down"
				SitPointingDown = true
				Sprite.flip_h = false
				SitMirroredLock = false
			_ when abs(y) > abs(x) and y < 0:
				Sprite.animation = "Walk Up"
				SitPointingDown = false
				Sprite.flip_h = false
				SitMirroredLock = false
			_ when abs(x) > abs(y) and x > 0:
				Sprite.animation = "Walk Right"
				SitPointingDown = false
				Sprite.flip_h = false
				SitMirroredLock = false
			_ when abs(x) > abs(y) and x < 0:
				Sprite.animation = "Walk Left"
				SitPointingDown = false
				Sprite.flip_h = false
				SitMirroredLock = false
	else:
		Sprite.animation = "Sitted Right"

func _frame():
	if SitCommand == false:
		if _tooNear == false:
			if Nav.is_target_reachable() or not Nav.is_navigation_finished():
				Sprite.play()
			else:
				if Sprite.frame >= Sprite.sprite_frames.get_frame_count(Sprite.animation) - 1:
					Sprite.pause()
		else:
			if modes == 0 or modes == 1:
				if Sprite.frame >= Sprite.sprite_frames.get_frame_count(Sprite.animation) - 1:
					Sprite.pause()
			else:
				if not (ArrSize > (Arr+1)):
					if modes == 3:
						if Sprite.frame >= Sprite.sprite_frames.get_frame_count(Sprite.animation) - 1:
							Sprite.pause()
	else:
		Sprite.play()
#endregion
