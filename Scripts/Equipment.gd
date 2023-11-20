extends Node2D
class_name Equipment


onready var sprite : Sprite = $Sprite


var max_upgrades : int
var sprite_hframes : int
var upgrade_list : Array
var upgrades : int = 0


func get_item_stats() -> Dictionary:
	return {
		"level" : upgrades,
		"price" : upgrade_list[upgrades][0],
		"stat" : upgrade_list[upgrades][1]
	}


func get_sprite_info() -> Array:
	return [sprite.texture, sprite.hframes, sprite.frame]


func upgrade() -> void:
	if upgrades < max_upgrades:
		upgrades += 1
		sprite.frame = int(clamp(upgrades,0,sprite.hframes-1)) # el int() solo está para quitar un aviso


"""
Esto es el corazón que utilizaré para crear las piezas de armadura, espada y escudo.
necesito como variables:
	-lista con los precios/estat (ya sea defensa o ataque)
	-sprite(s)
	?--lsita de mejoras por encantamiento, vea ideas.txt para más

funciones:
	-para devolver los valores de la siguiente mejora o de que está al máximo
	-para devolver el valor de la estadística ACTUAL
	?--numero de mejoras necesario para cambiar la apariencia y función para manejar eso
"""
