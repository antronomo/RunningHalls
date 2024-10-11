extends Node2D


@onready var physic_ground : StaticBody2D = $PhysicGround
@onready var setterparallaxGround : ParallaxBackground = $SetterParallaxBackground
@onready var enemy_spawner : Marker2D = $EnemySpawner
@onready var loot_manager : Node2D = $LootManager
@onready var gui : CanvasLayer = $GUI
@onready var pause_menu : Control = $PauseMenu
@onready var shop_ui : Control = $Shop
@onready var game_over_ui : Control = $GameOverUI
@onready var accelerator : AnimationPlayer = $Accelerator/AnimationPlayer
@onready var player : Node2D = $Player
@onready var game_finished_ui : Control = $GameFinished
@onready var level_animation_player : AnimationPlayer = $AnimationPlayer
@onready var back_ground_music : AudioStreamPlayer = $BackGroundMusic
@onready var options_menu : Control = $OptionsMenu
@onready var button_fx : AudioStreamPlayer = $ButtonFX


const gearbox : Array[int] = [-32, -48, -72]
const out_of_viewport : Vector2 = Vector2(0, -192)


var ground_speed : int # la variable que controla la velocidad del suelo y fondo
var current_wave : int
var gold : int


func _ready() -> void:
	setup_game()
	enemy_spawner._on_EnemySpawner_enemy_list_ended()
	options_menu.get_node("TabContainer").current_tab = 1


func setup_game() -> void:
	get_updated_vars()
	gui.update_gold_label(gold)
	
	Globals.set_game_data("tries", Globals.current_game.game_info.tries + 1)
	
	shop_ui.position = out_of_viewport # Esto para cuando le das al "retry"
	
	pause_menu.callable = true
	update_player_hp_bar()
	
	level_animation_player.stop()
	level_animation_player.play("Starting")


func update_player_hp_bar() -> void:
	await player.get_node("CoreComponent").player_stats_updated
	var new_hp : int = player.get_node("CoreComponent").get_stats().life
	gui.first_call(new_hp)


func get_updated_vars() -> void:
	current_wave = Globals.current_game.game_info.wave
	gold = Globals.current_game.game_info.gold
	
	ground_speed = gearbox[Globals.config_data.time_speed]


# Esto será utilizado para eliminar cofres no abiertos
func _on_MataSobras5000_body_exited(body : Node) -> void:
	print(str(body) + " has been deleted from existence")
	body.queue_free()


# Llamado por el AnimationPlayer
func start_game() -> void:
	setterparallaxGround.set_parallax_speed(ground_speed)
	physic_ground.constant_linear_velocity.x = ground_speed
	enemy_spawner.work = true


# Llamado cuando el jugador manda la señal morido
func finish_game() -> void: # el nombre no es coherente, es porque lleva mucho tiempo...
	level_animation_player.pause()
	accelerator.play_backwards("accelerate")
	enemy_spawner.work = false
	pause_menu.callable = false
	gui.hide()
	set_propetys()
	
	await game_over_ui.coin_label_updater()
	game_over_ui.position = Vector2.ZERO
	game_over_ui.appear_animation()


# Esta funcion fue JUSTO antes de saber de la existencia de tweens
func _on_Accelerator_value_changed(value : float) -> void:
	physic_ground.constant_linear_velocity.x = ground_speed * value
	#setterparallaxGround.get_child(0).set_paraspeed(ground_speed * value)
	setterparallaxGround.set_parallax_speed(ground_speed * value)


func set_propetys() -> void:
	Globals.set_game_data("wave", current_wave)
	Globals.set_game_data("gold", gold)


# Llamado cuando un jefe a sido derrotado
func _on_enemy_spawner_hand_defeated() -> void:
	#print("woa a eliminar pause menu")
	accelerator.play_backwards("accelerate")
	await get_tree().create_timer(1.5).timeout
	player.stop_anim()
	set_propetys()
	enemy_spawner.work = false
	
	# UI FINAL DE VICTORIA
	@warning_ignore("redundant_await") # si funciona y sí es necesário
	await _on_hand_deleted() # El jefe manda una señal antes de morir
	pause_menu.callable = false
	game_finished_ui.position = Vector2.ZERO
	game_finished_ui.visible = true
	gui.hide()


# se supone que debe esperar a que el audio termine para lanzar esta función vacía
func _on_hand_deleted() -> void: pass


# Speed Buttnos, su propósito es ajustar la velocidad en la que transcurre el juego
func _on_speed_button_pressed(number : int = Globals.config_data.time_speed) -> void:
	match number:
		0:
			Globals.set_config_data("time_speed", 1)
			ground_speed = gearbox[1]
			
		1:
			Globals.set_config_data("time_speed", 2)
			ground_speed = gearbox[2]
			
		2:
			Globals.set_config_data("time_speed", 0)
			ground_speed = gearbox[0]
			
		_:
			push_warning("Error at changing speed")
	
	# Si le das cuando hace la animación de empezar/re-aparacer puedes activar el suelo y fondo antes de tiempo
	physic_ground.constant_linear_velocity.x = ground_speed
	setterparallaxGround.set_parallax_speed(ground_speed)


func check_bg() -> void: 
	if current_wave == 33:
		setterparallaxGround.set_transicion("cave")
	elif current_wave == 66:
		setterparallaxGround.set_transicion("sewer")


#region FUNCIONES con EnemySpawner--------------------------------------------
func _on_EnemySpawner_generate_loot(loot_position : Vector2) -> void:
	@warning_ignore("integer_division")
	var loot_quantity : int = current_wave + int(randi() % current_wave + (current_wave / 2))
	loot_manager.generate_loot(loot_position)
	gold = gold + loot_quantity
	Globals.set_game_data("total_gold", Globals.current_game.game_info.total_gold + loot_quantity)
	set_propetys()
	gui.update_gold_label(gold)


# Señal conectada por código, no recuerdo la razón
func _on_EnemySpawner_wave_increased(new_wave) -> void: 
	current_wave = new_wave
	check_bg()
	set_propetys()
#endregion


#region FUNCIONES con PauseMenuUI---------------------------------------------
func _on_PauseMenu_save_time() -> void:
	back_ground_music.playing = false
	set_propetys()
	get_tree().change_scene_to_file("res://UIs/MenuScene.tscn")


func _on_pause_button_pressed() -> void:
	pause_menu.toggler_pauser()


func _on_pause_menu_pause_option_pressed() -> void:
	gui.hide()
	pause_menu.position = out_of_viewport
	options_menu.position = Vector2.ZERO
#endregion


#region FUNCIONES con GameOverUI----------------------------------------------
func _on_GameOverUI_shop_pressed() -> void:
	shop_ui.gold_update()
	shop_ui.position = Vector2.ZERO
	game_over_ui.position = out_of_viewport


func _on_GameOverUI_retry_pressed() -> void:
	accelerator.play("RESET")
	game_over_ui.position = out_of_viewport
	gui.show()
	setup_game()


func _on_GameOverUI_return_pressed() -> void:
	get_tree().change_scene_to_file("res://UIs/MenuScene.tscn")


func _on_game_over_ui_options_pressed() -> void:
	options_menu.position = Vector2.ZERO
	game_over_ui.position = out_of_viewport


func _on_game_over_ui_anything_pressed() -> void:
	button_fx.play()
#endregion


#region FUNCIONES con ShopUI--------------------------------------------------
func _on_Shop_exiting() -> void:
	get_updated_vars()
	gui.update_gold_label(gold)
	shop_ui.position = out_of_viewport
	game_over_ui.coin_label_updater()
	game_over_ui.position = Vector2.ZERO


func _on_shop_anything_pressed() -> void:
	button_fx.play()
#endregion


#region FUNCIONES con OptionsMenu --------------------------------------------
func _on_return_button_pressed() -> void:
	options_menu.position = out_of_viewport
	if pause_menu.callable:
		pause_menu.position = Vector2.ZERO
		gui.show()
	else:
		game_over_ui.position = Vector2.ZERO
#endregion
