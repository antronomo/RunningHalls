extends Node2D


#max_hp por no poner max_life, variable que existe en coreComponent
# onready var max_hp : int = $CoreComponent.get_stats().life


export var my_name : String = 'player'


signal updateHP
signal morido


func _ready() -> void:
	connect('updateHP', get_node('../GUI'), 'update_helath_bar')
	connect('morido', get_node('../'), 'finish_game')


func seeHP(hp : int) -> void:
	emit_signal('updateHP', hp)

	if hp <= 0:
		going_to_die()


func going_to_heal() -> void:
	$CoreComponent.set_hp(999999999)


func going_to_die() -> void:
	emit_signal('morido')
	$AnimationPlayer.play('dying')

func _on_CoreComponent_body_entered(body : Enemy) -> void:
	#Esto es cuando el jugador colisiona con un enemigo, para empujar-lo
	# print('empujacion')
	body.apply_central_impulse(Vector2(randi() % 50 + 51, -randi() % 75 - 26))

