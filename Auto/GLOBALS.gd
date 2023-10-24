extends Node


var current_game : Dictionary = {}
# var config_data : Dictionary = {}


func _ready() -> void:
	randomize()

	current_game = CurrentGame.load_game()


func _input(event) -> void:
	if event.is_action_pressed("infor"):
		print(str(current_game.duplicate()))


# FUNCIONES CON CurrentGame.gd -------------------------------------------------------
func reset_game_data() -> void:
	current_game = CurrentGame.new_game().duplicate()
	save_data_to_file()


func save_data_to_file() -> void:
	CurrentGame.save_game_data(current_game)
	current_game = CurrentGame.load_game()


# FUNCIONES que modifican la variable current_game ----------------------------------------
func set_game_data(what:String, much) -> void:
	match what:
		"wave":
			if typeof(much) == TYPE_INT:
				current_game.game_info.wave = much
			else:
				print(str(much) + " no es tipo Int")

		"loot":
			if typeof(much) == TYPE_INT:
				current_game.game_info.loot = much
			else:
				print(str(much) + " no es tipo Int")

		"helmet":
			if typeof(much) == TYPE_INT:
				current_game.player_upgrades.helmet = much
			else:
				print("cannot save helmet with: " + str(much))
		
		"chestPlate":
			if typeof(much) == TYPE_INT:
				current_game.player_upgrades.chestPlate = much
			else:
				print("cannot save chestPlate with: " + str(much))

		"greaves":
			if typeof(much) == TYPE_INT:
				current_game.player_upgrades.greaves = much
			else:
				print("cannot save greaves with: " + str(much))

		"boots":
			if typeof(much) == TYPE_INT:
				current_game.player_upgrades.boots = much
			else:
				print("cannot save boots with: " + str(much))

		"sword":
			if typeof(much) == TYPE_INT:
				current_game.player_upgrades.sword = much
			else:
				print("cannot save sword with: " + str(much))
		
		"shield":
			if typeof(much) == TYPE_INT:
				current_game.player_upgrades.shield = much
			else:
				print("cannot save shield with: " + str(much))

		_: # Default
			print(what + " does not exist")


# FUNCIONES con Config.gd ------------------------------------------------------------
func save_new_config() -> void:pass


func set_default_config() -> void:pass

