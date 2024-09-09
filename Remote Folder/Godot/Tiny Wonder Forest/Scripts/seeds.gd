extends Label

func _ready():
	pass

func _process(_delta):
	text = "Seeds: " + str(Global.seeds)
