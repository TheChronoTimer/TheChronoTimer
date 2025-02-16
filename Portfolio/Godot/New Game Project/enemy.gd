extends CharacterBody2D

#Funcionamento
@onready var Nav = $NavigationAgent2D
@onready var TimerClock = $Timer

#Controle
@export var speed: int = 100
@export var player: Node2D
@export var limit: float = 0.001

func _physics_process(_delta):
	var dir = to_local(Nav.get_next_path_position()).normalized()
	velocity = dir * speed
	move_and_slide()
	if Nav.is_navigation_finished():
		return

func _ready():
	TimerClock.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	Nav.target_position = player.global_position
