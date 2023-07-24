extends Node2D


export var my_name : String = 'player'


signal updateHP


func _ready() -> void:
	if get_node('../GUI'):
		connect('updateHP', get_node('../GUI'), 'update_helath_bar')


func seeHP(hp : int) -> void:
	emit_signal('updateHP', hp)

	if hp <= 0:
		going_to_heal()


func going_to_heal() -> void:
	$CoreComponent.set_hp(999999999)


func going_to_die() -> void:
	queue_free()


func _on_CoreComponent_body_entered(body : Enemy) -> void:
	#Esto es cuando el jugador colisiona con un enemigo, para empujar-lo
	# print('empujacion')
	body.apply_central_impulse(Vector2(randi() % 50 + 51, (randi() % 75 + 26) * -1))

