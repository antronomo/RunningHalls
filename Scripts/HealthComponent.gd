extends Node2D
class_name HealthComponent
#Tiene la estadísitca de vida

signal NoHP

export var max_life : int

var life : int = 0 setget set_hp, get_hp

func _ready() -> void:
	life = max_life

func set_hp(new_hp : int) -> void:

	life += new_hp

	life = clamp(life, 0, max_life)

	if life <= 0:
		emit_signal("NoHP")

func get_hp() -> int:
	return life

#Para cuando vaya a recibir daño
func get_hurt(): pass

#Para cuando se vaya a curar, este igual sobra, ya veremos
func get_healed(): pass


