extends Area2D
class_name HitBoxComponent
#Tiene la estadísitca de defensa

export var deffense : int 

onready var health_component : HealthComponent = get_node("../HealthComponent")

func _ready() -> void: pass


func get_hurt(entring_dmg : float) -> float: 
	var diff : float =  (entring_dmg * 100) / deffense

	return (((diff * entring_dmg) / 100) * -1)