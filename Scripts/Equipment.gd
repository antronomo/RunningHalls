extends Node2D
class_name Equipment


onready var sprite : Sprite = $Sprite


var max_upgrades : int
var sprite_hframes : int
var upgrade_list : Array
var upgrades : int


func get_item_stats(a_num : int = 0) -> Dictionary:
	var another_num : int = upgrades + a_num
	return {
		"level" : another_num,
		"price" : upgrade_list[another_num][0],
		"stat" : upgrade_list[another_num][1],
		"max_upgrades" : max_upgrades
	}


func get_sprite_info() -> Dictionary:
	return {
		"texture" : sprite.texture, 
		"hframes" : sprite.hframes, 
		"frame" : sprite.frame
	}


func upgrade() -> void:
	if upgrades < max_upgrades:
		upgrades += 1
		sprite.frame = int(clamp(upgrades,0,sprite.hframes-1)) # el int() solo está para quitar un aviso


"""
Esto es el corazón que utilizaré para crear las piezas de armadura, espada y escudo.
necesito como variables:
	-lista con los precios/estat
	-sprite(s)
	?-lsita de mejoras por encantamiento, vea ideas.txt para más

funciones:
	*-para devolver los valores de la siguiente mejora o de que está al máximo
	*-para devolver el valor de la estadística ACTUAL
	?-numero de mejoras necesario para cambiar la apariencia y función para manejar eso
"""
