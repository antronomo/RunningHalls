extends Position2D


onready var enemy_list_node : Node = $EnemyListNode

# Esta variable y la funcion get_wave() son esenciales si no quieres tocar level0.gd
# La variable es utilizada por los enemigos para calcular estadísticas progresivas
onready var le_wave : int = Globals.current_game.game_info.wave


var wave_list : Array


signal generate_loot
signal wave_ended
signal enemy_list_ended


func _ready() -> void:
	wave_generator(enemy_list_node.get_enemy_group())


func get_wave() -> int:
	return le_wave


func wave_generator(enemy_list : Array) -> void:
	var wave_num : int = randi() % 3 + 5

	wave_list = [
		[enemy_list[0]],
		[enemy_list[0], enemy_list[0]],
		[enemy_list[0], enemy_list[1], enemy_list[1]],
		[enemy_list[1], enemy_list[2], enemy_list[2]],
		[enemy_list[2]]
	]

	if wave_num >= 6:
		wave_list.append_array([[enemy_list[0], enemy_list[1], enemy_list[2], enemy_list[2]]])

		if wave_num == 7:
			wave_list.append_array([[enemy_list[randi() % 3]]])

	# print(str(wave_num), str(wave_list)) 


func spawn_enemies() -> void: 
	for i1 in wave_list.size():
		for i2 in wave_list[i1].size():
			var next_enemy : RigidBody2D = wave_list[i1][i2].instance()
			yield(get_tree().create_timer(randf() * 0.75 + 0.25), "timeout")
			# next_enemy.set_wave(le_wave)
			add_child(next_enemy)

			if i1 == 4 or i1 == 6:
				# print("boss time")
				next_enemy.boss_mode()
			
			# print(str(i1))
		
		# print("waiting")
		yield(self, "wave_ended")

	# print("spawn_enemies ended")
	emit_signal("enemy_list_ended")


func end_wave(enemy_position : Vector2) -> void: # Llamado cuando un hijo "muere"
	yield(get_tree().create_timer(0.01), "timeout") # Si lo borras/comentas, da error

	emit_signal("generate_loot", enemy_position)

	if get_child_count() == 1:
		# spawn_enemies()
		le_wave += 1
		emit_signal("wave_ended")


func _on_EnemySpawner_wave_ended() -> void:
	return


func _on_EnemySpawner_enemy_list_ended() -> void:
	wave_generator(enemy_list_node.get_enemy_group())
	spawn_enemies()


"""
Lo que quiero conseguir es lo siguiente:
Una manera de que aparezcan los enemigos en oleadas.

Ideas:
·Los enemigos deben tener mejores estadísticas confomre tenga más rondas, al menos, en hp


COMPLETADO:
·la ronda se da como finalizada cuando todos los enemigos han sido derrotados.

·los enemigos deben aparecer uno detrás de otro rápido, pero no a la vez


DESCARTADO:
·¿los tokens no usados se guardan para la próxima ronda?

·cada ronda aumentará el numero de tokens que el spawner tendrá.

·Usar un sistema de tokens, asignar cada enemigo un valor y que el spawner compre enemigos asta acercarse a 0 tokens.

"""
