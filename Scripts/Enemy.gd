extends RigidBody2D
class_name Enemy


export var my_name : String


# onready var core_comp : Area2D = $CoreComponent
onready var healthBar : HealthBar = get_node("HealthBar")


var stats : Dictionary


func _ready() -> void:
	# var giga : int = randi() % 100 + 1
	# if giga == 1:
	# 	print('a '+ my_name +' is the chosen one')

	stats = $CoreComponent.get_stats()
	if healthBar:
		healthBar.max_value = stats.life
		healthBar.value = stats.life
	else:
		print(my_name + ' dont have a healthbar')


func seeHP(hp : int) -> void:
	print(my_name + ' life is: ' + str(hp))

	healthBar.value = hp

	if hp <= 0:
		hecking_die()


func hecking_die() -> void:
	queue_free()
