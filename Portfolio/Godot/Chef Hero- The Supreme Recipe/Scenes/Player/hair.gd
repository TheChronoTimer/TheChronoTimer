extends AnimatedSprite2D

@onready var Original = get_parent()
@onready var Hair: AnimatedSprite2D = self

func _ready():
	Hair.self_modulate = Color(0.6, 0.3, 0.1)

func _process(_delta):
	match Original.animation:
		"Walk Right":
			Hair.play("Right")
			Hair.flip_h = false
		"Walk Left":
			Hair.play("Left")
			Hair.flip_h = true
		"Walk Up":
			Hair.play("Up")
			Hair.flip_h = false
		"Walk Down":
			Hair.play("Down")
			Hair.flip_h = false
	
	if Original.frame % 2:
		Hair.position.y = 1
	else:
		Hair.position.y = 0
