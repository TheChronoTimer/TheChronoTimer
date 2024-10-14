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
@export var modes: Modes = Modes.Stop
@export var target: Node2D = null
@export var coords: Array[Vector2] = []
@export var tileSize: int = 16
@export var mainScale: float = 4
@export var pixelDistance: int = 0
@export var distanceLimit: int = 0
#endregion

#region Auxiliar
var vert = 0
var horiz = 0
var dir = Vector2.ZERO
var desloc = tileSize * mainScale
var ArrSize = 0
var Arr = 0
var _tooNear = true
var pixelEdge = pixelDistance
var SitPointingDown = false
var SitMirrored = false
var SitMirroredLock = false
var SitCommand = false
var oldModesState = Modes.Stop
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
#endregion

#region Signal
func _on_timer_timeout():
	match modes:
		Modes.FollowTarget, Modes.FollowPlayer:
			Nav.target_position = target.global_position
		Modes.FollowCoords, Modes.FollowCoordsAndStop:
			Nav.target_position = coords[Arr]
		Modes.Stop:
			Nav.target_position = self.global_position
#endregion

#region Func
func _walk():
	
	match modes:
		Modes.FollowTarget, Modes.FollowPlayer:
			if modes == Modes.FollowPlayer:
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
		Modes.FollowCoords, Modes.FollowCoordsAndStop:
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
		modes = Modes.Stop
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
		if not (modes == Modes.FollowTarget or modes == Modes.FollowPlayer):
			if ArrSize > (Arr+1):
				Arr += 1
			else:
				if modes == Modes.FollowCoords:
					Arr = 0

func _animation():

	# Animação de sentar 1x (animação direcional):
	# - Se direita: "Sitting Right"
	# - Se esquerda: "Sitting Right" + espelhado
	# - Se baixo: "Sitting Down"
	# - Se cima: "Sitting Right" + espelhado (se mais próximo de esquerda do que direita)
	# Animação parada (animação direcional):
	# - Se direita: "Sitted Right"
	# - Se esquerda: "Sitted Right" + espelhado
	# - Se baixo: Não existe, é o último frame da animação "Sitting Down", e precisa ficar congelado nesse frame
	# - Se cima: "Sitted Right" + espelhado (se mais próximo de esquerda do que direita)
	# Animação de andar (animação direcional):
	# - Se direita: "Walk Right"
	# - Se esquerda: "Walk Left"
	# - Se baixo: "Walk Down"
	# - Se cima: "Walk Up"



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
					if Sprite.animation != "Sitting Down":
						Sprite.animation = "Sitting Down"
					elif Sprite.animation == "Sitting Down" and Sprite.frame == Sprite.sprite_frames.get_frame_count("Sitting Down") - 1:
						Sprite.pause()
				else:
					if Sprite.animation != "Sitting Right" and Sprite.animation != "Sitted Right":
						Sprite.animation = "Sitting Right"
					elif Sprite.animation == "Sitting Right" and Sprite.frame == Sprite.sprite_frames.get_frame_count("Sitting Right") - 1:
						Sprite.animation = "Sitted Right"
				
				if _tooNear:
					if modes in [Modes.FollowTarget, Modes.FollowPlayer]:
						if Sprite.frame >= Sprite.sprite_frames.get_frame_count(Sprite.animation) - 1:
							Sprite.pause()
					elif modes == Modes.FollowCoordsAndStop and not (ArrSize > (Arr+1)):
						if Sprite.frame >= Sprite.sprite_frames.get_frame_count(Sprite.animation) - 1:
							Sprite.pause()
				else:
					if Nav.is_target_reachable() or not Nav.is_navigation_finished():
						Sprite.play()
					elif Sprite.frame >= Sprite.sprite_frames.get_frame_count(Sprite.animation) - 1:
						Sprite.pause()
			
			_ when abs(y) > abs(x) and y > 0:
				Sprite.animation = "Walk Down"
				SitPointingDown = true
				Sprite.flip_h = false
				SitMirroredLock = false
				Sprite.play()
			_ when abs(y) > abs(x) and y < 0:
				Sprite.animation = "Walk Up"
				SitPointingDown = false
				Sprite.flip_h = false
				SitMirroredLock = false
				Sprite.play()
			_ when abs(x) > abs(y) and x > 0:
				Sprite.animation = "Walk Right"
				SitPointingDown = false
				Sprite.flip_h = false
				SitMirroredLock = false
				Sprite.play()
			_ when abs(x) > abs(y) and x < 0:
				Sprite.animation = "Walk Left"
				SitPointingDown = false
				Sprite.flip_h = false
				SitMirroredLock = false
				Sprite.play()
	else:
		Sprite.animation = "Sitted Right"
		Sprite.play()

#endregion
