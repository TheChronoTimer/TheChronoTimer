extends AnimatedSprite2D

@onready var Original = get_parent()
@onready var Coat: AnimatedSprite2D = self
@onready var PosSelf = self.position.y

func _process(_delta):
	match Original.animation:
		"Walk Right":
			Coat.play("Right")
			Coat.position.x = -1
		"Walk Left":
			Coat.play("Left")
			Coat.position.x = 1
		"Walk Up":
			Coat.play("Up")
			Coat.position.x = 0
		"Walk Down":
			Coat.play("Down")
			Coat.position.x = 0
	
	if Original.frame % 2:
		Coat.position.y = PosSelf+1
	else:
		Coat.position.y = PosSelf
