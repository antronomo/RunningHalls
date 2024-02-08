extends Node2D


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
	$CoreComponent.set_hp(999999999)


func update_status(status : String, value : bool) -> void: pass 


func _on_CoreComponent_body_entered(body : Enemy) -> void:
	#Esto es cuando el jugador colisiona con un enemigo, para empujar-lo
	# print('empujacion')
	body.apply_central_impulse(Vector2(randi() % 50 + 51, - randi() % 75 - 26))


func going_to_die() -> void:
	$AnimationPlayer.play('dying')
	emit_signal('morido')
