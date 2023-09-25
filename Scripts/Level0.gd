extends Node2D
class_name Level


onready var physic_ground = $PhysicGround
onready var setterparallaxGround : ParallaxBackground = $SetterParallaxBackground
onready var enemySpawner : Position2D = $EnemySpawner
onready var finishing : bool = false
onready var enemy_spawner : Position2D = $EnemySpawner
onready var loot_manager : Node2D = $LootManager
onready var gui : Control = $GUI
onready var pasue_menu : Control = $PauseMenu

onready var game_save_file : Dictionary = Globals.current_game.duplicate()


var current_wave : int
var current_loot : int
var wave_loot : int
var ground_speed : int = -30


func _ready() -> void:
	get_vars()
	# print(str(game_save_file))

	setterparallaxGround.set_background()
	physic_ground.constant_linear_velocity.x = ground_speed

	gui.first_call($Player/CoreComponent.get_stats().life)
	gui.set_loot(current_loot)

	enemy_spawner.set_wave(current_wave)
	enemy_spawner.spawn_enemies()


func get_vars() -> void:
	current_wave = game_save_file.game_info.wave
	current_loot = game_save_file.game_info.loot
	wave_loot = game_save_file.game_info.loot


# Esta funcion empieza a sobrar
func _on_MataSobras5000_body_exited(body : Node) -> void:
	print(str(body) + ' has been deleted from existence')
	body.queue_free()


# Llamado por el AnimationPlayer
func start_game() -> void:
	setterparallaxGround.get_child(0).set_paraspeed(ground_speed)


# Llamado cuando el jugador manda la señal morido
func finish_game() -> void:
	pasue_menu.queue_free()
	$GameOverUI.visible = true
	$Accelerator/AnimationPlayer.play_backwards('accelerate')
	set_propetys()


func _on_Accelerator_value_changed(value : float) -> void:
	physic_ground.constant_linear_velocity.x = ground_speed * value
	setterparallaxGround.get_child(0).set_paraspeed(ground_speed * value)


func set_propetys() -> void:
	Globals.set_game_data("loot", wave_loot)
	Globals.set_game_data("wave", current_wave)
	Globals.save_data_to_file()


# FUNCIONES con EnemySpawner-----------------------------------------
func _on_EnemySpawner_generate_loot(loot_position : Vector2) -> void:
	var loot_quantity : int = randi() % 5 + 1
	loot_manager.generate_loot(loot_position, loot_quantity)
	gui.set_loot(loot_quantity)


func _on_EnemySpawner_wave_ended() -> void:
	wave_loot = gui.get_loot()
	current_wave = enemy_spawner.get_wave()


# FUNCIONES con PauseMenuUI---------------------------------------------
func _on_PauseMenu_save_time() -> void:
	set_propetys()
	get_tree().change_scene('res://UIs/MenuScene.tscn')


# FUNCIONES con GameOverUI----------------------------------------------
func _on_GameOverUI_shop_pressed():
	pass # Replace with function body.


func _on_GameOverUI_retry_pressed():
	get_tree().reload_current_scene()


func _on_GameOverUI_return_pressed():
	get_tree().change_scene('res://UIs/MenuScene.tscn')

