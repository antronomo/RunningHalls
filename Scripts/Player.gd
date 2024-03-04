extends Node2D


@onready var core_component : CoreComponent = $CoreComponent
@onready var anim_player : AnimationPlayer = $AnimationPlayer


@export var my_name : String = 'player'


var dict_status : Dictionary = {
	"low_life" : false
}


signal updateHP
signal morido


func _ready() -> void:
	connect('updateHP', Callable(get_node('../GUI'), 'update_helath_bar'))
	connect('morido', Callable(get_node('../'), 'finish_game'))


func seeHP(hp : int) -> void:
	emit_signal('updateHP', hp)

	if hp <= 0:
		going_to_die()


func going_to_heal() -> void:
	core_component.set_hp(999999999)


func update_status(status : String, value : bool) -> void: pass 


func _on_CoreComponent_body_entered(body : Enemy) -> void:
	#Esto es cuando el jugador colisiona con un enemigo, para empujar-lo
	# print('empujacion')
	body.apply_central_impulse(Vector2(randi() % 100 + 51, - randi() % 175 - 126))


func going_to_die() -> void:
	anim_player.play('dying')
	emit_signal('morido')
