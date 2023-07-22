extends Node2D


export var my_name : String = 'player'


# onready var core_comp : Area2D = $CoreComponent


func seeHP(hp : int) -> void:
	print(my_name + ' life is: ' + str(hp))

	if hp <= 0:
		going_to_heal()


func going_to_heal() -> void:
	$CoreComponent.set_hp(999999999)


func going_to_die() -> void:
	queue_free()


func _on_CoreComponent_body_entered(body : Enemy) -> void:
	#Esto es cuando el jugador colisiona con el cuerpo de un enemigo, para empujar-lo
	# print('empujacion')
	body.apply_central_impulse(Vector2(randi() % 50 + 51, (randi() % 75 + 26) * -1))

