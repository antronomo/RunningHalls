extends Node


var saved_wave : int
var current_game : Dictionary = {}
var config_data : Dictionary = {}


func _ready() -> void:
	randomize()
	current_game = CurrentGame.load_game()
	config_data = Config.load_conf_data()
	
	if !current_game.has("game_version") or \
		current_game.game_info.current_version != CurrentGame.game_info.DEFAULTGAMEDATA.current_version:
		print("save file and game version are different, to avoid problems, will be resetted")
		CurrentGame.new_game()
		Config.to_default_data()
		
		current_game = CurrentGame.load_game()
		config_data = Config.load_conf_data()
	
	#Esto es demasiado importante y lo necesito accesible
	saved_wave = current_game.game_info.wave #!
	
	set_audiostreamplayers()


func _input(event) -> void:
	if event.is_action_pressed("infor"):
		print(JSON.stringify(current_game, "\t"))


# FUNCIONES CON CurrentGame.gd -------------------------------------------------------------
func reset_game_data() -> void:
	current_game = CurrentGame.new_game()
	save_data_to_file()

	saved_wave = current_game.game_info.wave #!


func save_data_to_file() -> void:
	CurrentGame.save_game_data(current_game)
	current_game = CurrentGame.load_game()

	saved_wave = current_game.game_info.wave #!


# Es necesario verificar el tipo de variable? por ahora no, pero tampoco lo voy a aquitar
func set_game_data(what : String, with) -> void:
	match what:
		"wave":
			if typeof(with) == TYPE_INT:
				current_game.game_info.wave = with
			else:
				print("cannot save " + what + " with: " + str(with))
		
		"gold":
			if typeof(with) == TYPE_INT:
				current_game.game_info.gold = with
			else:
				print("cannot save " + what + " with: " + str(with))
		
		"gains" : 
			if typeof(with) == TYPE_INT:
				current_game.game_info.gains = with
			else:
				print("cannot save " + what + " with: " + str(with))
		
		"tries" : 
			if typeof(with) == TYPE_INT:
				current_game.game_info.tries = with
			else:
				print("cannot save " + what + " with: " + str(with))
		
		"helmet":
			if typeof(with) == TYPE_INT:
				current_game.player_upgrades.helmet = with
			else:
				print("cannot save " + what + " with: " + str(with))
		
		"chestPlate":
			if typeof(with) == TYPE_INT:
				current_game.player_upgrades.chestPlate = with
			else:
				print("cannot save " + what + " with: " + str(with))
		
		"greaves":
			if typeof(with) == TYPE_INT:
				current_game.player_upgrades.greaves = with
			else:
				print("cannot save " + what + " with: " + str(with))
		
		"boots":
			if typeof(with) == TYPE_INT:
				current_game.player_upgrades.boots = with
			else:
				print("cannot save " + what + " with: " + str(with))
		
		"sword":
			if typeof(with) == TYPE_INT:
				current_game.player_upgrades.sword = with
			else:
				print("cannot save " + what + " with: " + str(with))
		
		"shield":
			if typeof(with) == TYPE_INT:
				current_game.player_upgrades.shield = with
			else:
				print("cannot save " + what + " with: " + str(with))
		
		_: # Default
			print(what + " not found")


# FUNCIONES con Config.gd ------------------------------------------------------------------
func resset_config_data() -> void:
	config_data = Config.to_default_data()
	save_config_to_file()


func save_config_to_file() -> void:
	Config.save_conf_data(config_data)
	config_data = Config.load_conf_data()
	

func set_audiostreamplayers() -> void:
	AudioServer.set_bus_volume_db(1, linear_to_db(config_data.voice_volume))


# Funcion completamente inutil, creo que porque estoy pasando los diccionarios
# sin el .duplicate() y de algún modo se sobre-escribre
# en todas las variables con ese diccionario
# pero en set_game_data() si es necesario, no entiendo porqué
func set_config_data(what : String, with) -> void:
	match what:
		"master_volume":
			if typeof(with) == TYPE_FLOAT:
				print(what + "not config yet")
			else:
				print("cannot save " + what + " with: " + str(with))
		
		"music_volume":
			if typeof(with) == TYPE_FLOAT:
				print(what + "not config yet")
			else:
				print("cannot save " + what + " with: " + str(with))
		
		"sfx_volume":
			if typeof(with) == TYPE_FLOAT:
				print(what + "not config yet")
			else:
				print("cannot save " + what + " with: " + str(with))
		
		"voice_volume":
			if typeof(with) == TYPE_FLOAT:
				config_data.voice_volume = with
				set_audiostreamplayers()
			else:
				print("cannot save " + what + " with: " + str(with))
		
		"window_fullscreen":
			if typeof(with) == TYPE_BOOL:
				print(what + "not config yet")
			else:
				print("cannot save " + what + " with: " + str(with))
		
		"enemies_lock_rotation":
			if typeof(with) == TYPE_BOOL:
				config_data.enemies_lock_rotation = with
			else:
				print("cannot save " + what + " with: " + str(with))
		
		"time_speed":
			if typeof(with) == TYPE_INT:
				config_data.time_speed = with
			else:
				print("cannot save " + what + " with: " + str(with))
		
		_: # Default
			print(what + " not found") 

