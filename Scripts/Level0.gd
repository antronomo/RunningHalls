extends Node2D


onready var physic_ground : StaticBody2D = $PhysicGround
onready var setterparallaxGround : ParallaxBackground = $SetterParallaxBackground
onready var finishing : bool = false
onready var enemy_spawner : Position2D = $EnemySpawner
onready var loot_manager : Node2D = $LootManager
onready var gui : Control = $GUI
onready var pasue_menu : Control = $PauseMenu
onready var game_save_file : Dictionary
onready var shop_ui : Control = $Shop
onready var game_over_ui : Control = $GameOverUI


const ground_speed : int = -30


var current_wave : int
var current_gold : int
var saved_gold : int # El oro que te quedas cuando terminas una oleada de enemigos


func _ready() -> void:
	get_vars()
	# print(str(game_save_file))
	
	setterparallaxGround.set_background()
	physic_ground.constant_linear_velocity.x = ground_speed
	
	gui.first_call($Player/CoreComponent.get_stats().life)
	gui.update_gold_label(current_gold)
	
	# enemy_spawner.set_wave(current_wave)
	enemy_spawner.spawn_enemies()
	
	shop_ui.rect_position = Vector2(0, -135)


func get_vars() -> void:
	game_save_file = Globals.current_game.duplicate()
	
	current_wave = game_save_file.game_info.wave
	current_gold = game_save_file.game_info.gold
	saved_gold = current_gold


# Esto empieza a sobrar
func _on_MataSobras5000_body_exited(body : Node) -> void:
	print(str(body) + " has been deleted from existence")
	body.queue_free()


# Llamado por el AnimationPlayer
func start_game() -> void:
	setterparallaxGround.get_child(0).set_paraspeed(ground_speed)


# Llamado cuando el jugador manda la señal morido
func finish_game() -> void:
	pasue_menu.queue_free()
	$GameOverUI.visible = true
	$Accelerator/AnimationPlayer.play_backwards("accelerate")
	set_propetys()
	enemy_spawner.work = false
	yield(get_tree().create_timer(0.1), "timeout")# Solucion temporal: al morir el oro actualiza dos veces
	gui.update_gold_label(saved_gold)


# Esta funcion fue JUSTO antes de saber de la existencia de tweens
func _on_Accelerator_value_changed(value : float) -> void:
	physic_ground.constant_linear_velocity.x = ground_speed * value
	setterparallaxGround.get_child(0).set_paraspeed(ground_speed * value)


func set_propetys() -> void:
	Globals.set_game_data("gold", saved_gold)
	Globals.set_game_data("wave", current_wave)
	Globals.save_data_to_file()


# FUNCIONES con EnemySpawner--------------------------------------------
func _on_EnemySpawner_generate_loot(loot_position : Vector2) -> void:
	var loot_quantity : int = current_wave + int(randi() % current_wave + (current_wave / 2))
	loot_manager.generate_loot(loot_position, loot_quantity)
	current_gold = current_gold + loot_quantity
	gui.update_gold_label(current_gold)
	set_propetys()


func _on_EnemySpawner_enemy_died() -> void:
	saved_gold = current_gold
	current_wave = enemy_spawner.get_wave()
	set_propetys()

	# print("next wave: " + str(current_wave))


# FUNCIONES con PauseMenuUI---------------------------------------------
func _on_PauseMenu_save_time() -> void:
	set_propetys()
	get_tree().change_scene("res://UIs/MenuScene.tscn")


# FUNCIONES con GameOverUI----------------------------------------------
func _on_GameOverUI_shop_pressed() -> void:
	shop_ui.gold_update()
	shop_ui.rect_position = Vector2.ZERO
	game_over_ui.rect_position = Vector2(40, -1000)


func _on_GameOverUI_retry_pressed() -> void:
	get_tree().reload_current_scene()


func _on_GameOverUI_return_pressed() -> void:
	get_tree().change_scene("res://UIs/MenuScene.tscn")


# FUNCIONES con ShopUI--------------------------------------------------
func _on_Shop_exiting() -> void:
	get_vars()
	gui.update_gold_label(current_gold)
	shop_ui.rect_position = Vector2(0, -135)
	game_over_ui.rect_position = Vector2(40, 16)
