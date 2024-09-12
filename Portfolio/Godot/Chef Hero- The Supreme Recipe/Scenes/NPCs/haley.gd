extends CharacterBody2D

#Funcionamento
@onready var Sprite = $Sprite
@onready var Nav = $NavigationAgent2D

#Controle
@export var speed: int = 256
@export var frameSpeed: int = 5

#Auxiliar

# Ideias: Pathfinder no Node2D de NPCs, e transmitir via Signals o tamanho do mapa e as suas coordenadas
# Link: https://kidscancode.org/godot_recipes/4.x/2d/grid_pathfinding/index.html
# Link do Vídeo que funcionou mas eu não gostei: https://www.youtube.com/watch?v=AGHtw8__oqw
