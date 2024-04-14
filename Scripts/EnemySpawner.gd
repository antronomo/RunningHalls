extends Marker2D


@onready var wave_generator : Node = $WaveGenerator
@onready var timer : Node = $Timer

# Esta variable y la funcion get_wave() son esenciales si no quieres tocar level0.gd
# La variable es utilizada por los enemigos para calcular estadísticas progresivas
@onready var le_wave : int = Globals.current_game.game_info.wave

# Esto es un meme
@onready var enemies_lock_rotation : bool = Globals.config_data.enemies_lock_rotation


var wave_list : Array
var work : bool = true # Cambiado por Level0 al llegar al game_over


signal generate_loot
signal enemy_died
signal enemy_list_ended
signal hand_defeated


func _ready() -> void:
	# Conviene que genere una oleada normal antes del jefe final por si el jugador no ha mejorado al máximo todo
	wave_list = wave_generator.get_new_wave()
	#wave_list = wave_generator.get_boss()


func get_wave() -> int:
	return le_wave


func spawn_enemies() -> void:
	# Revisar que la partida no ha acabado
	if not work: 
		return

	for i1 in wave_list.size():
		for i2 in wave_list[i1].size():
			timer.start(randf() * 0.80 + 0.20); await timer.timeout
			
			var next_enemy : RigidBody2D = wave_list[i1][i2].instantiate()
			add_child(next_enemy)
			next_enemy.lock_rotation = enemies_lock_rotation
			
			if i1 == 4 or i1 == 6:
				# print("boss time")
				next_enemy.boss_mode()
		
		# print("waiting")
		timer.start(randi() % 4 + 2); await timer.timeout
		le_wave += 1

	emit_signal("enemy_list_ended")


func _on_enemy_died(enemy_position : Vector2) -> void: # Llamado cuando un hijo "muere"
	emit_signal("generate_loot", enemy_position)
	emit_signal("enemy_died") # Aunque la señal tenga el mismo nombre, este es el que conecta con Level0


func _on_EnemySpawner_enemy_list_ended() -> void:
	# Generar lista de enemigos y empezar a invocar-los
	if le_wave < 100:
		wave_list = wave_generator.get_new_wave()
		spawn_enemies()
	else:
		if work:
			wave_list = wave_generator.get_boss()
			#wave_generator.queue_free()
			spawn_enemies()
			work = false


func _on_hand_died() -> void:
	emit_signal("hand_defeated")
