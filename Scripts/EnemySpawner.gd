extends Position2D


const dark_wizard : PackedScene = preload("res://Enemies/DarkWizard.tscn")
const humacean : PackedScene = preload("res://Enemies/Humacean.tscn")
const ghost : PackedScene = preload("res://Enemies/Ghost.tscn")


var token : int = 1
var wave : int = 1


signal generate_loot


var spawn_list : Array = [
	[dark_wizard,	1],
	[humacean	,	5],
	[ghost		,	7]
]


func buy_enemies() -> Array:
	var list : Array = []

	while token > 0:
		var num = randi() % spawn_list.size()

		while spawn_list[num][1] > token:
			num -= 1

			if token <= 0:
				# print('woa romper')
				break

		token -= spawn_list[num][1]
		# print(str(token))
		list.insert(list.size(), spawn_list[num][0])

	list.sort()
	# print(str(list))
	return list


func spawn_enemies() -> void: 
	var last_enemy : RigidBody2D
	var list : Array = buy_enemies()

	print('invocando ' + str(list.size()) + ' malos malosos.')

	for i in list:
		var new_enemy : RigidBody2D = i.instance()

		if last_enemy != null:
			if new_enemy.my_name != last_enemy.my_name:
				yield(get_tree().create_timer(1.0), 'timeout') # Si dejo tiempos mas grandes, podría hacerlo pasar por oleadas
			else:
				yield(get_tree().create_timer(randi() % (30 + 20) / 100.0 ), 'timeout')

		add_child(new_enemy)
		last_enemy = new_enemy


# No quiero que repita la suseción cada vez que quiera tener un número de tokens, igual debería guardar los numeros anteriores y simplemente devolver el siguiente
func token_manager() -> void: # Simulacion de fibonacci
	var a : int = 1
	var b : int = 1
	var return_a : bool = true

	for i in wave:
		if return_a:
			a += b
			return_a = !return_a
		else:
			b += a
			return_a = !return_a

	if return_a:
		token = a
	else:
		token = b

	print('oleada: ' + str(wave))
	print('token aviable: ' + str(token))


func end_wave(enemy_position : Vector2) -> void: # Llamado cuando un hijo 'muere'
	yield(get_tree().create_timer(0.01), 'timeout') # Si lo borras/comentas, da error

	emit_signal("generate_loot", enemy_position)

	if get_child_count() == 0:
		wave += 1
		token_manager()
		spawn_enemies()

"""
Lo que quiero conseguir es lo siguiente:
Una manera de que aparezcan los enemigos en oleadas.

Ideas:
·Usar un sistema de tokens, asignar cada enemigo un valor y que el spawner compre enemigos asta acercarse a 0 tokens.

·cada ronda aumentará el numero de tokens que el spawner tendrá.

·la ronda se da como finalizada cuando todos los enemigos han sido derrotados o si pasa demasiado tiempo.

·los enemigos deben aparecer uno detrás de otro rápido, pero no a la vez, podría hacer falta hacer subgrupos si aparecen distintos enemigos.

·podría el spawner elegir 1 solo enemigo y que aparezcan tantos enemigos iguales como tokens tenga disponible.

·¿los tokens no usados se guardan para la próxima ronda?

·Impedir que enemigos más débiles aparezcan en oleadas altas, sino podria hacer aparecer demasiados enemigos en una oleada, aunque puede ser interesante.

·Los enemigos deben tener mejores estadísticas confomre tenga más rondas, al menos, en hp
"""
