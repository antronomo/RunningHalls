extends Marker2D


@onready var wave_generator : Node = $WaveGenerator
@onready var timer : Node = $Timer

# Esta variable y la funcion get_wave() son esenciales si no quieres tocar level0.gd
# La variable es utilizada por los enemigos para calcular estadísticas progresivas
@onready var le_wave : int = Globals.current_game.game_info.wave : set = set_lewave, get = get_wave

# Esto es un meme, activable desde el "menu secreto"
@onready var enemies_lock_rotation : bool = Globals.config_data.enemies_lock_rotation


var wave_list : Array
var work : bool = false # Cambiado por Level0 al llegar al game_over


signal generate_loot
signal enemy_died
signal enemy_list_ended
signal hand_defeated
signal increased_wave


func _ready() -> void:
	# Conviene que genere una oleada normal antes del jefe final por si el jugador no ha mejorado al máximo todo
	wave_list = wave_generator.get_new_wave()
	if get_node("../").has_method("_on_EnemySpawner_wave_increased"):
		connect("increased_wave", Callable(get_node("../"), "_on_EnemySpawner_wave_increased"))


func set_lewave(one : int = 1) -> void:
	le_wave += one
	emit_signal("increased_wave", le_wave)


# funcion obsoleta
func get_wave() -> int:
	return le_wave


func spawn_enemies() -> void:
	for i1 in wave_list.size():
		for i2 in wave_list[i1].size():
			timer.start(randf_range(0.05, 0.35)); await timer.timeout
			
			var next_enemy : RigidBody2D = wave_list[i1][i2].instantiate()
			add_child(next_enemy)
			next_enemy.lock_rotation = enemies_lock_rotation
			
			if i1 == 4 or i1 == 6:
				# print("boss time")
				next_enemy.boss_mode()
			
			while !work:
				timer.start(1); await timer.timeout
		
		# print("waiting")
		timer.start(randi_range(1, 2)); await timer.timeout
		set_lewave()
	
	emit_signal("enemy_list_ended")


func _on_enemy_died(enemy_position : Vector2) -> void: # Llamado cuando un hijo "muere"
	emit_signal("generate_loot", enemy_position)
	emit_signal("enemy_died") # Aunque la señal tenga el mismo nombre, este es el que conecta con Level0


func _on_EnemySpawner_enemy_list_ended() -> void:
	while !work:
		timer.start(1); await timer.timeout
	
	if le_wave < 100:
		wave_list = wave_generator.get_new_wave()
		spawn_enemies()
	else:
		wave_list = wave_generator.get_boss()
		#wave_generator.queue_free()
		spawn_enemies()
		work = false


func _on_hand_died() -> void:
	emit_signal("hand_defeated")

