extends Node


var current_game : Dictionary = {}
var config_data : Dictionary = {}


func _ready() -> void:
	randomize()
	current_game = CurrentGame.load_game()
	config_data = Config.load_conf_data()
	
	if !current_game.game_info.has("game_version") or \
	current_game.game_info.game_version != CurrentGame.CURRENTVERSION:
		print("save file and game version are different, to avoid problems, will be resetted")
		CurrentGame.new_game()
		current_game = CurrentGame.load_game()
		
		Config.to_default_data()
		config_data = Config.load_conf_data()
	
	set_audiostreamplayers()


func _notification(what : int) -> void:
	match what:
		NOTIFICATION_WM_CLOSE_REQUEST:
			#print("cerrando windows")
			save_data_to_file()
			save_config_to_file()
		
		NOTIFICATION_WM_GO_BACK_REQUEST:
			#print("cerrando android")
			save_data_to_file()
			save_config_to_file()


func _input(event) -> void:
	if event.is_action_pressed("infor"):
		print(JSON.stringify(current_game, "\t"))


func set_audiostreamplayers() -> void:
	AudioServer.set_bus_volume_db(1, linear_to_db(config_data.voice_volume))
	AudioServer.set_bus_volume_db(2, linear_to_db(config_data.sfx_volume))
	AudioServer.set_bus_volume_db(3, linear_to_db(config_data.music_volume))


#region FUNCIONES CON CurrentGame.gd -------------------------------------------------------------
func reset_game_data() -> void:
	current_game = CurrentGame.new_game()
	save_data_to_file()


func save_data_to_file() -> void:
	CurrentGame.save_game_data(current_game)
	current_game = CurrentGame.load_game()


# Es necesario verificar el tipo de variable? por ahora no, pero tampoco lo voy a aquitar
func set_game_data(what : String, with) -> void:
	match what:
		"wave":
			if typeof(with) == TYPE_INT:
				current_game.game_info.wave = with
			else:
				push_error("cannot save " + what + " with: " + str(with))
				
		"gold":
			if typeof(with) == TYPE_INT:
				current_game.game_info.gold = with
			else:
				push_error("cannot save " + what + " with: " + str(with))
				
		"total_gold":
			if typeof(with) == TYPE_INT:
				current_game.game_info.total_gold = with
			else:
				push_error("cannot save " + what + " with: " + str(with))
				
		"tries" : 
			if typeof(with) == TYPE_INT:
				current_game.game_info.tries = with
			else:
				push_error("cannot save " + what + " with: " + str(with))
				
		"helmet":
			if typeof(with) == TYPE_INT:
				current_game.player_upgrades.helmet = with
			else:
				push_error("cannot save " + what + " with: " + str(with))
				
		"chest_plate":
			if typeof(with) == TYPE_INT:
				current_game.player_upgrades.chest_plate = with
			else:
				push_error("cannot save " + what + " with: " + str(with))
				
		"greaves":
			if typeof(with) == TYPE_INT:
				current_game.player_upgrades.greaves = with
			else:
				push_error("cannot save " + what + " with: " + str(with))
				
		"boots":
			if typeof(with) == TYPE_INT:
				current_game.player_upgrades.boots = with
			else:
				push_error("cannot save " + what + " with: " + str(with))
				
		"sword":
			if typeof(with) == TYPE_INT:
				current_game.player_upgrades.sword = with
			else:
				push_error("cannot save " + what + " with: " + str(with))
				
		"shield":
			if typeof(with) == TYPE_INT:
				current_game.player_upgrades.shield = with
			else:
				push_error("cannot save " + what + " with: " + str(with))
				
		_: # Default
			push_error(what + " not found")
#endregion


#region FUNCIONES con Config.gd ------------------------------------------------------------------
func resset_config_data() -> void:
	config_data = Config.to_default_data()
	save_config_to_file()


func save_config_to_file() -> void:
	Config.save_conf_data(config_data)
	config_data = Config.load_conf_data()


func set_config_data(what : String, with) -> void:
	match what:
		"master_volume":
			if typeof(with) == TYPE_FLOAT:
				push_error(what + "not config yet")
			else:
				push_error("cannot save " + what + " with: " + str(with))
				
		"music_volume":
			if typeof(with) == TYPE_FLOAT:
				config_data.music_volume = with
				set_audiostreamplayers()
			else:
				push_error("cannot save " + what + " with: " + str(with))
				
		"sfx_volume":
			if typeof(with) == TYPE_FLOAT:
				config_data.sfx_volume = with
				set_audiostreamplayers()
			else:
				push_error("cannot save " + what + " with: " + str(with))
				
		"voice_volume":
			if typeof(with) == TYPE_FLOAT:
				config_data.voice_volume = with
				set_audiostreamplayers()
			else:
				push_error("cannot save " + what + " with: " + str(with))
				
		"window_fullscreen":
			if typeof(with) == TYPE_BOOL:
				push_error(what + "not config yet")
			else:
				push_error("cannot save " + what + " with: " + str(with))
				
		"enemies_lock_rotation":
			if typeof(with) == TYPE_BOOL:
				config_data.enemies_lock_rotation = with
			else:
				push_error("cannot save " + what + " with: " + str(with))
				
		"time_speed":
			if typeof(with) == TYPE_INT:
				config_data.time_speed = with
			else:
				push_error("cannot save " + what + " with: " + str(with))
				
		_: # Default
			push_error(what + " not found") 
#endregion
