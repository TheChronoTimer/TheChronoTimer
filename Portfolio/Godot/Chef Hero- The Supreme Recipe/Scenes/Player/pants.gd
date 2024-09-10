extends AnimatedSprite2D

@onready var Original = get_parent()
@onready var Pants: AnimatedSprite2D = self

func _process(_delta):
	match Original.animation:
		"Walk Right":
			Pants.play("Right")
			Pants.flip_h = false
		"Walk Left":
			Pants.play("Left")
			Pants.flip_h = true
		"Walk Up":
			Pants.play("Up")
			Pants.flip_h = false
		"Walk Down":
			Pants.play("Down")
			Pants.flip_h = false
	
	Pants.frame = Original.frame
