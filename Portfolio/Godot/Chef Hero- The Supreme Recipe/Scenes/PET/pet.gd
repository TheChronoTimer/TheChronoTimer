extends CharacterBody2D

#region Var
#region Funcionamento
@onready var Sprite = $Sprite
@onready var Nav = $NavigationAgent2D
@onready var TimerClock = $Timer
@onready var Player = $"/root/Main/Player"

# Enumeração dos modos de movimento do personagem
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
# Variáveis exportadas para controle do personagem
@export var speed: int = 128 # Velocidade de movimento
@export var frameSpeed: int = 5 # Velocidade de animação
@export var modes: Modes = Modes.Stop # Modo de movimento inicial
@export var target: Node2D = null # Alvo a seguir
@export var coords: Array[Vector2] = [] # Coordenadas a seguir
@export var tileSize: int = 16 # Tamanho do tile
@export var mainScale: float = 4 # Escala principal
@export var pixelDistance: int = 0 # Distância em pixels
@export var distanceLimit: int = 0 # Limite de distância
@export var runDistance: int = 200 # Distância para começar a correr
@export var runAllowed: bool = true # Permite a corrida
#endregion

#region Auxiliar
# Variáveis auxiliares para cálculos e controle
var dir = Vector2.ZERO # Direção do movimento
var desloc = tileSize * mainScale # Deslocamento baseado no tamanho do tile e escala
var ArrSize = 0 # Tamanho do array de coordenadas
var Arr = 0 # Índice atual no array de coordenadas
var _tooNear = true # Indica se está muito perto do alvo
var pixelEdge = pixelDistance # Margem de pixels para considerar "perto"
var SitPointingDown = false # Indica se está sentado apontando para baixo
var SitMirrored = false # Indica se a animação de sentar deve ser espelhada
var SitMirroredLock = false # Trava para evitar mudanças constantes no espelhamento
var SitCommand = false # Comando para sentar
var currentSpeed: int = speed # Velocidade atual
var backupSpeed: int = speed # Backup da velocidade normal
#endregion
#endregion

#region Start
func _ready():
	# Conecta o sinal de timeout do timer à função correspondente
	TimerClock.timeout.connect(_on_timer_timeout)
	# Inicializa o tamanho do array de coordenadas
	ArrSize = coords.size()
	# Ajusta as coordenadas com base no deslocamento
	for i in ArrSize:
		coords[i] *= desloc

func _physics_process(_delta):
	# Chama a função de movimento a cada frame físico
	_walk()

func _process(_delta):
	# Chama a função de animação a cada frame
	_animation()
#endregion

#region Signal
# Função chamada quando o timer expira. Define a posição alvo do agente de navegação com base no modo atual.
func _on_timer_timeout():
	match modes:
		Modes.FollowTarget, Modes.FollowPlayer:
			Nav.target_position = target.global_position
		Modes.FollowCoords, Modes.FollowCoordsAndStop:
			Nav.target_position = coords[Arr]
		Modes.Stop, Modes.Sleep:
			Nav.target_position = self.global_position
#endregion

#region Func
# Função que controla o movimento do personagem com base no modo atual e na posição do alvo.
func _walk():
	var vert: float
	var horiz: float
	var distance: float
	
	match modes:
		Modes.FollowTarget, Modes.FollowPlayer:
			if modes == Modes.FollowPlayer:
				target = Player
			vert = abs(target.global_position.y - self.global_position.y)
			horiz = abs(target.global_position.x - self.global_position.x)
			distance = self.global_position.distance_to(target.global_position)
			if vert >= desloc+pixelEdge or horiz >= desloc+pixelEdge:
				_tooNear = false
			else:
				_tooNear = true
			SitMirrored = (target.global_position.x - self.global_position.x) <= 0
		Modes.FollowCoords, Modes.FollowCoordsAndStop:
			vert = abs(coords[Arr].y - self.global_position.y)
			horiz = abs(coords[Arr].x - self.global_position.x)
			distance = self.global_position.distance_to(coords[Arr])
			if vert > tileSize+pixelEdge or horiz > tileSize+pixelEdge:
				_tooNear = false
			else:
				_tooNear = true
			SitMirrored = (coords[Arr].x - self.global_position.x) <= 0

	if not _tooNear:
		# Calcula a direção e velocidade do movimento
		dir = to_local(Nav.get_next_path_position()).normalized()
		if runAllowed and distance > runDistance and abs(dir.x) > abs(dir.y):
			currentSpeed = backupSpeed * 2
		else:
			currentSpeed = backupSpeed
		velocity = dir * currentSpeed
		if Nav.is_target_reachable() or not Nav.is_navigation_finished():
			move_and_slide()
		pixelEdge = pixelDistance
	else:
		# Para o movimento quando está perto do alvo
		velocity = Vector2.ZERO
		pixelEdge = (distanceLimit*mainScale)+pixelDistance
		if not (modes == Modes.FollowTarget or modes == Modes.FollowPlayer):
			if ArrSize > (Arr+1):
				Arr += 1
			elif modes == Modes.FollowCoords:
				Arr = 0

# Função que controla as animações do personagem com base na velocidade e direção do movimento.
func _animation():
	Sprite.speed_scale = frameSpeed
	var x = velocity.x
	var y = velocity.y

	if not SitCommand:
		match velocity:
			_ when x == 0 and y == 0:
				# Animação de sentar quando parado
				if not SitMirroredLock:
					Sprite.flip_h = SitMirrored
					SitMirroredLock = true
				_sitting()
			
			_ when abs(y) > abs(x) and y > 0:
				# Animação de andar para baixo
				Sprite.animation = "Walk Down"
				SitPointingDown = true
				Sprite.flip_h = false
				SitMirroredLock = false
				Sprite.play()
			_ when abs(y) > abs(x) and y < 0:
				# Animação de andar para cima
				Sprite.animation = "Walk Up"
				SitPointingDown = false
				Sprite.flip_h = false
				SitMirroredLock = false
				Sprite.play()
			_ when abs(x) > abs(y) and x > 0:
				# Animação de andar/correr para a direita
				if runAllowed and currentSpeed > backupSpeed:
					Sprite.animation = "Run Right"
				else:
					Sprite.animation = "Walk Right"
				SitPointingDown = false
				Sprite.flip_h = false
				SitMirroredLock = false
				Sprite.play()
			_ when abs(x) > abs(y) and x < 0:
				# Animação de andar/correr para a esquerda
				if runAllowed and currentSpeed > backupSpeed:
					Sprite.animation = "Run Right"
				else:
					Sprite.animation = "Walk Left"
				SitPointingDown = false
				Sprite.flip_h = true if runAllowed and currentSpeed > backupSpeed else false
				SitMirroredLock = false
				Sprite.play()
	else:
		# Animação de sentar quando recebe o comando
		if not SitMirroredLock:
			Sprite.flip_h = SitMirrored
			SitMirroredLock = true
		_sitting()

# Função auxiliar para controlar a animação de sentar
func _sitting():
	if SitPointingDown:
		if Sprite.animation != "Sitting Down":
			Sprite.animation = "Sitting Down"
			Sprite.play()
		elif Sprite.animation == "Sitting Down":
			if Sprite.frame < Sprite.sprite_frames.get_frame_count("Sitting Down") - 1:
				Sprite.play()
			else:
				Sprite.stop()
				Sprite.frame = Sprite.sprite_frames.get_frame_count("Sitting Down") - 1
	else:
		if Sprite.animation != "Sitting Right" and Sprite.animation != "Sitted Right":
			Sprite.animation = "Sitting Right"
			Sprite.play()
		elif Sprite.animation == "Sitting Right" and Sprite.frame == Sprite.sprite_frames.get_frame_count("Sitting Right") - 1:
			Sprite.animation = "Sitted Right"
			Sprite.play()
#endregion
