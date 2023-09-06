extends RigidBody2D
class_name Enemy


export var my_name : String


onready var health_bar : HealthBar = get_node('HealthBar')


var stats : Dictionary


signal died


func _ready() -> void:
	# var giga : int = randi() % 100 + 1
	# if giga == 1:
	# 	print('a '+ my_name +' is the chosen one')
	connect('died', get_node('../'), 'end_wave')

	stats = $CoreComponent.get_stats()
	if health_bar:
		health_bar.max_value = stats.life
		health_bar.value = stats.life
	else:
		print(my_name + ' does not have a healthbar')


func seeHP(hp : int) -> void:
	# print(my_name + ' life is: ' + str(hp))

	health_bar.value = hp

	if hp <= 0:
		hecking_die()


func hecking_die() -> void:
	emit_signal('died', global_position)
	queue_free()
