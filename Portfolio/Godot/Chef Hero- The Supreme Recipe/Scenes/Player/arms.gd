extends AnimatedSprite2D

@onready var Original = get_parent()
@onready var Arms: AnimatedSprite2D = self

func _process(_delta):
	match Original.animation:
		"Walk Right":
			Arms.play("Right")
			Arms.flip_h = false
		"Walk Left":
			Arms.play("Left")
			Arms.flip_h = true
		"Walk Up":
			Arms.play("Up")
			Arms.flip_h = false
		"Walk Down":
			Arms.play("Down")
			Arms.flip_h = false
	
	Arms.frame = Original.frame
