extends AnimatedSprite2D

@onready var Original = get_parent().get_parent()
@onready var Hat: AnimatedSprite2D = self

func _process(_delta):
	match Original.animation:
		"Walk Right":
			Hat.play("Right")
		"Walk Left":
			Hat.play("Left")
		"Walk Up":
			Hat.play("Up")
		"Walk Down":
			Hat.play("Down")
