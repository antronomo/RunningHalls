extends Node2D
class_name Equipment


var sprite : Sprite
var sprite_hframes : int
var upgrade_list : Array
var upgrades : int = 0


func _ready() -> void:
	if get_node("Sprite"):
		sprite = $Sprite
	else:
		print(name + " has no sprite node!!!")


func get_sprite_info() -> Array:
	return [sprite.texture, sprite.hframes, sprite.frame]


func upgrade() -> void:
	if !upgrades == upgrade_list.size():
		upgrades += 1
		sprite.frame = int(clamp(upgrades,0,sprite.hframes-1)) # el int() solo está para quitarme un aviso


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