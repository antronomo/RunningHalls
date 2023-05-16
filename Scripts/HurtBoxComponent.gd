extends Area2D
class_name HurtBoxComponent
#Tiene la estadísitca de defensa

var health_component : HealthComponent

export var deffense : int 

func _ready():
	health_component = get_node("../HealthComponent")


func get_hurt(entring_dmg : float) -> float: 
	var diff : float =  (entring_dmg * 100) / deffense

	return (((diff * entring_dmg) / 100) * -1)
