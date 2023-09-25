extends Node


const coin : PackedScene = preload("res://Components/Coin.tscn")


var current_game : Dictionary = {}
# var config_data : Dictionary = {}


func _ready() -> void:
	randomize()

	current_game = CurrentGame.load_game()
	# Config.load_data()


func _input(event) -> void:
	if event.is_action_pressed("infor"):
		print(str(current_game.duplicate()))


# FUNCIONES CON CurrentGame.gd
func reset_game_data() -> void:
	current_game = CurrentGame.new_game().duplicate()
	save_data_to_file()


func save_data_to_file() -> void:
	CurrentGame.save_game_data(current_game)
	current_game = CurrentGame.load_game()


# FUNCIONES que usan la variable current_game
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

		_: # Default
			print("ERROR TRYING TO SAVE " + what + " with: " + str(much) + "!!!")


# FUNCIONES CON Config.gd
func save_new_config() -> void:pass


func set_default_config() -> void:pass

