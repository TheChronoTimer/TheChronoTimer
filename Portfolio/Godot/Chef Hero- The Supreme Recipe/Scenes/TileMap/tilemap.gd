extends TileMapLayer

#region Var
#region Funcionamento
@onready var Ground = $Ground
#endregion
#endregion

func _ready():
	for layer in get_children():
		if layer.name != "Ground":
			for tile in layer.get_tiles():
				if tile.has_collision():
					Ground.set_navigation_layer(0, false)
					Ground.set_navigation_layer(1, false)
				else:
					Ground.set_navigation_layer(0, tile.has_collision())
					Ground.set_navigation_layer(1, tile.has_collision())

func _process(_delta):
	pass
