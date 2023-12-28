extends RigidBody2D
class_name Enemy


export var my_name : String


onready var health_bar : HealthBar = get_node('HealthBar')


var stats : Dictionary
var low_life_status : bool = false


signal died


func _ready() -> void:
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


"""
La variable low_life_status solo puede ser cambiado por nodos heredados de este,
ya que es CoreComponent (otro nodo como nodo hijo) quien manda la señal para cmabiar a true/false.


PARA MONTAR NUEVOS ENEMIGOS: Como no se automatizar eso, me toca hacer-lo a mano:
	-nueva escena con Enemy de base y atar un script heredado con su nombre, ajustar colision 3 y mascara 1
	-añadir una colision redondo como hijo centrar la colision de manera que la parte mas baja esté en y0
	-añadir CoreComponent como hijo, atar el escript EnemyStats.gd, poner sus estadisticas y ajustar colision 3 y mascara 2
	-conectar la señal de CoreComponent AreaEntered con CoreComponent
	-añadir y ajustar el nodo HealthBar como nodo hijo
"""