extends AnimatedSprite2D

@onready var Original = get_parent()
@onready var Hat: AnimatedSprite2D = self

func _process(_delta):
	if Original.animation == "Walk Right":
		Hat.play("Right")
		Hat.position.x = -1
	if Original.animation == "Walk Left":
		Hat.play("Left")
		Hat.position.x = 1
	if Original.animation == "Walk Up":
		Hat.play("Up")
		Hat.position.x = 0
	if Original.animation == "Walk Down":
		Hat.play("Down")
		Hat.position.x = 0
	
	if Original.frame % 2:
		Hat.position.y = -11
	else:
		Hat.position.y = -12
