extends Area2D

#Funcionamento
@onready var Sprite = $AnimatedSprite2D
@onready var timer = Timer.new()
@onready var frame = 0

#Controle
@export var semente: int = 3
@export var growDelay: int = 3

func _ready():
	hide()
	add_child(timer)
	timer.wait_time = growDelay
	timer.timeout.connect(_on_Timer_timeout)
	self.body_entered.connect(_on_body_entered)

func _process(_delta):
	Global.seeds = semente

func _on_body_entered(_body):
	if visible == false:
		if semente >= 1:
			semente -= 1
			visible = true
			frame = 0
			Sprite.frame = 0
			timer.start()
		else:
			print("sem sementes")

func _on_Timer_timeout():
	if visible:
		frame += 1
		if frame > 5:
			frame = 0
			visible = false
		else:
			Sprite.frame = frame
		timer.start()
