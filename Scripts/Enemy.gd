class_name Enemy
extends RigidBody2D


export var my_name : String


onready var health_bar : HealthBar = get_node("HealthBar")
onready var core_compo : CoreComponent = $CoreComponent
onready var anim_sprite : AnimatedSprite = $AnimatedSprite


var stats : Dictionary
var im_boss : bool = false
# var current_wave : int


var dict_status : Dictionary = {
	"low_life" : false
}


signal died


func _ready() -> void:
	mode = 2
	connect("died", get_node("../"), "_on_enemy_died")
	set_up_health_bar()


func set_up_health_bar() -> void: 
	stats = $CoreComponent.get_stats()
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
	if !im_boss:
		# print(my_name + " is comming big")
		# scale = Vector2(2,2)  # Funciona pero solo dura un frame?
		anim_sprite.position = Vector2(8, -16)
		anim_sprite.scale = Vector2(2, 2)
		health_bar.rect_position = Vector2(-8, -48)
		health_bar.rect_scale = Vector2(2, 2)
		core_compo.boss_buff()
		im_boss = true

		set_up_health_bar()


# Esta función se usa en los escrips heredados de este
func update_status(status : String, value : bool) -> void: pass 
	

# func set_wave(new_wave : int) -> void:
# 	current_wave = new_wave


func hecking_die() -> void:
	emit_signal("died", global_position)
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
