class_name Enemy
extends RigidBody2D


@export var my_name : String


@onready var health_bar : HealthBar = get_node("HealthBar")
@onready var core_compo : CoreComponent = $CoreComponent
@onready var anim_sprite : AnimatedSprite2D = $AnimatedSprite2D


var stats : Dictionary
var im_boss : bool = false
# var current_wave : int


var dict_status : Dictionary = {
	"low_life" : false
}


signal died


func _ready() -> void:
	#lock_rotation = true
	connect("died", Callable(get_node("../"), "_on_enemy_died"))
	set_up_health_bar()


func set_up_health_bar() -> void: 
	stats = core_compo.get_stats()
	if health_bar:
		health_bar.max_value = stats.life
		health_bar.value = stats.life
	else:
		print(my_name + " does not have a healthbar")


func seeHP(hp : int) -> void:
	# print(my_name + " life is: " + str(hp))
	health_bar.value = hp

	if hp <= 0:
		hecking_die()


func boss_mode() -> void:
	#printerr("la función 'boss_mode' no ha sido modificado aún")
	if !im_boss:
		# print(my_name + " is comming big")
		# scale = Vector2(2,2)  # Funciona pero solo dura un frame?
		anim_sprite.position = Vector2(8, -16)
		anim_sprite.scale += Vector2(2, 2)
		health_bar.position *= Vector2(-0.25, 3)
		health_bar.scale += Vector2(2, 2)
		core_compo.boss_buff()
		im_boss = true

		set_up_health_bar()


# Esta función se usa en los escrips heredados de este
func update_status(status : String, value : bool) -> void: pass 


func hecking_die() -> void:
	emit_signal("died", global_position)
	queue_free()


"""
La variable low_life_status solo puede ser cambiado por nodos heredados de este,
ya que es CoreComponent (otro nodo como nodo hijo) quien manda la señal para cmabiar el valor.


PARA MONTAR NUEVOS ENEMIGOS: Como no se automatizar eso, me toca hacer-lo a mano:
	-nueva escena con Enemy de base y atar un script heredado con su nombre, ajustar colision 3 y mascara 1
	-añadir una colision redondo como hijo, centrar la colision de manera que la parte mas baja esté en y0
	-añadir CoreComponent como hijo, atar el escript EnemyStats.gd, poner sus estadisticas y ajustar colision 3 y mascara 2
	-conectar la señal de CoreComponent > AreaEntered con CoreComponent
	-añadir y ajustar el nodo HealthBar como nodo hijo
"""
