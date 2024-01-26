extends Position2D


onready var enemy_list_node : Node = $EnemyListNode
onready var timer : Node = $Timer

# Esta variable y la funcion get_wave() son esenciales si no quieres tocar level0.gd
# La variable es utilizada por los enemigos para calcular estadísticas progresivas
onready var le_wave : int = Globals.current_game.game_info.wave


var wave_list : Array
var work : bool = true # Cambiado por Level0 al llegar al game_over


signal generate_loot
signal enemy_died
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
	# Revisar que la partida no ha acabado
	if !work: 
		return

	for i1 in wave_list.size():
		for i2 in wave_list[i1].size():
			timer.start(randf() * 0.80 + 0.20); yield(timer, "timeout")

			var next_enemy : RigidBody2D = wave_list[i1][i2].instance()
			add_child(next_enemy)

			if i1 == 4 or i1 == 6:
				# print("boss time")
				next_enemy.boss_mode()
		
		# print("waiting")
		timer.start(randi() % 4 + 2); yield(timer, "timeout")
		le_wave += 1

	emit_signal("enemy_list_ended")


func _on_enemy_died(enemy_position : Vector2) -> void: # Llamado cuando un hijo "muere"
	emit_signal("generate_loot", enemy_position)
	emit_signal("enemy_died") # Aunque la señal tenga el mismo nombre, este es el que conecta con Level0


func _on_EnemySpawner_enemy_list_ended() -> void:
	# Generar lista de enemigos y empezar a invocar-los
	wave_generator(enemy_list_node.get_enemy_group())
	spawn_enemies()
