extends Node


var saved_wave : int
var current_game : Dictionary = {}
# var config_data : Dictionary = {}


func _ready() -> void:
	randomize()
	current_game = CurrentGame.load_game()
	
	#Esto es demasiado importante y lo necesito accesible
	saved_wave = current_game.game_info.wave #!


func _input(event) -> void:
	if event.is_action_pressed("infor"):
		print(JSON.stringify(current_game.duplicate(), "\t"))


# FUNCIONES CON CurrentGame.gd -------------------------------------------------------------
func reset_game_data() -> void:
	current_game = CurrentGame.new_game().duplicate()
	save_data_to_file()

	saved_wave = current_game.game_info.wave #!


func save_data_to_file() -> void:
	CurrentGame.save_game_data(current_game)
	current_game = CurrentGame.load_game()

	saved_wave = current_game.game_info.wave #!


# FUNCIONES que modifican variables en current_game ----------------------------------------
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
func save_new_config() -> void:pass


func set_default_config() -> void:pass

